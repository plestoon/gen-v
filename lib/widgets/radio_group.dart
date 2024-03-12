import 'package:flutter/material.dart';

typedef RadioGroupBuilder<T> = Widget Function(
    T? groupValue, ValueChanged<T?> didChange);

class RadioGroup<T> extends StatefulWidget {
  final T? initialValue;
  final RadioGroupBuilder<T> builder;
  final ValueChanged<T?>? onChanged;

  const RadioGroup(
      {super.key, this.initialValue, required this.builder, this.onChanged});

  @override
  State<StatefulWidget> createState() {
    return _RadioGroupState<T>();
  }
}

class _RadioGroupState<T> extends State<RadioGroup<T>> {
  late T? _value = widget.initialValue;

  void didChange(T? value) {
    setState(() {
      _value = value;
    });

    if (widget.onChanged != null) {
      widget.onChanged!(_value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_value, didChange);
  }
}
