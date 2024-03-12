use anyhow::Result;
use crate::tls;

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    flutter_rust_bridge::setup_default_user_utils();
}

#[derive(Debug, Clone, PartialEq)]
pub enum KeyFormat {
    Pem,
    Der,
}

#[derive(Debug, Clone, PartialEq)]
pub enum CertProfile {
    Client,
    Server,
    RootCA,
    SubCA,
}

#[derive(Debug, Clone, PartialEq)]
pub struct CertFiles {
    pub cert_path: String,
    pub key_path: String,
}

#[derive(Debug, Clone, PartialEq)]
pub struct CertData {
    pub cert: Vec<u8>,
    pub key: Vec<u8>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Issuer {
    CertSelf,
    CA(CertFiles),
}

#[derive(Debug, Clone, PartialEq)]
pub enum EcdsaCurve {
    P224,
    P256,
    P384,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Cipher {
    Rsa(usize),
    Ecdsa(EcdsaCurve),
}

#[derive(Debug, Clone, PartialEq)]
pub struct SubjectRdn {
    pub name: String,
    pub value: String,
}

pub fn gen_tls_cert(
    cert_profile: CertProfile,
    domain_names: Option<Vec<String>>,
    subject: Vec<SubjectRdn>,
    issuer: Issuer,
    cipher: Cipher,
    validity: u32,
    format: KeyFormat,
) -> Result<CertData> {
    tls::gen::gen_tls_cert(
        cert_profile,
        domain_names,
        subject,
        issuer,
        cipher,
        validity,
        format,
    )
}
