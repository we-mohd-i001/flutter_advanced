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
              }, child: Container(
                  width: 200,child: Center(child: const Text('Glass of Liquid')))),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/mario');
              }, child: Container(width: 200,child: Center(child: const Text('Mario Jump Animation')))),
            ],
          ),
        ),
      ),
    );
  }
}
