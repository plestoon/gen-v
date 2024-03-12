use ecdsa::hazmat::SignPrimitive;
pub use ecdsa::{SignatureSize, SigningKey};
use elliptic_curve::generic_array::ArrayLength;
use elliptic_curve::ops::Invert;
use elliptic_curve::subtle::CtOption;
use elliptic_curve::{CurveArithmetic, PrimeCurve, Scalar};

pub fn gen_signing_key<T>() -> SigningKey<T>
where
    T: PrimeCurve + CurveArithmetic,
    Scalar<T>: Invert<Output = CtOption<Scalar<T>>> + SignPrimitive<T>,
    SignatureSize<T>: ArrayLength<u8>,
{
    let mut rng = rand::thread_rng();
    SigningKey::<T>::random(&mut rng)
}
