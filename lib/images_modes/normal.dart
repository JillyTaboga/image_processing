import 'dart:typed_data';

import 'package:flutter/widgets.dart';

class NormalImage extends StatelessWidget {
  const NormalImage(this.image, {super.key});

  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      image,
      fit: BoxFit.contain,
    );
  }
}
