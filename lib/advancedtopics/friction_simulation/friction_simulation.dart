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
  double drag = 1;
  double position = 1;
  double velocity = 1;

  @override
  void initState() {
    super.initState();
    blockAnimationController = AnimationController.unbounded(vsync: this);
  }

  void _nudgeBlock() {
    FrictionSimulation nonMovingSimulation =
        FrictionSimulation(drag, position, velocity);
    blockAnimationController.animateWith(nonMovingSimulation);
  }

  void _resetBlock() {
    FrictionSimulation nonMovingSimulation = FrictionSimulation(0, 0, 0);
    blockAnimationController.animateWith(nonMovingSimulation);
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
                  Slider(
                    min: 0.0,
                    max: 2,
                    value: drag,
                    onChanged: (val) {
                      setState(() {
                        drag = val;
                      });
                    },
                  ),
                  Slider(
                    min: 0.0,
                    max: 10,
                    value: position,
                    onChanged: (val) {
                      setState(() {
                        position = val;
                      });
                    },
                  ),
                  Slider(
                    min: 0.0,
                    max: 1000,
                    value: velocity,
                    onChanged: (val) {
                      setState(() {
                        velocity = val;
                      });
                    },
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
                child: Container(color: Colors.red),
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
