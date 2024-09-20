import 'package:flutter/material.dart';

class PixelData {
  final Offset position;
  final Color color;
  double get brightness => 1 - color.computeLuminance();
  final double size;

  const PixelData(
    this.position,
    this.color,
    this.size,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PixelData &&
        other.position == position &&
        other.color == color &&
        other.size == size;
  }

  @override
  int get hashCode => position.hashCode ^ color.hashCode ^ size.hashCode;
}
