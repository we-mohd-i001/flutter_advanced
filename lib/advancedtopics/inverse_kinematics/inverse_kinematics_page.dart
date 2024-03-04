import 'package:flutter/material.dart';
import 'package:flutter_advanced/advancedtopics/inverse_kinematics/parts/anchor.dart';
import 'package:flutter_advanced/advancedtopics/inverse_kinematics/parts/bone.dart';
import 'package:flutter_advanced/advancedtopics/inverse_kinematics/widgets/arm_widget.dart';

class InverseKinematicsPage extends StatefulWidget {
  const InverseKinematicsPage({super.key});

  @override
  State<InverseKinematicsPage> createState() => _InverseKinematicsPageState();
}

class _InverseKinematicsPageState extends State<InverseKinematicsPage>
    with SingleTickerProviderStateMixin {
  late Anchor arm;

  @override
  void initState() {
    super.initState();
    _initializeArm();
  }

  _initializeArm() {
    arm = Anchor(loc: const Offset(0, 0));
    Bone b = Bone(70, arm);
    arm.child = b;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Size size = MediaQuery.of(context).size;
    arm.loc = Offset(size.width / 2, 3 / 4 * size.height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (DragStartDetails deets){
          setState(() {
            arm.solve(deets.globalPosition);
          });
        },
        onPanUpdate: (DragUpdateDetails deets) {
          setState(() {
            arm.solve(deets.globalPosition);
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
                child: ArmWidget(
              anchor: arm,
            ))
          ],
        ),
      ),
    );
  }
}
