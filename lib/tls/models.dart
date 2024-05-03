import 'dart:io';

import '../ffi/api/simple.dart' as ffi;

enum CertProfile { server, client, rootCa, subCa }

class Issuer {
  final bool selfSigned;
  final CertFilePaths? certFilePaths;

  Issuer({required this.selfSigned, this.certFilePaths});

  Issuer copyWith({bool? selfSigned, CertFilePaths? certFilePaths}) {
    return Issuer(
        selfSigned: selfSigned ?? this.selfSigned,
        certFilePaths: certFilePaths ?? this.certFilePaths);
  }
}

class CertFilePaths {
  final String chainPath;
  final String keyPath;

  CertFilePaths({this.chainPath = "", this.keyPath = ""});

  CertFilePaths copyWith({String? chainPath, String? keyPath}) {
    return CertFilePaths(
        chainPath: chainPath ?? this.chainPath,
        keyPath: keyPath ?? this.keyPath);
  }

  Future<ffi.CertPairPem> toCertPair() async {
    try {
      if (chainPath.isEmpty) {
        throw Exception("CA certificate chain must be provided");
      }
      if (keyPath.isEmpty) {
        throw Exception("CA key must be provided");
      }

      final chainFile = File(chainPath);
      final chain = await chainFile.readAsString();

      final keyFile = File(keyPath);
      final key = await keyFile.readAsString();

      return ffi.CertPairPem(chain: chain, key: key);
    } on Object {
      rethrow;
    }
  }
}
