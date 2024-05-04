use std::net::Ipv4Addr;
use std::str::FromStr;

use anyhow::{anyhow, Result};
use chrono::Duration;
use const_oid::db::rfc5280::{ID_KP_CLIENT_AUTH, ID_KP_SERVER_AUTH};
use der::asn1::{Ia5String, OctetString};
use der::pem::LineEnding;
use der::referenced::OwnedToRef;
use der::EncodePem;
use pkcs8::EncodePrivateKey;
use rand::random;
use signature::Keypair;
use spki::{EncodePublicKey, SubjectPublicKeyInfoOwned};
use x509_cert::builder::{Builder, CertificateBuilder, Profile};
use x509_cert::ext::pkix::name::GeneralName::{DnsName, IpAddress};
use x509_cert::ext::pkix::{ExtendedKeyUsage, SubjectAltName};
use x509_cert::name::{Name, RdnSequence, RelativeDistinguishedName};
use x509_cert::serial_number::SerialNumber;
use x509_cert::time::Validity;
use x509_cert::Certificate;

use crate::api::simple::{CertPair, CertPairPem, EcdsaCurve, KeyCipher, Rdn};
use crate::crypto;
use crate::crypto::SigningKey;

pub fn gen_server_cert(
    subject: Vec<Rdn>,
    subject_alt_name: Vec<String>,
    key_cipher: KeyCipher,
    validity: i64,
    issuer: Option<CertPairPem>,
) -> Result<CertPairPem> {
    let subject = convert_subject(&subject)?;
    let issuer = match issuer {
        Some(issuer) => Some(convert_issuer(&issuer)?),
        None => None,
    };
    let issuer_subject = issuer
        .clone()
        .map(|issuer| issuer.chain.first().unwrap().tbs_certificate.subject.clone());

    let profile = Profile::Leaf {
        issuer: issuer_subject.unwrap_or(subject.clone()),
        enable_key_agreement: false,
        enable_key_encipherment: false,
    };

    let subject_alt_name = subject_alt_name
        .iter()
        .map(|name| match Ipv4Addr::from_str(name) {
            Ok(addr) => IpAddress(OctetString::new(addr.octets()).unwrap()),
            Err(_) => DnsName(Ia5String::new(name).unwrap()),
        })
        .collect::<Vec<_>>();
    let subject_alt_name = Some(SubjectAltName(subject_alt_name));

    gen_cert(
        profile,
        subject,
        key_cipher,
        validity,
        issuer,
        subject_alt_name,
    )
}

pub fn gen_client_cert(
    subject: Vec<Rdn>,
    key_cipher: KeyCipher,
    validity: i64,
    issuer: Option<CertPairPem>,
) -> Result<CertPairPem> {
    let subject = convert_subject(&subject)?;
    let issuer = match issuer {
        Some(issuer) => Some(convert_issuer(&issuer)?),
        None => None,
    };
    let issuer_subject = issuer
        .clone()
        .map(|issuer| issuer.chain.first().unwrap().tbs_certificate.subject.clone());

    let profile = Profile::Leaf {
        issuer: issuer_subject.unwrap_or(subject.clone()),
        enable_key_agreement: false,
        enable_key_encipherment: false,
    };

    gen_cert(profile, subject, key_cipher, validity, issuer, None)
}

pub fn gen_root_ca_cert(
    subject: Vec<Rdn>,
    key_cipher: KeyCipher,
    validity: i64,
) -> Result<CertPairPem> {
    let subject = convert_subject(&subject)?;

    let profile = Profile::Root;

    gen_cert(profile, subject, key_cipher, validity, None, None)
}

pub fn gen_sub_ca_cert(
    subject: Vec<Rdn>,
    key_cipher: KeyCipher,
    validity: i64,
    issuer: CertPairPem,
) -> Result<CertPairPem> {
    let subject = convert_subject(&subject)?;
    let issuer = convert_issuer(&issuer)?;
    let issuer_subject = issuer.chain.first().unwrap().tbs_certificate.subject.clone();

    let profile = Profile::SubCA {
        issuer: issuer_subject,
        path_len_constraint: None,
    };

    gen_cert(profile, subject, key_cipher, validity, Some(issuer), None)
}

fn gen_cert(
    profile: Profile,
    subject: Name,
    key_cipher: KeyCipher,
    validity: i64,
    issuer: Option<CertPair>,
    subject_alt_name: Option<SubjectAltName>,
) -> Result<CertPairPem> {
    let serial_number = gen_serial_number();
    let validity = Validity::from_now(Duration::try_days(validity).unwrap().to_std()?)?;
    let subject_key_pair = gen_signing_key(key_cipher);
    let subject_pub_key = SubjectPublicKeyInfoOwned::try_from(
        subject_key_pair
            .verifying_key()
            .to_public_key_der()?
            .as_bytes(),
    )?;
    let signing_key = issuer
        .clone()
        .map(|issuer| issuer.key)
        .unwrap_or(subject_key_pair.clone());

    let mut builder = CertificateBuilder::new(
        profile.clone(),
        serial_number,
        validity,
        subject,
        subject_pub_key,
        &signing_key,
    )?;

    if let Some(name) = subject_alt_name {
        builder.add_extension(&name)?;
    }

    match profile {
        Profile::Root => {}
        _ => {
            let extended_key_usage = ExtendedKeyUsage(vec![ID_KP_SERVER_AUTH, ID_KP_CLIENT_AUTH]);
            builder.add_extension(&extended_key_usage)?;
        }
    }

    let cert = builder.build()?;

    build_cert_pair(&cert, &subject_key_pair, &issuer)
}

fn gen_serial_number() -> SerialNumber {
    let bytes = random::<[u8; 19]>();

    SerialNumber::new(&bytes).unwrap()
}

fn convert_subject(subject: &Vec<Rdn>) -> Result<Name> {
    let mut rdn_seq = vec![];

    for rdn in subject {
        rdn_seq.push(RelativeDistinguishedName::from_str(
            format!("{}={}", rdn.rdn_type, rdn.value).as_str(),
        )?);
    }

    Ok(RdnSequence(rdn_seq))
}

fn gen_signing_key(cipher: KeyCipher) -> SigningKey {
    match cipher {
        KeyCipher::Rsa(key_size) => SigningKey::RsaSha256(crypto::rsa::gen_signing_key(key_size)),
        KeyCipher::Ecdsa(curve) => match curve {
            EcdsaCurve::P224 => SigningKey::EcdsaP224(crypto::ecdsa::gen_signing_key()),
            EcdsaCurve::P256 => SigningKey::EcdsaP256(crypto::ecdsa::gen_signing_key()),
            EcdsaCurve::P384 => SigningKey::EcdsaP384(crypto::ecdsa::gen_signing_key()),
        },
    }
}

fn convert_issuer(issuer: &CertPairPem) -> Result<CertPair> {
    let chain = Certificate::load_pem_chain(issuer.chain.as_bytes())?;
    let key = SigningKey::from_pem(
        &issuer.key,
        chain
            .first()
            .ok_or(anyhow!("invalid issuer certificate"))?
            .tbs_certificate
            .subject_public_key_info
            .algorithm
            .owned_to_ref(),
    )?;

    Ok(CertPair { chain, key })
}

fn build_cert_pair(
    cert: &Certificate,
    key: &SigningKey,
    issuer: &Option<CertPair>,
) -> Result<CertPairPem> {
    let cert = cert.to_pem(LineEnding::LF).unwrap();
    let key = key.to_pkcs8_pem(LineEnding::LF).unwrap().to_string();

    if let Some(issuer) = issuer {
        let mut chain = issuer
            .chain
            .iter()
            .filter_map(|cert| {
                // we don't need the Root CA certificate on the chain
                if cert.tbs_certificate.subject != cert.tbs_certificate.issuer {
                    Some(cert.to_pem(LineEnding::LF).unwrap())
                } else {
                    None
                }
            })
            .collect::<Vec<_>>();
        chain.insert(0, cert);
        let chain = chain.join("");
        Ok(CertPairPem { chain, key })
    } else {
        Ok(CertPairPem { chain: cert, key })
    }
}
