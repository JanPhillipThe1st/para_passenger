import 'package:flutter/material.dart';

const defaultColor = Color.fromARGB(255, 0, 183, 255);
const textColor = Color.fromARGB(255, 12, 35, 49);
const borderColor = Color.fromARGB(255, 179, 226, 255);

class buttonColor extends MaterialStateColor {
  const buttonColor() : super(_defaultColor);

  static const int _defaultColor = 0xcafefeed;
  static const int _pressedColor = 0xdeadbeef;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Color.fromARGB(221, 127, 193, 255);
    }
    if (states.contains(MaterialState.hovered)) {
      return Color.fromARGB(221, 255, 127, 127);
    }
    return Color.fromARGB(201, 255, 255, 255);
  }
}
