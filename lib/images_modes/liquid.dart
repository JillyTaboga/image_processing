import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image/image.dart' as img;
import 'package:image_processing/entities/quad_tree.dart';
import 'package:vector_math/vector_math.dart' as vec;

class Liquid extends StatefulWidget {
  const Liquid(
    this.imageData, {
    super.key,
  });

  final Uint8List imageData;

  @override
  State<Liquid> createState() => _LiquidState();
}

class _LiquidState extends State<Liquid> with SingleTickerProviderStateMixin {
  Size canvasSize = Size.zero;
  bool isLoading = true;
  QuadTree<img.Pixel>? pixels;
  double space = 50;
  List<_Point> points = [];
  Ticker? ticker;
  Duration lastTick = Duration.zero;

  @override
  void dispose() {
    ticker?.dispose();
    super.dispose();
  }

  calculate() async {
    if (canvasSize.width == 0) return;
    final command = img.Command();
    command.decodeImage(widget.imageData);
    final isWidht = canvasSize.width > canvasSize.height;
    command.copyResize(
      width: isWidht ? canvasSize.width.floor() : null,
      height: !isWidht ? canvasSize.height.floor() : null,
      maintainAspect: true,
    );
    await command.executeThread();
    final image = command.outputImage;
    if (image == null) return;
    QuadTree<img.Pixel> pixelTree = QuadTree<img.Pixel>(
      bounds: canvasSize,
      anchor: Offset.zero,
      maxPoints: 20,
    );
    for (final pixel in image) {
      pixelTree.add(
        QuadTreePoint<img.Pixel>(
          position: Offset(pixel.x / 1, pixel.y / 1),
          data: pixel,
          radius: 50,
        ),
      );
    }
    pixels = pixelTree;

    final columns = (canvasSize.width / space).floor();
    final rows = (canvasSize.height / space).floor();
    points.clear();
    for (int c = 0; c < columns; c++) {
      for (int r = 0; r < rows; r++) {
        points.add(
          _Point(
            position: vec.Vector2(
              (c * space) + space,
              (r * space) + space,
            ),
            velocity: vec.Vector2.zero(),
            radius: 2,
          ),
        );
      }
    }
    if (pixels == null) return;
    ticker = createTicker((dt) {
      for (final point in points) {
        point.update((dt.inMilliseconds - lastTick.inMilliseconds) / 1);
        final otherPoints = pixels!.query(
          Offset(point.position.x, point.position.y),
          100,
        );
        final x = otherPoints.fold<double>(0, (p, e) => p + e.position.dx) /
            otherPoints.length;
        final y = otherPoints.fold<double>(0, (p, e) => p + e.position.dy) /
            otherPoints.length;
        final mediumBright = otherPoints.fold<double>(0,
                (p, e) => p + (e.data.luminanceNormalized / 255).clamp(0, 1)) /
            otherPoints.length;
        point.applyForce(
          vec.Vector2(x, y),
          mediumBright,
        );
      }
      if (mounted) {
        setState(() {
          lastTick = dt;
        });
        if (dt.inSeconds > 50) {
          ticker?.stop();
        }
      }
    });
    ticker?.start();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.biggest != canvasSize) {
          Future(() {
            canvasSize = constraints.biggest;

            calculate();
          });
        }
        return CustomPaint(
          painter: _LiquidPainter(
            points: points,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _LiquidPainter extends CustomPainter {
  List<_Point> points;
  _LiquidPainter({
    required this.points,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final point in points) {
      canvas.drawCircle(
        Offset(
          point.position.x - (point.radius / 2),
          point.position.y - (point.radius / 2),
        ),
        point.radius,
        Paint()..color = Colors.black,
      );
    }
  }

  @override
  bool shouldRepaint(_LiquidPainter oldDelegate) =>
      points != oldDelegate.points;

  @override
  bool shouldRebuildSemantics(_LiquidPainter oldDelegate) => false;
}

class _Point {
  vec.Vector2 position;
  vec.Vector2 velocity;
  double radius;

  _Point({
    required this.position,
    required this.velocity,
    required this.radius,
  });

  update(double dt) {
    if (dt == 0 || (velocity.x == 0 && velocity.y == 0)) return;
    position = velocity * dt / 1000;
    velocity = vec.Vector2.zero();
  }

  applyForce(vec.Vector2 otherPosition, double force) {
    if (position.distanceTo(otherPosition) > 10) {
      velocity = otherPosition * force;
    }
  }
}
