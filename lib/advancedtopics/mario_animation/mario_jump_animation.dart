import 'package:flutter/material.dart';

class MarioJumpAnimation extends StatefulWidget {
  const MarioJumpAnimation({super.key});

  @override
  State<MarioJumpAnimation> createState() => _MarioJumpAnimationState();
}

class _MarioJumpAnimationState extends State<MarioJumpAnimation>
  with SingleTickerProviderStateMixin{
  late AnimationController animationController;

  late Animation<double> marioX;
  late Animation<double> marioY;
  late Animation<int> marioFrame;

  late Animation<double> blockY;
  late Animation<int> blockFrame;

  late Animation<double> coinY;



  @override
  void initState(){
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 8));
    List<double> weights = [1.0, 1.0, 1.0, 1.0, 1.0];

    marioX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.5), weight: 0.3),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.5), weight: 0.3),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.0), weight: 1),
    ]).animate(animationController);

    marioY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOutQuad)), weight: 0.3),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeInQuad)), weight: 0.3),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 1),
    ]).animate(animationController);

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Stack(
        children: [
          AnimatedBuilder(animation: animationController, builder: (context, child) {
            return Positioned(
                left: marioX.value * size.width - 27,
                top: (size.height * 0.5) - 80 * marioY.value,
                child: const Icon(Icons.reddit, size: 56,));
          })
        ],
      ),
    );
  }
}
