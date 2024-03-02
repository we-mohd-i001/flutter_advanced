import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';


class FrictionSimulationPage extends StatefulWidget {
  const FrictionSimulationPage({super.key});

  @override
  State<FrictionSimulationPage> createState() => _FrictionSimulationState();
}

class _FrictionSimulationState extends State<FrictionSimulationPage> with SingleTickerProviderStateMixin{
  late AnimationController blockAnimationController;

  @override
  void initState(){
    super.initState();
    blockAnimationController = AnimationController.unbounded(vsync: this);
  }

  void _nudgeBlock(){
    FrictionSimulation sim = FrictionSimulation(0, 0, 0);
    blockAnimationController.animateWith(sim);
  }
  void _resetBlock(){
    FrictionSimulation sim = FrictionSimulation(0, 0, 0);
    blockAnimationController.animateWith(sim);
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
              child: Column (
            children: const [
              Slider(min: 0.0, max: 10, onChanged: null, value: 1.0,),
              Slider(min: 0.0, max: 10, onChanged: null, value: 1.0,),
              Slider(min: 0.0, max: 10, onChanged: null, value: 1.0,),

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
                left: size.height / 4 - 125 + blockAnimationController.value,
                child: Container(
                  color: Colors.red,
                ),
              );
            },
          ),
          Positioned(
              bottom: size.height / 7,
              child: Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(onPressed: _nudgeBlock, child: const Text('NUDGE')),
                      const SizedBox(width: 20),
                      ElevatedButton(onPressed: _resetBlock, child: const Text('RESET')),
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
