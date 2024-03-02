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
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    List<double> weights = [1.0, 0.1, 0.3, 0.3, 1.0];

    marioX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.5), weight: weights[0]),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.5), weight: weights[1]),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.5), weight: weights[2]),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.5), weight: weights[3]),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.0), weight: weights[4]),
    ]).animate(animationController);

    marioY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[0]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[1]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOutQuad)), weight: weights[2]),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeInQuad)), weight: weights[3]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[4]),
    ]).animate(animationController);

    marioFrame = TweenSequence<int>([
      TweenSequenceItem(tween: walkAnimation(), weight: weights[0]),
      TweenSequenceItem(tween: IntTween(begin: 1, end: 1), weight: weights[1]),
      TweenSequenceItem(tween: IntTween(begin: 5, end: 5), weight: weights[2]),
      TweenSequenceItem(tween: IntTween(begin: 5, end: 5), weight: weights[3]),
      TweenSequenceItem(tween: walkAnimation(), weight: weights[4]),
    ]).animate(animationController);

    blockY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[0]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[1]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[2]),
      TweenSequenceItem(tween: TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1.0),
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 1.0),
      ]), weight: weights[3]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[4]),
    ]).animate(animationController);

    blockFrame = TweenSequence<int>([
      TweenSequenceItem(tween: IntTween(begin: 1, end: 1), weight: weights[0]),
      TweenSequenceItem(tween: IntTween(begin: 1, end: 1), weight: weights[1]),
      TweenSequenceItem(tween: IntTween(begin: 1, end: 1), weight: weights[2]),
      TweenSequenceItem(tween: IntTween(begin: 1, end: 2), weight: weights[3]),
      TweenSequenceItem(tween: IntTween(begin: 2, end: 2), weight: weights[4]),
    ]).animate(animationController);

    coinY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[0]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[1]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[2]),
      TweenSequenceItem(tween: TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1.0),
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 1.0),
      ]), weight: weights[3]),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: weights[4]),
    ]).animate(animationController);


    animationController.repeat();
  }
  
  walkAnimation() => TweenSequence([
    TweenSequenceItem(tween: StepTween(begin: 2, end: 5), weight: 1),
    TweenSequenceItem(tween: StepTween(begin: 2, end: 5), weight: 1),
    TweenSequenceItem(tween: StepTween(begin: 2, end: 5), weight: 1),
    TweenSequenceItem(tween: StepTween(begin: 2, end: 5), weight: 1),
  ]);



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Stack(
        children: [
          AnimatedBuilder(animation: animationController, builder: (context, child) {
            return Positioned(
                left: size.width/2 - 16,
                top: (size.height * 0.5) - 95 - 120 * coinY.value,
                child: const Image(
                  image: AssetImage("assets/coin.png"),
                  gaplessPlayback: true,
                ));
          }),
          AnimatedBuilder(animation: animationController, builder: (context, child) {
            return Positioned(
                left: size.width/2 - 16,
                top: (size.height * 0.5) - 95 -10 * blockY.value,
                child: Image(
                  image: AssetImage("assets/block_${blockFrame.value}.png"),
                  gaplessPlayback: true,
                ));
          }),

          AnimatedBuilder(animation: animationController, builder: (context, child) {
            return Positioned(
                left: marioX.value * size.width - 16,
                top: (size.height * 0.5) - 80 * marioY.value,
                child: Image(
                  image: AssetImage("assets/mario_${marioFrame.value}.png"),
                  gaplessPlayback: true,
                ));
          }),

        ],
      ),
    );
  }
}
