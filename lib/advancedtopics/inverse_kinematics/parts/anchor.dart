import 'dart:math';
import 'dart:ui';

import 'attachable.dart';
import 'bone.dart';

class Anchor extends Attachable {
  late Offset loc;
  late Bone child;

  Anchor({required this.loc});

  @override
  Offset getAttachPoint() {
    return loc;
  }

  double _lawOfCosines(double a, double b, double c) {
    return acos((pow(a, 2) + pow(b, 2) - pow(c, 2)) / (2 * a * b));
  }

  List<Offset> _circleIntersections(
      Offset center1, double radius1, Offset center2, double radius2) {
    Offset centerOffset = (center2 - center1);
    if (centerOffset.distance > radius1 + radius2) {
      return [];
    }
    double angle = _lawOfCosines(radius2, centerOffset.distance, radius1);
    Offset intersectionPoint1 =
        center1 + Offset.fromDirection(centerOffset.direction + angle, radius1);

    Offset intersectionPoint2 =
        center1 + Offset.fromDirection(centerOffset.direction - angle, radius1);
    return [intersectionPoint1, intersectionPoint2];
  }

  void solve(Offset target) {
    Bone bone1 = child;
    Bone bone2 = bone1.child;

    Offset targetOffset = (target - loc);

    if (targetOffset.distance > bone1.len + bone2.len) {
      bone1.angle = (target - loc).direction;
      bone2.angle = (target - loc).direction;
    } else {
      List<Offset> interSectionPoints =
      _circleIntersections(loc, bone1.len, target, bone2.len);
      bone1.angle = (interSectionPoints[1] - loc).direction;
      bone2.angle = (target - interSectionPoints[1]).direction;
    }


  }
}
