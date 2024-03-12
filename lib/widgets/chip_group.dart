import 'package:flutter/material.dart';

typedef OnAdd<T> = Future<T?> Function();

class ChipGroup<T> extends StatefulWidget {
  final OnAdd onAdd;
  final ValueChanged<List<T>>? onChanged;

  const ChipGroup({super.key, required this.onAdd, this.onChanged});

  @override
  State<StatefulWidget> createState() => _ChipGroupState<T>();
}

class _ChipGroupState<T> extends State<ChipGroup<T>> {
  final List<T> _values = [];

  void onAdd() {
    widget.onAdd().then((value) {
      if (value != null && !_values.contains(value)) {
        setState(() {
          _values.add(value);
        });

        if (widget.onChanged != null) {
          widget.onChanged!(_values);
        }
      }
    });
  }

  void onDeleted(T value) {
    setState(() {
      _values.remove(value);
    });

    if (widget.onChanged != null) {
      widget.onChanged!(_values);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chips = _values
        .map(
          (value) => InputChip(
            label: Text(value.toString()),
            onDeleted: () => onDeleted(value),
            deleteButtonTooltipMessage: "",
          ),
        )
        .toList();
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        ...chips,
        IconButton(
          iconSize: 20,
          icon: const Icon(Icons.add),
          onPressed: onAdd,
        ),
      ],
    );
  }
}
