
import '../ffi/api/simple.dart' as ffi;

enum RdnName {
  cn("CN", "commonName"),
  ou("OU", "organizationalUnit"),
  o("O", "organizationName"),
  l("L", "localityName"),
  s("S", "stateOrProvinceName"),
  c("C", "countryName"),
  e("E", "emailAddress");

  const RdnName(this.displayName, this.description);

  final String displayName;
  final String description;

  @override
  String toString() => displayName;
}

class SubjectRdn {
  final RdnName name;
  final String value;

  SubjectRdn({required this.name, required this.value});

  SubjectRdn copyWith({RdnName? name, String? value}) {
    return SubjectRdn(name: name ?? this.name, value: value ?? this.value);
  }

  @override
  String toString() {
    return "${name.toString()}=$value";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is SubjectRdn && other.name == name && other.value == value;
  }

  @override
  int get hashCode => name.hashCode * value.hashCode;

  ffi.SubjectRdn toNative() => ffi.SubjectRdn(
        name: name.displayName,
        value: value,
      );
}
