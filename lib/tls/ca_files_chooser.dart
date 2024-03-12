import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../ffi/api/simple.dart';

class CaFilesChooser extends StatefulWidget {
  final CertFiles? certFiles;
  final ValueChanged<CertFiles?> onChanged;

  const CaFilesChooser({
    super.key,
    this.certFiles,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _CaFilesChooser();
}

class _CaFilesChooser extends State<CaFilesChooser> {
  final _certPathController = TextEditingController();
  final _keyPathController = TextEditingController();

  @override
  void initState() {
    if (widget.certFiles != null) {
      _certPathController.text = widget.certFiles!.certPath;
      _keyPathController.text = widget.certFiles!.keyPath;
    }

    super.initState();
  }

  void _onSelectCaCertFile() async {
    final path = await FilePicker.platform
        .pickFiles(dialogTitle: "Select CA certificate");

    if (path != null) {
      _certPathController.text = path.paths[0]!;

      _onChanged();
    }
  }

  void _onSelectCaKeyFile() async {
    final path =
        await FilePicker.platform.pickFiles(dialogTitle: "Select CA key");

    if (path != null) {
      _keyPathController.text = path.paths[0]!;

      _onChanged();
    }
  }

  void _onChanged() {
    widget.onChanged(
      CertFiles(
          certPath: _certPathController.text, keyPath: _keyPathController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 20,
              icon: const Icon(Icons.file_open_outlined),
              onPressed: _onSelectCaCertFile,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: TextField(
                enabled: false,
                controller: _certPathController,
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                    isDense: true, hintText: "Choose certificate file .."),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 20,
              icon: const Icon(Icons.file_open_outlined),
              onPressed: _onSelectCaKeyFile,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: TextField(
                enabled: false,
                controller: _keyPathController,
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                    isDense: true, hintText: "Choose key file .."),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
