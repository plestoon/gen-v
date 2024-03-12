import 'package:flutter/material.dart';

import '../ffi/api/simple.dart' as ffi;
import '../widgets/segmented_group.dart';
import 'ca_files_chooser.dart';

enum _Issuer { self, ca }

class IssuerSelector extends StatefulWidget {
  final ffi.Issuer? initialValue;
  final ValueChanged<ffi.Issuer> onChanged;

  const IssuerSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _IssuerSelectorState();
}

class _IssuerSelectorState extends State<IssuerSelector> {
  _Issuer _issuer = _Issuer.self;
  ffi.CertFiles? _certFiles = const ffi.CertFiles(certPath: "", keyPath: "");

  @override
  void initState() {
    final initialValue = widget.initialValue;
    if (initialValue != null) {
      if (initialValue is ffi.Issuer_CertSelf) {
        _issuer = _Issuer.self;
      } else if (initialValue is ffi.Issuer_CA) {
        _issuer = _Issuer.ca;
        _certFiles = initialValue.field0;
      }
    }

    super.initState();
  }

  void _onIssuerChanged(value) {
    setState(() {
      _issuer = value;
    });

    _onChanged();
  }

  void _onChanged() {
    if (_issuer == _Issuer.self) {
      widget.onChanged(const ffi.Issuer.certSelf());
    } else if (_issuer == _Issuer.ca) {
      widget.onChanged(
        ffi.Issuer.ca(_certFiles!),
      );
    }
  }

  void _onCertFilesChanged(ffi.CertFiles? certFiles) async {
    _certFiles = certFiles;

    _onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedGroup<_Issuer>(
          initialValue: _issuer,
          showSelectedIcon: false,
          segmentsBuilder: () => [
            const ButtonSegment(label: Text("Self"), value: _Issuer.self),
            const ButtonSegment(label: Text("CA"), value: _Issuer.ca),
          ],
          onChanged: _onIssuerChanged,
        ),
        if (_issuer == _Issuer.ca)
          const SizedBox(
            height: 10,
          ),
        if (_issuer == _Issuer.ca)
          CaFilesChooser(
            certFiles: _certFiles,
            onChanged: _onCertFilesChanged,
          )
      ],
    );
  }
}
