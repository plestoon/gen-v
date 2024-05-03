use ::rsa::pkcs8::DecodePrivateKey;
use anyhow::{anyhow, Result};
use const_oid::AssociatedOid;
use der::{Document, SecretDocument};
use der::asn1::BitString;
use p224::NistP224;
use p256::NistP256;
use p384::NistP384;
use pkcs8::EncodePrivateKey;
use sha2::Sha256;
use signature::{Keypair, Signer};
use spki::{
    AlgorithmIdentifierOwned, AlgorithmIdentifierRef, DynSignatureAlgorithmIdentifier,
    EncodePublicKey, SignatureBitStringEncoding,
};

pub mod ecdsa;
pub mod rsa;

pub enum Signature {
    RsaSignature(::rsa::pkcs1v15::Signature),
    EcdsaSignatureP224(::ecdsa::der::Signature<NistP224>),
    EcdsaSignatureP256(::ecdsa::der::Signature<NistP256>),
    EcdsaSignatureP384(::ecdsa::der::Signature<NistP384>),
}

impl SignatureBitStringEncoding for Signature {
    fn to_bitstring(&self) -> der::Result<BitString> {
        match self {
            Signature::RsaSignature(sig) => sig.to_bitstring(),
            Signature::EcdsaSignatureP224(sig) => sig.to_bitstring(),
            Signature::EcdsaSignatureP256(sig) => sig.to_bitstring(),
            Signature::EcdsaSignatureP384(sig) => sig.to_bitstring(),
        }
    }
}

#[derive(Clone)]
pub enum VerifyingKey {
    RsaSha256(::rsa::pkcs1v15::VerifyingKey<Sha256>),
    EcdsaP224(::ecdsa::VerifyingKey<NistP224>),
    EcdsaP256(::ecdsa::VerifyingKey<NistP256>),
    EcdsaP384(::ecdsa::VerifyingKey<NistP384>),
}

impl EncodePublicKey for VerifyingKey {
    fn to_public_key_der(&self) -> spki::Result<Document> {
        match self {
            VerifyingKey::RsaSha256(key) => key.to_public_key_der(),
            VerifyingKey::EcdsaP224(key) => key.to_public_key_der(),
            VerifyingKey::EcdsaP256(key) => key.to_public_key_der(),
            VerifyingKey::EcdsaP384(key) => key.to_public_key_der(),
        }
    }
}

#[derive(Clone)]
pub enum SigningKey {
    RsaSha256(::rsa::pkcs1v15::SigningKey<Sha256>),
    EcdsaP224(ecdsa::SigningKey<NistP224>),
    EcdsaP256(ecdsa::SigningKey<NistP256>),
    EcdsaP384(ecdsa::SigningKey<NistP384>),
}

impl SigningKey {
    pub fn from_pem(data: &str, algorithm: AlgorithmIdentifierRef) -> Result<Self> {
        match algorithm.oids()? {
            alg if alg == (::rsa::pkcs1::ALGORITHM_ID.oid, None) => {
                let key = ::rsa::RsaPrivateKey::from_pkcs8_pem(data)?;
                Ok(Self::RsaSha256(::rsa::pkcs1v15::SigningKey::<Sha256>::new(
                    key,
                )))
            }
            alg if alg == (elliptic_curve::ALGORITHM_OID, Some(NistP224::OID)) => {
                let key = p224::SecretKey::from_pkcs8_pem(data)?;
                Ok(Self::EcdsaP224(ecdsa::SigningKey::from(key)))
            }
            alg if alg == (elliptic_curve::ALGORITHM_OID, Some(NistP256::OID)) => {
                let key = p256::SecretKey::from_pkcs8_pem(data)?;
                Ok(Self::EcdsaP256(ecdsa::SigningKey::from(key)))
            }
            alg if alg == (elliptic_curve::ALGORITHM_OID, Some(NistP384::OID)) => {
                let key = p384::SecretKey::from_pkcs8_pem(data)?;
                Ok(Self::EcdsaP384(ecdsa::SigningKey::from(key)))
            }
            _ => Err(anyhow!("unsupported cipher")),
        }
    }
}

impl Signer<Signature> for SigningKey {
    fn try_sign(&self, msg: &[u8]) -> signature::Result<Signature> {
        match self {
            SigningKey::RsaSha256(key) => key.try_sign(msg).map(|sig| Signature::RsaSignature(sig)),
            SigningKey::EcdsaP224(key) => key
                .try_sign(msg)
                .map(|sig| Signature::EcdsaSignatureP224(sig)),
            SigningKey::EcdsaP256(key) => key
                .try_sign(msg)
                .map(|sig| Signature::EcdsaSignatureP256(sig)),
            SigningKey::EcdsaP384(key) => key
                .try_sign(msg)
                .map(|sig| Signature::EcdsaSignatureP384(sig)),
        }
    }
}

impl Keypair for SigningKey {
    type VerifyingKey = VerifyingKey;

    fn verifying_key(&self) -> Self::VerifyingKey {
        match self {
            SigningKey::RsaSha256(key) => VerifyingKey::RsaSha256(key.verifying_key().clone()),
            SigningKey::EcdsaP224(key) => VerifyingKey::EcdsaP224(key.verifying_key().clone()),
            SigningKey::EcdsaP256(key) => VerifyingKey::EcdsaP256(key.verifying_key().clone()),
            SigningKey::EcdsaP384(key) => VerifyingKey::EcdsaP384(key.verifying_key().clone()),
        }
    }
}

impl DynSignatureAlgorithmIdentifier for SigningKey {
    fn signature_algorithm_identifier(&self) -> spki::Result<AlgorithmIdentifierOwned> {
        match self {
            SigningKey::RsaSha256(key) => key.signature_algorithm_identifier(),
            SigningKey::EcdsaP224(key) => key.signature_algorithm_identifier(),
            SigningKey::EcdsaP256(key) => key.signature_algorithm_identifier(),
            SigningKey::EcdsaP384(key) => key.signature_algorithm_identifier(),
        }
    }
}

impl EncodePrivateKey for SigningKey {
    fn to_pkcs8_der(&self) -> pkcs8::Result<SecretDocument> {
        match self {
            SigningKey::RsaSha256(key) => key.to_pkcs8_der(),
            SigningKey::EcdsaP224(key) => key.to_pkcs8_der(),
            SigningKey::EcdsaP256(key) => key.to_pkcs8_der(),
            SigningKey::EcdsaP384(key) => key.to_pkcs8_der(),
        }
    }
}
