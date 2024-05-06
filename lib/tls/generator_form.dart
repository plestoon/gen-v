import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

import '../ffi/api/ext.dart';
import '../ffi/api/simple.dart' as ffi;
import '../widgets/chip_group.dart';
import '../widgets/decorated_form_field.dart';
import '../widgets/form_dialog.dart';
import 'ca_files_chooser.dart';
import 'cipher_selector.dart';
import 'issuer_selector.dart';
import 'models.dart';

class GeneratorForm extends StatefulWidget {
  final CertProfile certProfile;

  const GeneratorForm({
    super.key,
    required this.certProfile,
  });

  @override
  State<StatefulWidget> createState() => _GeneratorFormState();
}

class _GeneratorFormState extends State<GeneratorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String>? _subjectAltNames;
  List<Rdn> _subject = [];
  int _validity = 0;
  ffi.KeyCipher _keyCipher = const ffi.KeyCipher.rsa(2048);
  Issuer _issuer = Issuer(selfSigned: true);

  bool _submitting = false;

  Future<void> _onSubmitted() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submitting = true;
      });

      _formKey.currentState!.save();

      try {
        final certPair = await genCert(
          profile: widget.certProfile,
          subject: _subject,
          subjectAltNames: _subjectAltNames,
          keyCipher: _keyCipher,
          validity: _validity,
          issuer: _issuer,
        );
        final savePath = await FilePicker.platform.saveFile(
            fileName: 'cert.zip',
            type: FileType.custom,
            allowedExtensions: ['zip']);
        if (savePath != null) {
          _saveCert(certPair, savePath);
        }
      } on AnyhowException catch (e) {
        debugPrint(e.message);
      } catch (e, stackTrace) {
        debugPrint(e.toString());
        debugPrint(stackTrace.toString());
      } finally {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  void _saveCert(ffi.CertPairPem certPair, String path) {
    final encoder = ZipFileEncoder();
    encoder.create(path);
    encoder.addArchiveFile(
      ArchiveFile("fullchain.pem", certPair.chain.length, certPair.chain),
    );
    encoder.addArchiveFile(
      ArchiveFile("key.pem", certPair.key.length, certPair.key),
    );
    encoder.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            if (widget.certProfile == CertProfile.server)
              DecoratedFormField<List<String>>(
                label: "Domain names and/or IP addresses",
                validator: (value) =>
                    (value?.isEmpty ?? true) ? "required" : null,
                builder: (state) => ChipGroup<String>(
                  onAdd: () => _addDomainName(context),
                  onChanged: state.didChange,
                ),
                onSaved: (value) => _subjectAltNames = value,
              ),
            if (widget.certProfile == CertProfile.server)
              const SizedBox(
                height: 10,
              ),
            DecoratedFormField<List<Rdn>>(
              label: "Subject",
              validator: (value) =>
                  (value?.isEmpty ?? true) ? "required" : null,
              builder: (state) => ChipGroup<Rdn>(
                onAdd: () => _addSubjectRdn(context),
                onChanged: state.didChange,
              ),
              onSaved: (value) => _subject = value!,
            ),
            const SizedBox(
              height: 10,
            ),
            DecoratedFormField<int>(
              label: "Validity",
              validator: (value) => value == null ? "required" : null,
              builder: (state) => TextField(
                decoration: const InputDecoration(
                  suffixText: "days",
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    state.didChange(int.parse(value));
                  } else {
                    state.didChange(null);
                  }
                },
              ),
              onSaved: (value) => _validity = value!,
            ),
            const SizedBox(
              height: 10,
            ),
            DecoratedFormField(
              label: "Cipher",
              validator: (value) => value == null ? "required" : null,
              initialValue: _keyCipher,
              builder: (state) => CipherSelector(
                initialValue: state.value,
                onChanged: (value) => state.didChange(value),
              ),
              onSaved: (value) => _keyCipher = value!,
            ),
            if ([CertProfile.client, CertProfile.server]
                .contains(widget.certProfile))
              const SizedBox(
                height: 10,
              ),
            if ([CertProfile.client, CertProfile.server]
                .contains(widget.certProfile))
              DecoratedFormField(
                label: "Issuer",
                validator: (value) {
                  if (value == null) {
                    return "required";
                  } else if (!value.selfSigned) {
                    if (value.certFilePaths!.chainPath.isEmpty ||
                        value.certFilePaths!.keyPath.isEmpty) {
                      return "both CA files must be provided";
                    } else {
                      return null;
                    }
                  } else {
                    return null;
                  }
                },
                initialValue: _issuer,
                builder: (state) => IssuerSelector(
                  initialValue: state.value,
                  onChanged: (value) => state.didChange(value),
                ),
                onSaved: (value) => _issuer = value!,
              ),
            if (widget.certProfile == CertProfile.subCa)
              const SizedBox(
                height: 10,
              ),
            if (widget.certProfile == CertProfile.subCa)
              DecoratedFormField<Issuer>(
                label: "Issuer",
                validator: (value) {
                  if (value == null) {
                    return "required";
                  } else {
                    if (value.certFilePaths!.chainPath.isEmpty ||
                        value.certFilePaths!.keyPath.isEmpty) {
                      return "both CA files must be provided";
                    } else {
                      return null;
                    }
                  }
                },
                builder: (state) => CaFilesChooser(
                  onChanged: (value) => state.didChange(
                    Issuer(selfSigned: false, certFilePaths: value),
                  ),
                ),
                onSaved: (value) => _issuer = value!,
              ),
          ],
        ),
      ),
      floatingActionButton: FilledButton.icon(
        onPressed: _submitting ? null : _onSubmitted,
        icon: _submitting
            ? const SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : const SizedBox(),
        label: const Text("Generate"),
      ),
    );
  }
}

Future<String?> _addDomainName(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (_) {
      return FormDialog<String>(
        title: "Add domain Name",
        builder: (state) {
          return Form(
            key: state.formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  autofocus: true,
                  validator: (value) =>
                      (value?.isEmpty ?? true) ? "required" : null,
                  onChanged: state.didChange,
                  onFieldSubmitted: (_) => state.didSubmit(),
                )
              ],
            ),
          );
        },
        initialValue: "",
      );
    },
  );
}

Future<Rdn?> _addSubjectRdn(BuildContext context) {
  return showDialog<Rdn>(
    context: context,
    builder: (_) {
      return FormDialog<Rdn>(
        title: "Add subject RDN",
        builder: (formState) {
          return Form(
            key: formState.formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownMenu<ffi.RdnType>(
                      width: 100,
                      inputDecorationTheme:
                          const InputDecorationTheme(isDense: true),
                      initialSelection: formState.value.rdnType,
                      onSelected: (value) {
                        if (value != null) {
                          formState.didChange(
                            formState.value.copyWith(rdnType: value),
                          );
                        }
                      },
                      dropdownMenuEntries: ffi.RdnType.values
                          .map<DropdownMenuEntry<ffi.RdnType>>(
                              (ffi.RdnType value) {
                        return DropdownMenuEntry<ffi.RdnType>(
                          value: value,
                          label: value.shortName,
                          labelWidget: SizedBox(
                            width: double.infinity,
                            child: Tooltip(
                              message: value.name,
                              verticalOffset: 16,
                              child: Text(value.shortName),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        validator: (value) =>
                            (value?.isEmpty ?? true) ? "required" : null,
                        onChanged: (value) => formState.didChange(
                          formState.value.copyWith(value: value),
                        ),
                        onFieldSubmitted: (_) => formState.didSubmit(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        initialValue: Rdn(rdnType: ffi.RdnType.commonName, value: ""),
      );
    },
  );
}

Future<ffi.CertPairPem> genCert(
    {required CertProfile profile,
    required List<Rdn> subject,
    List<String>? subjectAltNames,
    required ffi.KeyCipher keyCipher,
    required int validity,
    required Issuer issuer}) async {
  try {
    ffi.CertPairPem? nativeIssuer;
    if (!issuer.selfSigned) {
      nativeIssuer = await issuer.certFilePaths!.toCertPair();
    }

    List<ffi.Rdn> nativeSubject = subject.map((rdn) => rdn.native).toList();

    switch (profile) {
      case CertProfile.server:
        return await ffi.genServerCert(
            subject: nativeSubject,
            subjectAltNames: subjectAltNames!,
            keyCipher: keyCipher,
            validity: validity,
            issuer: nativeIssuer);
      case CertProfile.client:
        return await ffi.genClientCert(
            subject: nativeSubject,
            keyCipher: keyCipher,
            validity: validity,
            issuer: nativeIssuer);
      case CertProfile.rootCa:
        return await ffi.genRootCaCert(
            subject: nativeSubject, keyCipher: keyCipher, validity: validity);
      case CertProfile.subCa:
        return await ffi.genSubCaCert(
            subject: nativeSubject,
            keyCipher: keyCipher,
            validity: validity,
            issuer: nativeIssuer!);
    }
  } on Object {
    rethrow;
  }
}
