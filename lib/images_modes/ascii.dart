import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_processing/components/bottom_bar.dart';
import 'package:image_processing/components/slider.dart';
import 'package:image_processing/entities/pixel_data.dart';

class Ascii extends StatefulWidget {
  const Ascii(this.imageData, {super.key});

  final Uint8List imageData;

  @override
  State<Ascii> createState() => _AsciiState();
}

class _AsciiState extends State<Ascii> {
  bool isLoading = true;
  List<PixelData> pixels = [];
  int size = 100;
  Size canvasSize = Size.zero;
  Size imageSize = Size.zero;

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
                          painter: _AsciiPainter(pixels),
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
              min: 25,
              max: 750,
              label: 'Resolução',
              onChange: (newValue) {
                size = newValue.toInt();
                initialize();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _AsciiPainter extends CustomPainter {
  final List<PixelData> pixels;

  _AsciiPainter(this.pixels);
  final ascii =
      " `.-':_,^=;><+!rc*/z?sLTv)J7(|Fi{C}fI31tlu[neoZ5Yxjya]2ESwqkP6h9d4VpOGbUAKXHm8RD#\$Bg0MNWQ%&@";
  List<String> get listAscii => ascii.split("");
  String asciiByLuminance(double luminance) {
    final lenght = listAscii.length;
    final index = (luminance * lenght).floor().clamp(0, lenght - 1);
    return listAscii[index];
  }

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
      final text = TextPainter(
        text: TextSpan(
          text: asciiByLuminance(
            pixel.brightness,
          ),
          style: TextStyle(
            fontSize: height * 1.3,
            color: Colors.black,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      text.layout(
        maxWidth: widht,
        minWidth: widht,
      );
      text.paint(
        canvas,
        Offset(
          pixel.position.dx * widht,
          pixel.position.dy * height,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(_AsciiPainter oldDelegate) => pixels != oldDelegate.pixels;

  @override
  bool shouldRebuildSemantics(_AsciiPainter oldDelegate) => false;
}
