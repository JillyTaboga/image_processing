import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_processing/components/bottom_bar.dart';
import 'package:image_processing/components/color_picker.dart';
import 'package:image_processing/components/slider.dart';

class Spiral extends StatefulWidget {
  const Spiral(this.imageData, {super.key});

  final Uint8List imageData;

  @override
  State<Spiral> createState() => _DotState();
}

class _DotState extends State<Spiral> {
  bool isLoading = true;
  img.Image? image;
  double size = 0;
  double radiusInc = 0.01;
  double angleInc = 0.005;
  double dotSize = 5;
  Size canvasSize = Size.zero;
  Size imageSize = Size.zero;
  Color? color = Colors.black;

  @override
  void initState() {
    super.initState();
  }

  initialize() async {
    if (canvasSize.width == 0) return;
    final command = img.Command();
    command.decodeImage(widget.imageData);
    await command.executeThread();
    setState(() {
      image = command.outputImage;
      imageSize = Size(
        (image?.width ?? 0) / 1,
        (image?.height ?? 0) / 1,
      );
      size = min(imageSize.width, imageSize.height);
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
                      image == null ||
                      imageSize.width == 0 ||
                      canvasSize.width == 0)
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: AspectRatio(
                        aspectRatio: imageSize.aspectRatio,
                        child: CustomPaint(
                          painter: _SpiralPainter(
                            image!,
                            color,
                            radiusInc,
                            angleInc,
                            dotSize,
                            size,
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
            if (size > 0)
              SliderCustom(
                initialValue: size,
                min: 0.1,
                max: min(imageSize.width, imageSize.height) * 2,
                label: 'Incremento',
                onChange: (newValue) {
                  setState(() {
                    size = newValue;
                  });
                },
              ),
            ColorPicker(
              initialValue: color,
              onChange: (newColor) {
                setState(() {
                  color = newColor;
                });
              },
            ),
            SliderCustom(
              initialValue: radiusInc,
              min: 0.005,
              max: 0.02,
              label: 'Radius',
              onChange: (newValue) {
                setState(() {
                  radiusInc = newValue;
                });
              },
            ),
            SliderCustom(
              initialValue: angleInc,
              min: 0.0005,
              max: 0.015,
              label: 'Angulo',
              onChange: (newValue) {
                setState(() {
                  angleInc = newValue;
                });
              },
            ),
            SliderCustom(
              initialValue: dotSize,
              min: 0.5,
              max: 20,
              label: 'Ponto',
              onChange: (newValue) {
                setState(() {
                  dotSize = newValue;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _SpiralPainter extends CustomPainter {
  final img.Image image;
  final Color? color;
  final double radiusIncrement;
  final double angleIncrement;
  final double dotSize;
  final double maxSize;

  _SpiralPainter(
    this.image,
    this.color,
    this.radiusIncrement,
    this.angleIncrement,
    this.dotSize,
    this.maxSize,
  );

  @override
  void paint(Canvas canvas, Size size) {
    double angle = 0;
    final center = Offset(size.width / 2, size.height / 2);
    for (double i = 0; i < maxSize; i += radiusIncrement) {
      final x = center.dx + i * cos(angle);
      final y = center.dy + i * sin(angle);
      if (x < 0 || x > size.width || y < 0 || y > size.height) {
        angle += angleIncrement;
        return;
      }
      img.Pixel? pixel;
      try {
        pixel = image.getPixel(
          (x * image.width / size.width).floor(),
          (y * image.height / size.height).floor(),
        );
      } catch (e) {
        //
      }
      final pixelColor = (pixel == null)
          ? Colors.black
          : Color.fromARGB(
              pixel.a.toInt().clamp(0, 255),
              pixel.r.toInt().clamp(0, 255),
              pixel.g.toInt().clamp(0, 255),
              pixel.b.toInt().clamp(0, 255),
            );
      canvas.drawOval(
        Rect.fromLTWH(
          x,
          y,
          dotSize * (1 - pixelColor.computeLuminance().clamp(0, 0.5)),
          dotSize * (1 - pixelColor.computeLuminance().clamp(0, 0.5)),
        ),
        Paint()
          ..color = color ?? pixelColor
          ..style = PaintingStyle.fill,
      );
      angle += angleIncrement;
    }
  }

  @override
  bool shouldRepaint(_SpiralPainter oldDelegate) =>
      image != oldDelegate.image || color != oldDelegate.color;

  @override
  bool shouldRebuildSemantics(_SpiralPainter oldDelegate) => false;
}
