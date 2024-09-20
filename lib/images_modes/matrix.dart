import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image/image.dart' as img;
import 'package:image_processing/components/bottom_bar.dart';
import 'package:image_processing/components/slider.dart';
import 'package:image_processing/entities/pixel_data.dart';

class MatrixImage extends StatefulWidget {
  const MatrixImage(this.imageData, {super.key});

  final Uint8List imageData;

  @override
  State<MatrixImage> createState() => _MatrixImageState();
}

class _MatrixImageState extends State<MatrixImage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  List<PixelData> pixels = [];
  int size = 100;
  Size canvasSize = Size.zero;
  Size imageSize = Size.zero;
  late Ticker ticker;
  Duration dt = Duration.zero;

  @override
  void initState() {
    ticker = createTicker((newdt) {
      setState(() {
        dt = newdt;
      });
    });
    ticker.start();
    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
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
                          painter: _MatrixPainter(
                            pixels,
                            dt,
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
              min: 25,
              max: 400,
              label: 'Resolução',
              onChange: (newValue) {
                if (newValue == size) return;
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

class _MatrixPainter extends CustomPainter {
  final List<PixelData> pixels;
  final Duration dt;

  _MatrixPainter(
    this.pixels,
    this.dt,
  );
  final ascii = "诶比西迪伊艾弗吉艾尺艾杰开艾勒艾马";
  @override
  void paint(Canvas canvas, Size size) {
    final listAscii = ascii.split("");
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
    final random = Random();
    for (final pixel in pixels) {
      final letter = listAscii[random.nextInt(listAscii.length)];
      final text = TextPainter(
        text: TextSpan(
          text: letter,
          style: TextStyle(
            fontSize: height * 1.2 * (pixel.brightness.clamp(0.75, 1)),
            color: Colors.green.shade900.withAlpha(
              (pixel.brightness * 255).ceil().clamp(100, 255),
            ),
          ),
        ),
        textDirection: TextDirection.rtl,
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
  bool shouldRepaint(_MatrixPainter oldDelegate) =>
      oldDelegate.dt != dt || oldDelegate.pixels != pixels;

  @override
  bool shouldRebuildSemantics(_MatrixPainter oldDelegate) => false;
}
