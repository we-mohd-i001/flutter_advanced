import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class FrictionSimulationPage extends StatefulWidget {
  const FrictionSimulationPage({super.key});

  @override
  State<FrictionSimulationPage> createState() => _FrictionSimulationState();
}

class _FrictionSimulationState extends State<FrictionSimulationPage>
    with TickerProviderStateMixin {
  late AnimationController blockAnimationController;
  double mass = 5;
  double stiffness = 50;
  double damping = 1;

  late SpringSimulation displayedSpringSimulation;
  bool isSpringing = false;

  @override
  void initState() {
    super.initState();
    blockAnimationController = AnimationController.unbounded(vsync: this);
    _recalculateDisplayedSpringSimulation();
  }

  void _nudgeBlock() {
    FrictionSimulation nudgeSimulation = FrictionSimulation(0.2, 0.0, 320);
    blockAnimationController.animateWith(nudgeSimulation);
    isSpringing = false;
  }

  void _resetBlock() {
    FrictionSimulation nonMovingSimulation = FrictionSimulation(0, 0, 0);
    blockAnimationController.animateWith(nonMovingSimulation);
    isSpringing = false;
  }

  void _springBack() {
    SpringDescription springDescription =
        SpringDescription(mass: mass, stiffness: stiffness, damping: damping);
    SpringSimulation springSim = SpringSimulation(
        springDescription, blockAnimationController.value, 0, 0);
    blockAnimationController.animateWith(springSim);
    isSpringing = true;
  }

  void _recalculateDisplayedSpringSimulation(){
    SpringDescription springDescription = SpringDescription(mass: mass, stiffness: stiffness, damping: damping);

    setState(() {
      displayedSpringSimulation = SpringSimulation(springDescription, 400, 0, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Friction Simulation'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Mass     '),
                      Slider(
                        min: 0.0,
                        max: 10,
                        value: mass,
                        onChanged: (val) {
                          setState(() {
                            mass = val;
                          });
                        },
                      ),
                      Text(mass.toStringAsFixed(2)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Stiffness'),
                      Slider(
                        min: 0.0,
                        max: 100,
                        value: stiffness,
                        onChanged: (val) {
                          setState(() {
                            stiffness = val;
                          });
                        },
                      ),
                      Text(stiffness.toStringAsFixed(2)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Damping'),
                      Slider(
                        min: 0.0,
                        max: 4,
                        value: damping,
                        onChanged: (val) {
                          setState(() {
                            damping = val;
                          });
                        },
                      ),
                      Text(damping.toStringAsFixed(2)),
                    ],
                  ),
                ],
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height / 3,
            child: Container(
              color: Colors.blue,
            ),
          ),
          AnimatedBuilder(
            animation: blockAnimationController,
            builder: (context, snapshot) {
              return Positioned(
                width: 50,
                height: 50,
                bottom: size.height / 3,
                left: size.width / 4 - 25 + blockAnimationController.value,
                child: Container(decoration: const BoxDecoration(
                    color: Colors.red,
                  shape: BoxShape.circle
                ),),
              );
            },
          ),
          Positioned(
            bottom: size.height / 7,
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: _nudgeBlock, child: const Text('NUDGE')),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        onPressed: _resetBlock, child: const Text('RESET')),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        onPressed: _springBack, child: const Text('SPRING BACK')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
