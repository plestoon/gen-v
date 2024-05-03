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
mixin _$KeyCipher {
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
    required TResult Function(KeyCipher_Rsa value) rsa,
    required TResult Function(KeyCipher_Ecdsa value) ecdsa,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(KeyCipher_Rsa value)? rsa,
    TResult? Function(KeyCipher_Ecdsa value)? ecdsa,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(KeyCipher_Rsa value)? rsa,
    TResult Function(KeyCipher_Ecdsa value)? ecdsa,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyCipherCopyWith<$Res> {
  factory $KeyCipherCopyWith(KeyCipher value, $Res Function(KeyCipher) then) =
      _$KeyCipherCopyWithImpl<$Res, KeyCipher>;
}

/// @nodoc
class _$KeyCipherCopyWithImpl<$Res, $Val extends KeyCipher>
    implements $KeyCipherCopyWith<$Res> {
  _$KeyCipherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$KeyCipher_RsaImplCopyWith<$Res> {
  factory _$$KeyCipher_RsaImplCopyWith(
          _$KeyCipher_RsaImpl value, $Res Function(_$KeyCipher_RsaImpl) then) =
      __$$KeyCipher_RsaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int field0});
}

/// @nodoc
class __$$KeyCipher_RsaImplCopyWithImpl<$Res>
    extends _$KeyCipherCopyWithImpl<$Res, _$KeyCipher_RsaImpl>
    implements _$$KeyCipher_RsaImplCopyWith<$Res> {
  __$$KeyCipher_RsaImplCopyWithImpl(
      _$KeyCipher_RsaImpl _value, $Res Function(_$KeyCipher_RsaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$KeyCipher_RsaImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$KeyCipher_RsaImpl extends KeyCipher_Rsa {
  const _$KeyCipher_RsaImpl(this.field0) : super._();

  @override
  final int field0;

  @override
  String toString() {
    return 'KeyCipher.rsa(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyCipher_RsaImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyCipher_RsaImplCopyWith<_$KeyCipher_RsaImpl> get copyWith =>
      __$$KeyCipher_RsaImplCopyWithImpl<_$KeyCipher_RsaImpl>(this, _$identity);

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
    required TResult Function(KeyCipher_Rsa value) rsa,
    required TResult Function(KeyCipher_Ecdsa value) ecdsa,
  }) {
    return rsa(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(KeyCipher_Rsa value)? rsa,
    TResult? Function(KeyCipher_Ecdsa value)? ecdsa,
  }) {
    return rsa?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(KeyCipher_Rsa value)? rsa,
    TResult Function(KeyCipher_Ecdsa value)? ecdsa,
    required TResult orElse(),
  }) {
    if (rsa != null) {
      return rsa(this);
    }
    return orElse();
  }
}

abstract class KeyCipher_Rsa extends KeyCipher {
  const factory KeyCipher_Rsa(final int field0) = _$KeyCipher_RsaImpl;
  const KeyCipher_Rsa._() : super._();

  @override
  int get field0;
  @JsonKey(ignore: true)
  _$$KeyCipher_RsaImplCopyWith<_$KeyCipher_RsaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$KeyCipher_EcdsaImplCopyWith<$Res> {
  factory _$$KeyCipher_EcdsaImplCopyWith(_$KeyCipher_EcdsaImpl value,
          $Res Function(_$KeyCipher_EcdsaImpl) then) =
      __$$KeyCipher_EcdsaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EcdsaCurve field0});
}

/// @nodoc
class __$$KeyCipher_EcdsaImplCopyWithImpl<$Res>
    extends _$KeyCipherCopyWithImpl<$Res, _$KeyCipher_EcdsaImpl>
    implements _$$KeyCipher_EcdsaImplCopyWith<$Res> {
  __$$KeyCipher_EcdsaImplCopyWithImpl(
      _$KeyCipher_EcdsaImpl _value, $Res Function(_$KeyCipher_EcdsaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$KeyCipher_EcdsaImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as EcdsaCurve,
    ));
  }
}

/// @nodoc

class _$KeyCipher_EcdsaImpl extends KeyCipher_Ecdsa {
  const _$KeyCipher_EcdsaImpl(this.field0) : super._();

  @override
  final EcdsaCurve field0;

  @override
  String toString() {
    return 'KeyCipher.ecdsa(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyCipher_EcdsaImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyCipher_EcdsaImplCopyWith<_$KeyCipher_EcdsaImpl> get copyWith =>
      __$$KeyCipher_EcdsaImplCopyWithImpl<_$KeyCipher_EcdsaImpl>(
          this, _$identity);

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
    required TResult Function(KeyCipher_Rsa value) rsa,
    required TResult Function(KeyCipher_Ecdsa value) ecdsa,
  }) {
    return ecdsa(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(KeyCipher_Rsa value)? rsa,
    TResult? Function(KeyCipher_Ecdsa value)? ecdsa,
  }) {
    return ecdsa?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(KeyCipher_Rsa value)? rsa,
    TResult Function(KeyCipher_Ecdsa value)? ecdsa,
    required TResult orElse(),
  }) {
    if (ecdsa != null) {
      return ecdsa(this);
    }
    return orElse();
  }
}

abstract class KeyCipher_Ecdsa extends KeyCipher {
  const factory KeyCipher_Ecdsa(final EcdsaCurve field0) =
      _$KeyCipher_EcdsaImpl;
  const KeyCipher_Ecdsa._() : super._();

  @override
  EcdsaCurve get field0;
  @JsonKey(ignore: true)
  _$$KeyCipher_EcdsaImplCopyWith<_$KeyCipher_EcdsaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
