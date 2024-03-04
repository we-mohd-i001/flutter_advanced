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

  void solve(Offset target) {
    child.angle =(target -loc).direction;
  }






















  // double _lawOfCosines(double a, double b, double c) {
  //   return acos((pow(a, 2) + pow(b, 2) - pow(c, 2)) / (2 * a * b));
  // }

  // List<Offset> _circleIntersection(
  //     Offset center1, double radius1, Offset center2, double radius2) {
  //   Offset distanceOffset = (center2 - center1);
  //
  //   // if the distance between their centers are greater than the sum of
  //   // their radii, they must not intersect.
  //   if (distanceOffset.distance > radius1 + radius2) {
  //     return [];
  //   }
}
