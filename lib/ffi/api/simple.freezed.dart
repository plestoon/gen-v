// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Cipher {
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) rsa,
    required TResult Function(EcdsaCurve field0) ecdsa,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? rsa,
    TResult? Function(EcdsaCurve field0)? ecdsa,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? rsa,
    TResult Function(EcdsaCurve field0)? ecdsa,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Cipher_Rsa value) rsa,
    required TResult Function(Cipher_Ecdsa value) ecdsa,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Cipher_Rsa value)? rsa,
    TResult? Function(Cipher_Ecdsa value)? ecdsa,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Cipher_Rsa value)? rsa,
    TResult Function(Cipher_Ecdsa value)? ecdsa,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CipherCopyWith<$Res> {
  factory $CipherCopyWith(Cipher value, $Res Function(Cipher) then) =
      _$CipherCopyWithImpl<$Res, Cipher>;
}

/// @nodoc
class _$CipherCopyWithImpl<$Res, $Val extends Cipher>
    implements $CipherCopyWith<$Res> {
  _$CipherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$Cipher_RsaImplCopyWith<$Res> {
  factory _$$Cipher_RsaImplCopyWith(
          _$Cipher_RsaImpl value, $Res Function(_$Cipher_RsaImpl) then) =
      __$$Cipher_RsaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int field0});
}

/// @nodoc
class __$$Cipher_RsaImplCopyWithImpl<$Res>
    extends _$CipherCopyWithImpl<$Res, _$Cipher_RsaImpl>
    implements _$$Cipher_RsaImplCopyWith<$Res> {
  __$$Cipher_RsaImplCopyWithImpl(
      _$Cipher_RsaImpl _value, $Res Function(_$Cipher_RsaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Cipher_RsaImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$Cipher_RsaImpl implements Cipher_Rsa {
  const _$Cipher_RsaImpl(this.field0);

  @override
  final int field0;

  @override
  String toString() {
    return 'Cipher.rsa(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Cipher_RsaImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Cipher_RsaImplCopyWith<_$Cipher_RsaImpl> get copyWith =>
      __$$Cipher_RsaImplCopyWithImpl<_$Cipher_RsaImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) rsa,
    required TResult Function(EcdsaCurve field0) ecdsa,
  }) {
    return rsa(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? rsa,
    TResult? Function(EcdsaCurve field0)? ecdsa,
  }) {
    return rsa?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? rsa,
    TResult Function(EcdsaCurve field0)? ecdsa,
    required TResult orElse(),
  }) {
    if (rsa != null) {
      return rsa(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Cipher_Rsa value) rsa,
    required TResult Function(Cipher_Ecdsa value) ecdsa,
  }) {
    return rsa(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Cipher_Rsa value)? rsa,
    TResult? Function(Cipher_Ecdsa value)? ecdsa,
  }) {
    return rsa?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Cipher_Rsa value)? rsa,
    TResult Function(Cipher_Ecdsa value)? ecdsa,
    required TResult orElse(),
  }) {
    if (rsa != null) {
      return rsa(this);
    }
    return orElse();
  }
}

abstract class Cipher_Rsa implements Cipher {
  const factory Cipher_Rsa(final int field0) = _$Cipher_RsaImpl;

  @override
  int get field0;
  @JsonKey(ignore: true)
  _$$Cipher_RsaImplCopyWith<_$Cipher_RsaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Cipher_EcdsaImplCopyWith<$Res> {
  factory _$$Cipher_EcdsaImplCopyWith(
          _$Cipher_EcdsaImpl value, $Res Function(_$Cipher_EcdsaImpl) then) =
      __$$Cipher_EcdsaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EcdsaCurve field0});
}

/// @nodoc
class __$$Cipher_EcdsaImplCopyWithImpl<$Res>
    extends _$CipherCopyWithImpl<$Res, _$Cipher_EcdsaImpl>
    implements _$$Cipher_EcdsaImplCopyWith<$Res> {
  __$$Cipher_EcdsaImplCopyWithImpl(
      _$Cipher_EcdsaImpl _value, $Res Function(_$Cipher_EcdsaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Cipher_EcdsaImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as EcdsaCurve,
    ));
  }
}

/// @nodoc

class _$Cipher_EcdsaImpl implements Cipher_Ecdsa {
  const _$Cipher_EcdsaImpl(this.field0);

  @override
  final EcdsaCurve field0;

  @override
  String toString() {
    return 'Cipher.ecdsa(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Cipher_EcdsaImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Cipher_EcdsaImplCopyWith<_$Cipher_EcdsaImpl> get copyWith =>
      __$$Cipher_EcdsaImplCopyWithImpl<_$Cipher_EcdsaImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) rsa,
    required TResult Function(EcdsaCurve field0) ecdsa,
  }) {
    return ecdsa(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? rsa,
    TResult? Function(EcdsaCurve field0)? ecdsa,
  }) {
    return ecdsa?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? rsa,
    TResult Function(EcdsaCurve field0)? ecdsa,
    required TResult orElse(),
  }) {
    if (ecdsa != null) {
      return ecdsa(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Cipher_Rsa value) rsa,
    required TResult Function(Cipher_Ecdsa value) ecdsa,
  }) {
    return ecdsa(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Cipher_Rsa value)? rsa,
    TResult? Function(Cipher_Ecdsa value)? ecdsa,
  }) {
    return ecdsa?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Cipher_Rsa value)? rsa,
    TResult Function(Cipher_Ecdsa value)? ecdsa,
    required TResult orElse(),
  }) {
    if (ecdsa != null) {
      return ecdsa(this);
    }
    return orElse();
  }
}

abstract class Cipher_Ecdsa implements Cipher {
  const factory Cipher_Ecdsa(final EcdsaCurve field0) = _$Cipher_EcdsaImpl;

  @override
  EcdsaCurve get field0;
  @JsonKey(ignore: true)
  _$$Cipher_EcdsaImplCopyWith<_$Cipher_EcdsaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Issuer {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() certSelf,
    required TResult Function(CertFiles field0) ca,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? certSelf,
    TResult? Function(CertFiles field0)? ca,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? certSelf,
    TResult Function(CertFiles field0)? ca,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Issuer_CertSelf value) certSelf,
    required TResult Function(Issuer_CA value) ca,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Issuer_CertSelf value)? certSelf,
    TResult? Function(Issuer_CA value)? ca,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Issuer_CertSelf value)? certSelf,
    TResult Function(Issuer_CA value)? ca,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssuerCopyWith<$Res> {
  factory $IssuerCopyWith(Issuer value, $Res Function(Issuer) then) =
      _$IssuerCopyWithImpl<$Res, Issuer>;
}

/// @nodoc
class _$IssuerCopyWithImpl<$Res, $Val extends Issuer>
    implements $IssuerCopyWith<$Res> {
  _$IssuerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$Issuer_CertSelfImplCopyWith<$Res> {
  factory _$$Issuer_CertSelfImplCopyWith(_$Issuer_CertSelfImpl value,
          $Res Function(_$Issuer_CertSelfImpl) then) =
      __$$Issuer_CertSelfImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$Issuer_CertSelfImplCopyWithImpl<$Res>
    extends _$IssuerCopyWithImpl<$Res, _$Issuer_CertSelfImpl>
    implements _$$Issuer_CertSelfImplCopyWith<$Res> {
  __$$Issuer_CertSelfImplCopyWithImpl(
      _$Issuer_CertSelfImpl _value, $Res Function(_$Issuer_CertSelfImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Issuer_CertSelfImpl implements Issuer_CertSelf {
  const _$Issuer_CertSelfImpl();

  @override
  String toString() {
    return 'Issuer.certSelf()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Issuer_CertSelfImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() certSelf,
    required TResult Function(CertFiles field0) ca,
  }) {
    return certSelf();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? certSelf,
    TResult? Function(CertFiles field0)? ca,
  }) {
    return certSelf?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? certSelf,
    TResult Function(CertFiles field0)? ca,
    required TResult orElse(),
  }) {
    if (certSelf != null) {
      return certSelf();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Issuer_CertSelf value) certSelf,
    required TResult Function(Issuer_CA value) ca,
  }) {
    return certSelf(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Issuer_CertSelf value)? certSelf,
    TResult? Function(Issuer_CA value)? ca,
  }) {
    return certSelf?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Issuer_CertSelf value)? certSelf,
    TResult Function(Issuer_CA value)? ca,
    required TResult orElse(),
  }) {
    if (certSelf != null) {
      return certSelf(this);
    }
    return orElse();
  }
}

abstract class Issuer_CertSelf implements Issuer {
  const factory Issuer_CertSelf() = _$Issuer_CertSelfImpl;
}

/// @nodoc
abstract class _$$Issuer_CAImplCopyWith<$Res> {
  factory _$$Issuer_CAImplCopyWith(
          _$Issuer_CAImpl value, $Res Function(_$Issuer_CAImpl) then) =
      __$$Issuer_CAImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CertFiles field0});
}

/// @nodoc
class __$$Issuer_CAImplCopyWithImpl<$Res>
    extends _$IssuerCopyWithImpl<$Res, _$Issuer_CAImpl>
    implements _$$Issuer_CAImplCopyWith<$Res> {
  __$$Issuer_CAImplCopyWithImpl(
      _$Issuer_CAImpl _value, $Res Function(_$Issuer_CAImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Issuer_CAImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as CertFiles,
    ));
  }
}

/// @nodoc

class _$Issuer_CAImpl implements Issuer_CA {
  const _$Issuer_CAImpl(this.field0);

  @override
  final CertFiles field0;

  @override
  String toString() {
    return 'Issuer.ca(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Issuer_CAImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Issuer_CAImplCopyWith<_$Issuer_CAImpl> get copyWith =>
      __$$Issuer_CAImplCopyWithImpl<_$Issuer_CAImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() certSelf,
    required TResult Function(CertFiles field0) ca,
  }) {
    return ca(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? certSelf,
    TResult? Function(CertFiles field0)? ca,
  }) {
    return ca?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? certSelf,
    TResult Function(CertFiles field0)? ca,
    required TResult orElse(),
  }) {
    if (ca != null) {
      return ca(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Issuer_CertSelf value) certSelf,
    required TResult Function(Issuer_CA value) ca,
  }) {
    return ca(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Issuer_CertSelf value)? certSelf,
    TResult? Function(Issuer_CA value)? ca,
  }) {
    return ca?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Issuer_CertSelf value)? certSelf,
    TResult Function(Issuer_CA value)? ca,
    required TResult orElse(),
  }) {
    if (ca != null) {
      return ca(this);
    }
    return orElse();
  }
}

abstract class Issuer_CA implements Issuer {
  const factory Issuer_CA(final CertFiles field0) = _$Issuer_CAImpl;

  CertFiles get field0;
  @JsonKey(ignore: true)
  _$$Issuer_CAImplCopyWith<_$Issuer_CAImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
