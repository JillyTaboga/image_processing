import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    this.initialValue,
    required this.onChange,
  });

  final Color? initialValue;
  final Function(Color? newColor) onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color? color;
  bool active = false;

  @override
  void initState() {
    super.initState();
    color = widget.initialValue;
    if (color != null) {
      active = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Cor:'),
        ColorIndicator(
          color: color ?? Colors.transparent,
          hasBorder: true,
          borderColor: Theme.of(context).colorScheme.onPrimary,
          onSelect: () async {
            final result = await showColorPickerDialog(
              context,
              color ?? Colors.transparent,
              enableTonalPalette: true,
              pickersEnabled: {
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
                ColorPickerType.custom: true,
                ColorPickerType.wheel: true,
              },
            );
            if (result != Colors.transparent && context.mounted) {
              setState(() {
                color = result;
                active = true;
              });
              widget.onChange(result);
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Ativo:'),
        Checkbox(
          value: active,
          onChanged: (value) {
            setState(() {
              active = value!;
            });
            if (active) {
              widget.onChange(color);
            } else {
              widget.onChange(null);
            }
          },
        ),
      ],
    );
  }
}
