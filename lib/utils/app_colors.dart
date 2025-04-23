import 'package:flutter/material.dart';

class AppColors {
  static final Map<String, List<Color>> namedColors = {
    'grey': grey,
    'Orange': orange,
    'Red': red,
    'Pink': pink,
    'Blue': blue,
    'Yellow': yellow,
    'Teal': teal,
  };
  static List<Color> grey = [
    Colors.grey.shade600,
    Colors.grey.shade100,
    Colors.grey.shade50,
  ];
  static List<Color> orange = [
    Colors.orange.shade800,
    Colors.orangeAccent.shade100,
    Colors.orange.shade50,
  ];
  static List<Color> red = [
    Colors.red.shade800,
    Colors.redAccent.shade100,
    Colors.red.shade50,
  ];
  static List<Color> pink = [
    Colors.pink.shade800,
    Colors.pinkAccent.shade100,
    Colors.pink.shade50,
  ];
  static List<Color> blue = [
    Colors.blue.shade800,
    Colors.blue.shade100,
    Colors.blue.shade50
  ];
  static List<Color> yellow = [
    Colors.yellow.shade800,
    Colors.yellowAccent.shade100,
    Colors.yellow.shade50,
  ];
  static List<Color> teal = [
    Colors.teal.shade800,
    Colors.tealAccent.shade100,
    Colors.teal.shade50,
  ];
}
