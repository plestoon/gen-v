import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class CaFilesChooser extends StatefulWidget {
  final CertFilePaths? initialValue;
  final ValueChanged<CertFilePaths> onChanged;

  const CaFilesChooser({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _CaFilesChooser();
}

class _CaFilesChooser extends State<CaFilesChooser> {
  final _chainPathController = TextEditingController();
  final _keyPathController = TextEditingController();

  @override
  void initState() {
    if (widget.initialValue != null) {
      _chainPathController.text = widget.initialValue!.chainPath;
      _keyPathController.text = widget.initialValue!.keyPath;
    }

    super.initState();
  }

  void _onSelectChainFile() async {
    final path = await FilePicker.platform
        .pickFiles(dialogTitle: "Select CA certificate chain");

    if (path != null) {
      _chainPathController.text = path.paths[0]!;

      _onChanged();
    }
  }

  void _onSelectKeyFile() async {
    final path =
        await FilePicker.platform.pickFiles(dialogTitle: "Select CA key");

    if (path != null) {
      _keyPathController.text = path.paths[0]!;

      _onChanged();
    }
  }

  void _onChanged() {
    widget.onChanged(
      CertFilePaths(
          chainPath: _chainPathController.text,
          keyPath: _keyPathController.text),
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
              onPressed: _onSelectChainFile,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: TextField(
                enabled: false,
                controller: _chainPathController,
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                    isDense: true,
                    hintText: "Choose certificate chain file .."),
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
              onPressed: _onSelectKeyFile,
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
