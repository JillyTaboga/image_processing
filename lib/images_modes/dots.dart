import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_processing/components/bottom_bar.dart';
import 'package:image_processing/components/color_picker.dart';
import 'package:image_processing/components/slider.dart';
import 'package:image_processing/entities/pixel_data.dart';

class Dots extends StatefulWidget {
  const Dots(this.imageData, {super.key});

  final Uint8List imageData;

  @override
  State<Dots> createState() => _DotState();
}

class _DotState extends State<Dots> {
  bool isLoading = true;
  List<PixelData> pixels = [];
  int size = 100;
  Size canvasSize = Size.zero;
  Size imageSize = Size.zero;
  bool scale = false;
  Color? color;

  @override
  void initState() {
    super.initState();
  }

  initialize() async {
    if (canvasSize.width == 0) return;
    pixels.clear();
    final ref = img.decodeImage(widget.imageData);
    if (ref == null) return;
    final greatestSize = max(ref.width, ref.height);
    final isWidht = greatestSize == ref.width;
    final command = img.Command();
    command.decodeImage(widget.imageData);
    command.copyResize(
      width: isWidht ? size : null,
      height: !isWidht ? size : null,
      maintainAspect: true,
    );
    await command.executeThread();
    final image = command.outputImage;
    if (image == null) return;
    imageSize = Size(image.width / 1, image.height / 1);
    final width = canvasSize.width / image.width;
    final height = canvasSize.height / image.height;
    for (int n = 0; n < image.width; n++) {
      for (int m = 0; m < image.height; m++) {
        final pixel = image.getPixel(n, m);
        pixels.add(
          PixelData(
            Offset(
              n / 1,
              m / 1,
            ),
            Color.fromARGB(
              (pixel.a).toInt(),
              (pixel.r).toInt(),
              (pixel.g).toInt(),
              (pixel.b).toInt(),
            ),
            min(width, height),
          ),
        );
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (canvasSize != constraints.biggest) {
                Future(() {
                  canvasSize = constraints.biggest;
                  initialize();
                });
              }
              return (isLoading ||
                      imageSize.width == 0 ||
                      canvasSize.width == 0)
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: AspectRatio(
                        aspectRatio: imageSize.aspectRatio,
                        child: CustomPaint(
                          painter: _DotsPainter(
                            pixels,
                            scale,
                            color,
                          ),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    );
            },
          ),
        ),
        BottomBar(
          children: [
            SliderCustom(
              initialValue: size / 1,
              label: 'Resolução',
              min: 25,
              max: 750,
              onChange: (newValue) {
                size = newValue.toInt();
                initialize();
              },
            ),
            Column(
              children: [
                const Text('Escala'),
                Checkbox(
                  value: scale,
                  onChanged: (value) {
                    setState(() {
                      scale = value!;
                    });
                  },
                ),
              ],
            ),
            ColorPicker(
              onChange: (newColor) {
                setState(() {
                  color = newColor;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _DotsPainter extends CustomPainter {
  final List<PixelData> pixels;
  final bool scale;
  final Color? color;

  _DotsPainter(
    this.pixels,
    this.scale,
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final widht = size.width /
        (pixels.fold<double>(
          0,
          (p, e) => p > e.position.dx ? p : e.position.dx,
        ));
    final height = size.height /
        pixels.fold<double>(
          0,
          (p, e) => p > e.position.dy ? p : e.position.dy,
        );
    for (final pixel in pixels) {
      final radius = widht / 2 * (scale ? pixel.brightness : 1);
      canvas.drawCircle(
        Offset(
          pixel.position.dx * widht,
          pixel.position.dy * height,
        ),
        radius,
        Paint()
          ..color = (color?.withAlpha(pixel.color.alpha).withOpacity(
                    pixel.brightness,
                  )) ??
              pixel.color
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(_DotsPainter oldDelegate) =>
      pixels != oldDelegate.pixels ||
      scale != oldDelegate.scale ||
      color != oldDelegate.color;

  @override
  bool shouldRebuildSemantics(_DotsPainter oldDelegate) => false;
}
