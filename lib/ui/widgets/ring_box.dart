import 'dart:ui';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final ValueNotifier<double> radius;
  final Paint _paint, _outerPainter;

  CirclePainter(this.radius)
      : _paint = Paint()..color = Colors.white,
        _outerPainter = Paint()
          ..color = Colors.pink
          ..style = PaintingStyle.stroke,
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
  final Paint _paint;

  DiameterPainter(this.radius)
      : _paint = Paint()..color = Colors.black,
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
  final double _boxHeight = 150;

  final double _boxWidth = 150;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
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
          ],
        ),
        ValueListenableBuilder(
          valueListenable: _radiusNotifier,
          builder: (context, radius, _) {
            return Slider(
              value: radius,
              min: 5.0,
              max: 30.0,
              onChanged: (value) => _radiusNotifier.value = value,
            );
          },
        ),
        // show the value of the slider
        ValueListenableBuilder(
          valueListenable: _radiusNotifier,
          builder: (context, radius, _) {
            return Text(
              'Radius: ${radius.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.displaySmall,
            );
          },
        ),
      ],
    );
  }
}
