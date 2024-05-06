import 'simple.dart' as ffi;

extension RdnTypeExt on ffi.RdnType {
  String get shortName {
    switch (this) {
      case ffi.RdnType.commonName:
        return "CN";
      case ffi.RdnType.countryName:
        return "C";
      case ffi.RdnType.stateOrProvinceName:
        return "S";
      case ffi.RdnType.localityName:
        return "L";
      case ffi.RdnType.organizationName:
        return "O";
      case ffi.RdnType.organizationalUnitName:
        return "OU";
    }
  }
}

class Rdn {
  final ffi.Rdn inner;

  Rdn._(this.inner);

  factory Rdn({required ffi.RdnType rdnType, required String value}) {
    final inner = ffi.Rdn(rdnType: rdnType, value: value);

    return Rdn._(inner);
  }

  ffi.RdnType get rdnType {
    return inner.rdnType;
  }

  String get value {
    return inner.value;
  }

  Rdn copyWith({ffi.RdnType? rdnType, String? value}) {
    final inner = ffi.Rdn(
        rdnType: rdnType ?? this.inner.rdnType,
        value: value ?? this.inner.value);

    return Rdn._(inner);
  }

  ffi.Rdn get native {
    return inner;
  }

  @override
  String toString() {
    return "${rdnType.shortName}=$value";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is Rdn && other.rdnType == rdnType && other.value == value;
  }

  @override
  int get hashCode => rdnType.hashCode * value.hashCode;
}
