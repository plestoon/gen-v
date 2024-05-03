import 'package:flutter/material.dart';

import '../ffi/api/simple.dart';
import '../widgets/radio_group.dart';
import '../widgets/segmented_group.dart';

enum _CipherAlgorithm { rsa, ecdsa }

class CipherSelector extends StatefulWidget {
  final KeyCipher? initialValue;
  final ValueChanged<KeyCipher> onChanged;

  const CipherSelector(
      {super.key, required this.initialValue, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _CipherSelectorState();
}

class _CipherSelectorState extends State<CipherSelector> {
  _CipherAlgorithm _algorithm = _CipherAlgorithm.rsa;
  int _rsaKeySize = 2048;
  EcdsaCurve _ecdsaCurve = EcdsaCurve.p256;

  @override
  void initState() {
    final initialValue = widget.initialValue;

    if (initialValue != null) {
      if (initialValue is KeyCipher_Rsa) {
        _algorithm = _CipherAlgorithm.rsa;
        _rsaKeySize = initialValue.field0;
      } else if (initialValue is KeyCipher_Ecdsa) {
        _algorithm = _CipherAlgorithm.ecdsa;
        _ecdsaCurve = initialValue.field0;
      }
    }

    super.initState();
  }

  void _onAlgorithmChanged(value) {
    setState(() {
      _algorithm = value;
    });

    _onChanged();
  }

  void _onRsaKeySizeChanged(value) {
    _rsaKeySize = value;

    _onChanged();
  }

  void _onEcdsaCurveChanged(value) {
    _ecdsaCurve = value;

    _onChanged();
  }

  void _onChanged() {
    if (_algorithm == _CipherAlgorithm.rsa) {
      widget.onChanged(KeyCipher.rsa(_rsaKeySize));
    } else if (_algorithm == _CipherAlgorithm.ecdsa) {
      widget.onChanged(KeyCipher.ecdsa(_ecdsaCurve));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedGroup<_CipherAlgorithm>(
          initialValue: _algorithm,
          showSelectedIcon: false,
          segmentsBuilder: () => [
            const ButtonSegment(
                label: Text("RSA"), value: _CipherAlgorithm.rsa),
            const ButtonSegment(
                label: Text("ECDSA"), value: _CipherAlgorithm.ecdsa),
          ],
          onChanged: _onAlgorithmChanged,
        ),
        const SizedBox(
          height: 10,
        ),
        if (_algorithm == _CipherAlgorithm.rsa)
          RadioGroup<int>(
            initialValue: _rsaKeySize,
            builder: (groupValue, didChange) => Row(
              children: [
                Expanded(
                  child: RadioListTile(
                      title: const Text("2048-bit"),
                      value: 2048,
                      groupValue: groupValue,
                      onChanged: didChange),
                ),
                Expanded(
                  child: RadioListTile(
                      title: const Text("4096-bit"),
                      value: 4096,
                      groupValue: groupValue,
                      onChanged: didChange),
                ),
              ],
            ),
            onChanged: _onRsaKeySizeChanged,
          ),
        if (_algorithm == _CipherAlgorithm.ecdsa)
          RadioGroup<EcdsaCurve>(
            initialValue: _ecdsaCurve,
            builder: (groupValue, didChange) => Row(
              children: [
                Expanded(
                  child: RadioListTile(
                      title: const Text("P224"),
                      value: EcdsaCurve.p224,
                      groupValue: groupValue,
                      onChanged: didChange),
                ),
                Expanded(
                  child: RadioListTile(
                      title: const Text("P256"),
                      value: EcdsaCurve.p256,
                      groupValue: groupValue,
                      onChanged: didChange),
                ),
                Expanded(
                  child: RadioListTile(
                      title: const Text("P384"),
                      value: EcdsaCurve.p384,
                      groupValue: groupValue,
                      onChanged: didChange),
                ),
              ],
            ),
            onChanged: _onEcdsaCurveChanged,
          ),
      ],
    );
  }
}
