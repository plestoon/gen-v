use const_oid::AssociatedOid;
use digest::Digest;
use rsa::pkcs1v15::SigningKey;

pub fn gen_signing_key<T: Digest + AssociatedOid>(key_size: usize) -> SigningKey<T> {
    let mut rng = rand::thread_rng();
    SigningKey::<T>::random(&mut rng, key_size).unwrap()
}
