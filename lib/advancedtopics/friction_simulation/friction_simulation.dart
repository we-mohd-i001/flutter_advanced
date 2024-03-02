import 'package:flutter/material.dart';

class FrictionSimulation extends StatefulWidget {
  const FrictionSimulation({super.key});

  @override
  State<FrictionSimulation> createState() => _FrictionSimulationState();
}

class _FrictionSimulationState extends State<FrictionSimulation> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(title: const Text('Friction Simulation'),),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: size.height/3,
              child: Container(color: Colors.blue,),),
          Positioned(
              width: 50,
              height: 50,
              bottom: size.height/3,
              left: size.height/4 - 125,
              child: Container(color: Colors.red,))
        ],
      ),
    );
  }
}
