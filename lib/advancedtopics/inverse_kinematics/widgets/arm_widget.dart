import 'package:flutter/material.dart';
import 'package:flutter_advanced/advancedtopics/inverse_kinematics/parts/anchor.dart';
import 'package:flutter_advanced/advancedtopics/inverse_kinematics/parts/bone.dart';

class ArmWidget extends StatelessWidget {
  final Anchor anchor;
  const ArmWidget({super.key, required this.anchor});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArmPainter(anchor),
    );
  }
}

class ArmPainter extends CustomPainter {
  final Anchor anchor;

  ArmPainter(this.anchor);
  @override
  void paint(Canvas canvas, Size size) {
    Paint blueFill = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Paint blackFill = Paint()
      ..color = Colors.grey.shade700
      ..style = PaintingStyle.fill;
    Paint blackStroke = Paint()
      ..color = Colors.grey.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Bone child = anchor.child;
    while (child != null) {

      canvas.drawCircle(child.getAttachPoint(), 10, blackFill);
      canvas.drawLine(
          child.getAttachPoint(), child.parent.getAttachPoint(), blackStroke);
      canvas.drawCircle(anchor.loc, 15, blueFill);
      child = child.child;

    }


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
