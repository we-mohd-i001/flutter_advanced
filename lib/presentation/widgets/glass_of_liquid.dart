import 'dart:math';

import 'package:flutter/material.dart';

class GlassOfLiquid extends CustomPainter {
  final double skew;
  final double ratio;
  final double fullness;


  GlassOfLiquid(this.skew, this.ratio, this.fullness);

  @override
  void paint(Canvas canvas, Size size) {
    Paint glass = Paint()
      ..color = Colors.white.withAlpha(150)
      ..style = PaintingStyle.fill;

    Paint liquidPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Paint liquidColor = Paint()
      ..color = Color.fromARGB(255, 235, 235, 235)
      ..style = PaintingStyle.fill;

    Paint black = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    
    Rect top = Rect.fromLTRB(0, 0, size.width, size.width*skew);
    Rect bottom = Rect.fromCenter(
        center: Offset(
            size.width * 0.5, size.height - size.width * 0.5 * skew * ratio),
        width: size.width * ratio,
        height: size.width * skew * ratio
    );

    Path cupPath = Path()
      ..moveTo(top.left, top.top + top.height * 0.5)
      ..arcTo(top, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height * 0.5)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(top.left, top.top + top.height * 0.5);

    Rect? liquidTop = Rect.lerp(bottom, top, fullness);

    Path liquidPath = Path()
      ..moveTo(liquidTop!.left, liquidTop.top + liquidTop.height * 0.5)
      ..arcTo(liquidTop, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height * 0.5)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(liquidTop.left, liquidTop.top + liquidTop.height * 0.5);





    canvas.drawPath(cupPath, glass);
    canvas.drawPath(liquidPath, liquidColor);
    canvas.drawOval(liquidTop, liquidPaint);
    canvas.drawPath(cupPath, black);
    canvas.drawOval(top, black);
  }

  @override
  bool shouldRepaint(GlassOfLiquid oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.fullness != fullness
        || oldDelegate.skew !=skew
        || oldDelegate.ratio != ratio;
  }
}
