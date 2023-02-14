import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ring_size_calculator/util/util.dart';
import 'dart:math' show pi;

class CirclePainter extends CustomPainter {
  final ValueNotifier<double> radius;
  final Paint _paint, _outerPainter;

  CirclePainter(this.radius)
      : _paint = Paint()..color = Colors.white,
        _outerPainter = Paint()
          ..color = Colors.pink
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
        super(repaint: radius);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 2 * radius.value, _paint);
    canvas.drawCircle(center, 2 * radius.value, _outerPainter);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => false;
}

class DiameterPainter extends CustomPainter {
  final ValueNotifier<double> radius;
  final Paint _paint, _outerLinesPaint;

  DiameterPainter(this.radius)
      : _paint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
        _outerLinesPaint = Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
        super(repaint: radius);

  @override
  void paint(Canvas canvas, Size size) {
    const arrowshift = 4.0;
    final leftOffset = Offset(size.width / 2 - (2 * radius.value), size.height / 2);
    final rightOffset = Offset(size.width / 2 + (2 * radius.value), size.height / 2);
    canvas.drawLine(leftOffset, rightOffset, _paint);

    // left arrow
    canvas.drawPoints(
      PointMode.lines,
      [
        leftOffset,
        Offset(leftOffset.dx + arrowshift, leftOffset.dy + arrowshift),
        leftOffset,
        Offset(leftOffset.dx + arrowshift, leftOffset.dy - arrowshift),
      ],
      _paint,
    );

    // right arrow
    canvas.drawPoints(
      PointMode.lines,
      [
        rightOffset,
        Offset(rightOffset.dx - arrowshift, leftOffset.dy + arrowshift),
        rightOffset,
        Offset(rightOffset.dx - arrowshift, leftOffset.dy - arrowshift),
      ],
      _paint,
    );

    final topOffset = Offset(size.width / 2, size.height / 2 - (2 * radius.value));
    final bottomOffset = Offset(size.width / 2, size.height / 2 + (2 * radius.value));
    canvas.drawLine(topOffset, bottomOffset, _paint);

    // draw top arrow
    canvas.drawPoints(
      PointMode.lines,
      [
        topOffset,
        Offset(topOffset.dx + arrowshift, topOffset.dy + arrowshift),
        topOffset,
        Offset(topOffset.dx - arrowshift, topOffset.dy + arrowshift),
      ],
      _paint,
    );

    // draw bottom arrow
    canvas.drawPoints(
      PointMode.lines,
      [
        bottomOffset,
        Offset(bottomOffset.dx + arrowshift, bottomOffset.dy - arrowshift),
        bottomOffset,
        Offset(bottomOffset.dx - arrowshift, bottomOffset.dy - arrowshift),
      ],
      _paint,
    );

    // canvas draw lines
    final center = Offset(size.width / 2, size.height / 2);
    final lshift = center.dx - 2 * radius.value;
    final rShift = center.dx + 2 * radius.value;

    // vertical
    canvas.drawLine(Offset(lshift, 0.0), Offset(lshift, size.height), _outerLinesPaint);
    canvas.drawLine(Offset(rShift, 0.0), Offset(rShift, size.height), _outerLinesPaint);

    // horizontal
    canvas.drawLine(Offset(0.0, lshift), Offset(size.width, lshift), _outerLinesPaint);
    canvas.drawLine(Offset(0.0, rShift), Offset(size.width, rShift), _outerLinesPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GraphPaper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < size.width; i += 10) {
      canvas.drawLine(Offset(i.toDouble(), 0), Offset(i.toDouble(), size.height), paint);
      canvas.drawLine(Offset(0, i.toDouble()), Offset(size.width, i.toDouble()), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RingBox extends StatefulWidget {
  const RingBox({super.key});

  @override
  State<RingBox> createState() => _RingBoxState();
}

class _RingBoxState extends State<RingBox> {
  final double _boxHeight = 180;

  final double _boxWidth = 180;

  late final ValueNotifier<double> _radiusNotifier;

  @override
  void initState() {
    super.initState();
    _radiusNotifier = ValueNotifier(20.0);
  }

  @override
  void dispose() {
    _radiusNotifier.dispose();
    super.dispose();
  }

  _getTheRightSize(double size) {
    int x = 6;
    if (size >= 14.2 && size < 14.6) {
      x = 6;
    } else if (size >= 14.6 && size < 14.9) {
      x = 7;
    } else if (size >= 14.6 && size <= 15.2) {
      x = 8;
    } else if (size > 15.2 && size <= 15.6) {
      x = 9;
    } else if (size > 15.6 && size <= 15.8) {
      x = 10;
    } else if (size > 15.8 && size <= 16.2) {
      x = 11;
    } else if (size > 16.2 && size <= 16.4) {
      x = 12;
    } else if (size > 16.4 && size <= 16.75) {
      x = 13;
    } else if (size > 16.75 && size <= 16.95) {
      x = 14;
    } else if (size > 16.95 && size <= 17.45) {
      x = 15;
    } else if (size > 17.45 && size <= 17.65) {
      x = 16;
    } else if (size > 17.65 && size <= 18.05) {
      x = 17;
    } else if (size > 18.05 && size <= 18.25) {
      x = 18;
    } else if (size > 18.25 && size <= 18.75) {
      x = 19;
    } else if (size > 18.75 && size <= 18.95) {
      x = 20;
    } else if (size > 18.95 && size <= 19.35) {
      x = 21;
    } else if (size > 19.35 && size <= 19.65) {
      x = 22;
    } else if (size > 19.65 && size <= 19.95) {
      x = 23;
    } else if (size > 19.95 && size <= 20.25) {
      x = 24;
    } else if (size > 20.25 && size <= 20.65) {
      x = 25;
    } else if (size > 20.65 && size <= 21.0) {
      x = 26;
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Stack(
              children: [
                // create the graph paper
                CustomPaint(
                  painter: GraphPaper(),
                  size: Size(_boxWidth, _boxHeight),
                ),
                Container(
                  height: _boxHeight,
                  width: _boxWidth,
                  margin: const EdgeInsets.all(10),
                  child: CustomPaint(
                    painter: CirclePainter(_radiusNotifier),
                    foregroundPainter: DiameterPainter(_radiusNotifier),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Put the ring on the circle to determine its size. Use the slider below to choose the right size of the ring.",
                  maxLines: 10,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            )
          ],
        ),
        ValueListenableBuilder(
          valueListenable: _radiusNotifier,
          builder: (context, radius, _) {
            return Slider(
              value: radius,
              min: 18.0,
              max: 30.0,
              onChangeEnd: (value) {
                final size = 2 * value / MediaQuery.of(context).devicePixelRatio;
                final x = _getTheRightSize(size);
                //TODO: the x value from firebase;
              },
              label: "Slider It to adjust the circle",
              onChanged: (value) => _radiusNotifier.value = value,
            );
          },
        ),
        // show the value of the slider
        ValueListenableBuilder(
          valueListenable: _radiusNotifier,
          builder: (context, radius, _) {
            return Text(
              'Inner Diameter: ${radius * 2 / MediaQuery.of(context).devicePixelRatio}',
              style: Theme.of(context).textTheme.labelLarge,
            );
          },
        ),
      ],
    );
  }
}
