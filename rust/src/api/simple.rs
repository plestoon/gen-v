use anyhow::Result;
use strum_macros::Display;
use x509_cert::Certificate;

use crate::crypto::SigningKey;
use crate::tls;

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    flutter_rust_bridge::setup_default_user_utils();
}

#[derive(Debug, Clone, PartialEq)]
pub struct CertFiles {
    pub cert_path: String,
    pub key_path: String,
}

#[derive(Debug, Clone, PartialEq)]
pub struct CertPairPem {
    pub chain: String,
    pub key: String,
}

#[derive(Clone)]
pub(crate) struct CertPair {
    pub chain: Vec<Certificate>,
    pub key: SigningKey,
}

#[derive(Debug, Clone, PartialEq)]
pub enum EcdsaCurve {
    P224,
    P256,
    P384,
}

#[derive(Debug, Clone, PartialEq)]
pub enum KeyCipher {
    Rsa(usize),
    Ecdsa(EcdsaCurve),
    // Ed25519,
}

#[derive(Display)]
pub enum RdnType {
    CommonName,
    CountryName,
    StateOrProvinceName,
    LocalityName,
    OrganizationName,
    OrganizationalUnitName,
}

pub struct Rdn {
    pub rdn_type: RdnType,
    pub value: String,
}

pub fn gen_server_cert(
    subject: Vec<Rdn>,
    subject_alt_names: Vec<String>,
    key_cipher: KeyCipher,
    validity: i64,
    issuer: Option<CertPairPem>,
) -> Result<CertPairPem> {
    tls::gen::gen_server_cert(subject, subject_alt_names, key_cipher, validity, issuer)
}

pub fn gen_client_cert(
    subject: Vec<Rdn>,
    key_cipher: KeyCipher,
    validity: i64,
    issuer: Option<CertPairPem>,
) -> Result<CertPairPem> {
    tls::gen::gen_client_cert(subject, key_cipher, validity, issuer)
}

pub fn gen_root_ca_cert(
    subject: Vec<Rdn>,
    key_cipher: KeyCipher,
    validity: i64,
) -> Result<CertPairPem> {
    tls::gen::gen_root_ca_cert(subject, key_cipher, validity)
}

pub fn gen_sub_ca_cert(
    subject: Vec<Rdn>,
    key_cipher: KeyCipher,
    validity: i64,
    issuer: CertPairPem,
) -> Result<CertPairPem> {
    tls::gen::gen_sub_ca_cert(subject, key_cipher, validity, issuer)
}
