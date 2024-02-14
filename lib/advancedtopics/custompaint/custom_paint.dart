import 'package:flutter/material.dart';

class CustomPaint extends StatefulWidget {
  const CustomPaint({super.key});

  @override
  State<CustomPaint> createState() => _CustomPaintState();
}

class _CustomPaintState extends State<CustomPaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
    );
  }
}
