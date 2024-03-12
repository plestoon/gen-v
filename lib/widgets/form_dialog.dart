import 'package:flutter/material.dart';

typedef DialogFormBuilder<T> = Form Function(FormDialogState<T>);

class FormDialog<T> extends StatefulWidget {
  final String title;
  final DialogFormBuilder<T> builder;
  final T initialValue;

  const FormDialog({
    super.key,
    required this.builder,
    required this.initialValue,
    required this.title,
  });

  @override
  State<StatefulWidget> createState() => FormDialogState<T>();
}

class FormDialogState<T> extends State<FormDialog<T>> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late T value = widget.initialValue;

  void didChange(T value) {
    this.value = value;
  }

  void didSubmit() {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pop(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            widget.builder(this),
          ],
        ),
      ),
    );
  }
}
