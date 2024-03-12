use std::fs::File;
use std::io::Read;
use std::net::Ipv4Addr;
use std::str::FromStr;

use anyhow::{anyhow, Result};
use chrono::Duration;
use der::asn1::{Ia5String, OctetString};
use der::pem::LineEnding;
use der::referenced::OwnedToRef;
use der::{DecodePem, Encode, EncodePem};
use pkcs8::EncodePrivateKey;
use rand::random;
use regex::Regex;
use signature::Keypair;
use spki::{EncodePublicKey, SubjectPublicKeyInfoOwned};
use x509_cert::builder::{Builder, CertificateBuilder, Profile};
use x509_cert::ext::pkix::name::GeneralName::{DnsName, IpAddress};
use x509_cert::ext::pkix::SubjectAltName;
use x509_cert::name::Name;
use x509_cert::serial_number::SerialNumber;
use x509_cert::time::Validity;
use x509_cert::Certificate;

use crate::crypto;
use crate::crypto::SigningKey;

use crate::api::simple::{
    CertData, CertFiles, CertProfile, Cipher, EcdsaCurve, Issuer, KeyFormat, SubjectRdn,
};

pub fn gen_tls_cert(
    cert_profile: CertProfile,
    domain_names: Option<Vec<String>>,
    subject: Vec<SubjectRdn>,
    issuer: Issuer,
    cipher: Cipher,
    validity: u32,
    format: KeyFormat,
) -> Result<CertData> {
    let private_key = gen_signing_key(cipher);
    let pub_key = private_key.verifying_key();

    let pub_key = SubjectPublicKeyInfoOwned::try_from(pub_key.to_public_key_der()?.as_bytes())?;
    let subject = subject
        .iter()
        .map(|rdn| {
            let re = Regex::new(r"(^#|\+|,|\\)").unwrap();
            let value = re.replace_all(rdn.value.trim(), r"\$1");
            format!("{}={}", rdn.name, value)
        })
        .collect::<Vec<_>>()
        .join(",");
    let subject = Name::from_str(&subject).map_err(|_| anyhow!("invalid subject"))?;

    let (issuer_subject, signing_key) = match issuer {
        Issuer::CertSelf => (subject.clone(), private_key.clone()),
        Issuer::CA(CertFiles {
                       cert_path,
                       key_path,
                   }) => decode_cert(&cert_path, &key_path)?,
    };

    let profile = match cert_profile {
        CertProfile::Client => Profile::Leaf {
            issuer: issuer_subject,
            enable_key_agreement: true,
            enable_key_encipherment: true,
        },
        CertProfile::Server => Profile::Leaf {
            issuer: issuer_subject,
            enable_key_agreement: true,
            enable_key_encipherment: true,
        },
        CertProfile::RootCA => Profile::Root,
        CertProfile::SubCA => Profile::SubCA {
            issuer: issuer_subject,
            path_len_constraint: None, // TODO: user provided
        },
    };

    let serial_number = gen_serial_number();
    let validity = Validity::from_now(Duration::days(validity.into()).to_std()?)?;

    let mut builder = CertificateBuilder::new(
        profile,
        serial_number,
        validity,
        subject,
        pub_key,
        &signing_key,
    )?;

    if cert_profile == CertProfile::Server {
        // TODO: filter out invalid names
        let domain_names: Vec<_> = domain_names
            .unwrap()
            .iter()
            .map(|name| {
                let ip_re = Regex::new(r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$").unwrap();
                if ip_re.is_match(name) {
                    IpAddress(
                        OctetString::new(Ipv4Addr::from_str(&name).unwrap().octets()).unwrap(),
                    )
                } else {
                    DnsName(Ia5String::new(name).unwrap())
                }
            })
            .collect();
        builder.add_extension(&SubjectAltName(domain_names))?;
    }

    let cert = builder.build()?;

    let (cert, private_key) = match format {
        KeyFormat::Pem => (
            cert.to_pem(LineEnding::LF).unwrap().into_bytes(),
            private_key
                .to_pkcs8_pem(LineEnding::LF)
                .unwrap()
                .as_bytes()
                .to_vec(),
        ),
        KeyFormat::Der => (
            cert.to_der().unwrap(),
            private_key.to_pkcs8_der().unwrap().to_bytes().to_vec(),
        ),
    };

    Ok(CertData {
        cert,
        key: private_key,
    })
}

fn gen_serial_number() -> SerialNumber {
    let mut bytes = random::<[u8; 20]>();
    bytes[0] &= 0x7f;

    SerialNumber::new(&bytes).unwrap()
}

fn gen_signing_key(cipher: Cipher) -> SigningKey {
    match cipher {
        Cipher::Rsa(key_size) => match key_size {
            4096 => SigningKey::RsaSha512(crypto::rsa::gen_signing_key(key_size)),
            _ => SigningKey::RsaSha256(crypto::rsa::gen_signing_key(key_size)),
        },
        Cipher::Ecdsa(curve) => match curve {
            EcdsaCurve::P224 => SigningKey::EcdsaP224(crypto::ecdsa::gen_signing_key()),
            EcdsaCurve::P256 => SigningKey::EcdsaP256(crypto::ecdsa::gen_signing_key()),
            EcdsaCurve::P384 => SigningKey::EcdsaP384(crypto::ecdsa::gen_signing_key()),
        },
    }
}

fn decode_cert(cert_path: &str, key_path: &str) -> Result<(Name, SigningKey)> {
    let mut file = File::open(cert_path)?;
    let mut cert_data = Vec::new();
    file.read_to_end(&mut cert_data)?;

    let mut file = File::open(key_path)?;
    let mut key_data = Vec::new();
    file.read_to_end(&mut key_data)?;

    let cert = Certificate::from_pem(cert_data).unwrap();
    let key = SigningKey::from_pem(
        &String::from_utf8(key_data)?,
        cert.tbs_certificate
            .subject_public_key_info
            .algorithm
            .owned_to_ref(),
    )?;

    Ok((cert.tbs_certificate.subject, key))
}
