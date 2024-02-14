import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/widgets/glass_of_liquid.dart';

class CustomPaint1 extends StatefulWidget {
  const CustomPaint1({super.key});

  @override
  State<CustomPaint1> createState() => _CustomPaint1State();
}

class _CustomPaint1State extends State<CustomPaint1> {
  double skew = 0.2;
  double fullness = 0.7;
  double ratio = 0.7;
  double cupWidth = 0.2;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Center(
                child: Container(
                  width: cupWidth * 500,
                  height: 280,
                  child: CustomPaint(
                    painter: GlassOfLiquid(0.01 + skew * 0.4, ratio ,fullness),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Slider(value: skew, onChanged: (newValue){
                setState(() {
                  this.skew = newValue;
                });
              }),
            ),
            Expanded(
              child: Slider(value: fullness, onChanged: (newValue){
                setState(() {
                  this.fullness = newValue;
                });
              }),
            ),
            Expanded(
              child: Slider(value: ratio, onChanged: (newValue){
                setState(() {
                  this.ratio = newValue;
                });
              }),
            ),
            Expanded(
              child: Slider(value: cupWidth, onChanged: (newValue){
                setState(() {
                  this.cupWidth = newValue;
                });
              }),
            )
          ],
        ),
      ),
    );
  }
}
