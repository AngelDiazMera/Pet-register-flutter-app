import 'package:flutter/material.dart';

class NormalTheme {
  static Color _parseColor(String code) =>
      new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

  static Color getColor(String colorName) {
    Map _colors = <String, Color>{
      'black': _parseColor('#422E2F'),
      'gray': _parseColor('#A8AA92'),
      'yellow': _parseColor('#F9C16A'),
      'green_0': _parseColor('#264434'),
      'green_1': _parseColor('#3A8057'),
      'green_2': _parseColor('#5EC465'),
      'green_3': _parseColor('#9ED48F'),
      'green_4': _parseColor('#C3F8B4'),
      'white': _parseColor('#FFFFFF'),
    };
    return _colors[colorName];
  }
}
