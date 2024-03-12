import 'package:flutter/material.dart';

class DecoratedFormField<T> extends FormField<T> {
  final String? label;

  const DecoratedFormField({
    super.key,
    required this.label,
    required super.builder,
    super.onSaved,
    super.validator,
    super.initialValue,
  });

  @override
  FormFieldState<T> createState() {
    return _DecoratedFormFieldState<T>();
  }
}

class _DecoratedFormFieldState<T> extends FormFieldState<T> {
  @override
  Widget build(BuildContext context) {
    final widget = this.widget as DecoratedFormField;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  if (this.widget.validator?.call(null) != null)
                    const TextSpan(
                      text: "* ",
                      style: TextStyle(color: Colors.red),
                    ),
                  TextSpan(
                    text: widget.label!,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        super.build(context),
        if (hasError)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              errorText!,
              style: TextStyle(
                  fontSize: 12, color: Theme.of(context).colorScheme.error),
            ),
          ),
      ],
    );
  }
}
