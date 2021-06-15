import 'package:flutter/material.dart';

class NormalTheme {
  static Map<String, Color> _colors;
  static ThemeData _applicationTheme;
  static final NormalTheme theme = NormalTheme._();

  NormalTheme._();

  static Color _parseColor(String code) =>
      new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

  static Color getColor(String colorName) {
    if (_colors != null) return _colors[colorName];
    _colors = <String, Color>{
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

  static Map<String, Color> get color => _colors;

  static ThemeData get applicationTheme {
    if (_applicationTheme != null) return _applicationTheme;
    _applicationTheme = ThemeData(
      primarySwatch: Colors.blue,
      // text themes
      /*textTheme: TextTheme(
        bodyText1: TextStyle(color: getColor('white')),
        headline3: TextStyle(color: getColor('white')),
        headline6: TextStyle(color: getColor('yellow')),
        bodyText2: TextStyle(color: getColor('black')), // Text color on body
      ),
      primaryColor: getColor('black'), // appbar color
      accentColor: getColor('black'), // buttons and material elements
      scaffoldBackgroundColor: getColor('black'), // Background color*/
    );
    return _applicationTheme;
  }
}
