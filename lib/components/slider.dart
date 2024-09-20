import 'package:flutter/material.dart';

class SliderCustom extends StatefulWidget {
  const SliderCustom({
    super.key,
    required this.initialValue,
    required this.onChange,
    required this.label,
    required this.max,
    required this.min,
  });

  final double initialValue;
  final Function(double newValue) onChange;
  final String label;
  final double max;
  final double min;

  @override
  State<SliderCustom> createState() => __SliderState();
}

class __SliderState extends State<SliderCustom> {
  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant SliderCustom oldWidget) {
    value = widget.initialValue;

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.label),
          Slider(
            value: value,
            min: widget.min,
            max: widget.max,
            label: value.toStringAsFixed(2),
            onChangeEnd: (value) {
              widget.onChange(value);
            },
            onChanged: (value) {
              setState(() {
                this.value = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
