import 'package:flutter/material.dart';
import 'package:flutter_advanced/advancedtopics/custompaint/custom_paint_1.dart';
import 'package:flutter_advanced/advancedtopics/friction_simulation/friction_simulation.dart';
import 'package:flutter_advanced/advancedtopics/inverse_kinematics/inverse_kinematics_page.dart';
import 'package:flutter_advanced/advancedtopics/mario_animation/mario_jump_animation.dart';
import 'package:flutter_advanced/advancedtopics/ui_pattern/swippable_ui_page.dart';
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
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/' : (context) => const HomeScreen(),
        '/liquid': (context) => const CustomPaint1(),
        '/mario' : (context) => const MarioJumpAnimation(),
        '/friction' : (context) => const FrictionSimulationPage(),
        '/kinematics' : (context) => const InverseKinematicsPage(),
        '/swippable' : (context) =>  const SwippablePageProvider(),
      },
    );
  }
}

