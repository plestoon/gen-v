import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import '../ffi/api/simple.dart' as ffi;
import '../widgets/chip_group.dart';
import '../widgets/decorated_form_field.dart';
import '../widgets/form_dialog.dart';
import 'ca_files_chooser.dart';
import 'cipher_selector.dart';
import 'issuer_selector.dart';
import 'models.dart';

class GeneratorForm extends StatefulWidget {
  final ffi.CertProfile certProfile;

  const GeneratorForm({
    super.key,
    required this.certProfile,
  });

  @override
  State<StatefulWidget> createState() => _GeneratorFormState();
}

class _GeneratorFormState extends State<GeneratorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String>? _domainNames;
  List<SubjectRdn> _subject = [];
  int _validity = 0;
  ffi.Cipher _cipher = const ffi.Cipher.rsa(2048);
  ffi.Issuer _issuer = const ffi.Issuer.certSelf();
  final ffi.KeyFormat _keyFormat = ffi.KeyFormat.pem;

  bool _submitting = false;

  Future<void> _onSubmitted() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submitting = true;
      });

      _formKey.currentState!.save();
      try {
        final data = await ffi.genTlsCert(
          certProfile: widget.certProfile,
          domainNames: _domainNames,
          subject: _subject.map((rdn) => rdn.toNative()).toList(),
          issuer: _issuer,
          cipher: _cipher,
          validity: _validity,
          format: _keyFormat,
        );
        final savePath = await FilePicker.platform.saveFile(
            fileName: 'cert.zip',
            type: FileType.custom,
            allowedExtensions: ['zip']);
        if (savePath != null) {
          _saveCert(data, savePath, _keyFormat);
        }
      } on AnyhowException catch (e) {
        debugPrint(e.message);
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  void _saveCert(ffi.CertData data, String path, ffi.KeyFormat format) {
    final fileExt = format == ffi.KeyFormat.pem ? "pem" : "der";
    final encoder = ZipFileEncoder();
    encoder.create(path);
    encoder.addArchiveFile(
      ArchiveFile("cert.$fileExt", data.cert.length, data.cert),
    );
    encoder.addArchiveFile(
      ArchiveFile("key.$fileExt", data.key.length, data.key),
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
            if (widget.certProfile == ffi.CertProfile.server)
              DecoratedFormField<List<String>>(
                label: "Domain names and/or IP addresses",
                validator: (value) =>
                    (value?.isEmpty ?? true) ? "required" : null,
                builder: (state) => ChipGroup<String>(
                  onAdd: () => _addDomainName(context),
                  onChanged: state.didChange,
                ),
                onSaved: (value) => _domainNames = value,
              ),
            if (widget.certProfile == ffi.CertProfile.server)
              const SizedBox(
                height: 10,
              ),
            DecoratedFormField<List<SubjectRdn>>(
              label: "Subject",
              validator: (value) =>
                  (value?.isEmpty ?? true) ? "required" : null,
              builder: (state) => ChipGroup<SubjectRdn>(
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
              initialValue: _cipher,
              builder: (state) => CipherSelector(
                initialValue: state.value,
                onChanged: (value) => state.didChange(value),
              ),
              onSaved: (value) => _cipher = value!,
            ),
            if ([ffi.CertProfile.client, ffi.CertProfile.server]
                .contains(widget.certProfile))
              const SizedBox(
                height: 10,
              ),
            if ([ffi.CertProfile.client, ffi.CertProfile.server]
                .contains(widget.certProfile))
              DecoratedFormField(
                label: "Issuer",
                validator: (value) {
                  if (value == null) {
                    return "required";
                  } else if (value is ffi.Issuer_CA) {
                    if (value.field0.certPath.isEmpty ||
                        value.field0.keyPath.isEmpty) {
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
                  onChanged: (value) => state.didChange(value as ffi.Issuer?),
                ),
                onSaved: (value) => _issuer = value!,
              ),
            if (widget.certProfile == ffi.CertProfile.subCa)
              const SizedBox(
                height: 10,
              ),
            if (widget.certProfile == ffi.CertProfile.subCa)
              DecoratedFormField<ffi.CertFiles>(
                label: "Issuer",
                validator: (value) {
                  if (value == null) {
                    return "required";
                  } else {
                    if (value.certPath.isEmpty || value.keyPath.isEmpty) {
                      return "both CA files must be provided";
                    } else {
                      return null;
                    }
                  }
                },
                builder: (state) => CaFilesChooser(
                  onChanged: (value) => state.didChange(value),
                ),
                onSaved: (value) => _issuer = ffi.Issuer_CA(value!),
              )
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

Future<SubjectRdn?> _addSubjectRdn(BuildContext context) {
  return showDialog<SubjectRdn>(
    context: context,
    builder: (_) {
      return FormDialog<SubjectRdn>(
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
                    DropdownMenu<RdnName>(
                      width: 100,
                      inputDecorationTheme:
                          const InputDecorationTheme(isDense: true),
                      initialSelection: formState.value.name,
                      onSelected: (value) {
                        if (value != null) {
                          formState.didChange(
                            formState.value.copyWith(name: value),
                          );
                        }
                      },
                      dropdownMenuEntries: RdnName.values
                          .map<DropdownMenuEntry<RdnName>>((RdnName value) {
                        return DropdownMenuEntry<RdnName>(
                          value: value,
                          label: value.displayName,
                          labelWidget: SizedBox(
                            width: double.infinity,
                            child: Tooltip(
                              message: value.description,
                              verticalOffset: 16,
                              child: Text(value.displayName),
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
        initialValue: SubjectRdn(name: RdnName.cn, value: ""),
      );
    },
  );
}
