import 'package:flutter/material.dart';
import 'package:flutter_advanced/advancedtopics/custompaint/custom_paint_1.dart';
import 'package:flutter_advanced/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: {
        '/' : (context) => HomeScreen(),
        '/liquid': (context) => CustomPaint1(),
      },
    );
  }
}

