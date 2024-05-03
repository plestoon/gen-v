import 'package:flutter/material.dart';
import 'package:gen_x/tls/models.dart';

import '../widgets/segmented_group.dart';
import 'ca_files_chooser.dart';

class IssuerSelector extends StatefulWidget {
  final Issuer? initialValue;
  final ValueChanged<Issuer> onChanged;

  const IssuerSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _IssuerSelectorState();
}

class _IssuerSelectorState extends State<IssuerSelector> {
  late Issuer _issuer;

  @override
  void initState() {
    _issuer = widget.initialValue ?? Issuer(selfSigned: true);

    super.initState();
  }

  void _onSigningTypeChanged(value) {
    setState(() {
      if (value) {
        _issuer = Issuer(selfSigned: value);
      } else {
        _issuer = Issuer(selfSigned: value, certFilePaths: CertFilePaths());
      }
    });

    _onChanged();
  }

  void _onChanged() {
    widget.onChanged(_issuer);
  }

  void _onCertFilePathsChanged(CertFilePaths certFilePaths) async {
    _issuer = _issuer.copyWith(certFilePaths: certFilePaths);

    _onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedGroup<bool>(
          initialValue: _issuer.selfSigned,
          showSelectedIcon: false,
          segmentsBuilder: () => [
            const ButtonSegment(label: Text("Self"), value: true),
            const ButtonSegment(label: Text("CA"), value: false),
          ],
          onChanged: _onSigningTypeChanged,
        ),
        if (!_issuer.selfSigned)
          const SizedBox(
            height: 10,
          ),
        if (!_issuer.selfSigned)
          CaFilesChooser(
            initialValue: _issuer.certFilePaths,
            onChanged: _onCertFilePathsChanged,
          )
      ],
    );
  }
}
