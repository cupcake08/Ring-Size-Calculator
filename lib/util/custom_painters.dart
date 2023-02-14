import 'dart:ui';

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final ValueNotifier<double> radius;
  final Paint _paint, _outerPainter;

  CirclePainter(this.radius)
      : _paint = Paint()..color = Colors.white,
        _outerPainter = Paint()
          ..color = Colors.pink
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
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
          ..color = Colors.purple
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
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
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    for (int i = 0; i <= size.width; i += 10) {
      canvas.drawLine(Offset(i.toDouble(), 0), Offset(i.toDouble(), size.height), paint);
      canvas.drawLine(Offset(0, i.toDouble()), Offset(size.width, i.toDouble()), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
