import 'package:flutter/material.dart';

typedef SegmentsBuilder<T> = List<ButtonSegment<T>> Function();

class SegmentedGroup<T> extends StatefulWidget {
  final T initialValue;
  final SegmentsBuilder<T> segmentsBuilder;
  final bool showSelectedIcon;
  final ValueChanged<T>? onChanged;

  const SegmentedGroup({
    super.key,
    required this.initialValue,
    required this.segmentsBuilder,
    this.showSelectedIcon = true,
    this.onChanged,
  });

  @override
  State<SegmentedGroup<T>> createState() => _SegmentedGroupState<T>();
}

class _SegmentedGroupState<T> extends State<SegmentedGroup<T>> {
  late T _value = widget.initialValue;

  void didChange(T value) {
    setState(() {
      _value = value;
    });

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      segments: widget.segmentsBuilder(),
      showSelectedIcon: widget.showSelectedIcon,
      selected: {_value},
      onSelectionChanged: (selection) {
        didChange(selection.first);
      },
    );
  }
}
