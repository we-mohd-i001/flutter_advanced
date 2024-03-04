import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Advanced Topics'),),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/liquid');
              }, child: const SizedBox(
                  width: 200,child: Center(child: Text('Glass of Liquid')))),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/mario');
              }, child: const SizedBox(width: 200,child: Center(child: Text('Mario Jump Animation')))),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/friction');
              }, child: const SizedBox(width: 200,child: Center(child: Text('Friction Simulation')))),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/kinematics');
              }, child: const SizedBox(width: 200,child: Center(child: Text('Inverse Kinematics')))),
            ],
          ),
        ),
      ),
    );
  }
}
