import 'dart:math';
import 'dart:ui';

import 'attachable.dart';

class Bone implements Attachable {
  late double len;

  // in radians
  late double angle;

  late Attachable parent;
  late Bone child;

  Bone(this.len, this.parent) {
    angle = Random().nextDouble() * pi * 2;
  }

  Offset getLoc() {
    return parent.getAttachPoint();
  }

  @override
  Offset getAttachPoint() {
    return getLoc() + Offset.fromDirection(angle, len);
  }
}