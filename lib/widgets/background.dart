import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pet_register/theme/normal_theme.dart';

class Background extends StatelessWidget {
  var boxDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomCenter,
      stops: [0.2, 0.8],
      colors: [
        NormalTheme.getColor('green_4'),
        NormalTheme.getColor('green_3'),
      ],
    ),
  );
  Background({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Green gradient
        Container(
          decoration: boxDecoration,
        ),
        // ColorBoxes
        Positioned(
          top: -100,
          left: 0,
          child: _ColorBox(
            color: NormalTheme.getColor('green_1'),
            angle: -pi / 6.0,
            size: 200,
            radius: 50,
          ),
        ),
        Positioned(
          top: 225,
          right: -20,
          child: _ColorBox(
            color: NormalTheme.getColor('green_1'),
            angle: -pi / 3.0,
            size: 300,
            radius: 80,
          ),
        ),
        Positioned(
          top: 550,
          left: -20,
          child: _ColorBox(
            color: NormalTheme.getColor('green_0'),
            angle: -pi / 8.0,
            size: 150,
            radius: 50,
          ),
        ),
        Positioned(
          top: 20,
          right: -20,
          child: _ColorBox(
            color: NormalTheme.getColor('green_3'),
            angle: -pi / 8.0,
            size: 120,
            radius: 40,
          ),
        ),
      ],
    );
  }
}

class _ColorBox extends StatelessWidget {
  final Color color;
  final double angle;
  final double size;
  final double radius;

  const _ColorBox(
      {Key key,
      @required this.color,
      @required this.angle,
      @required this.size,
      @required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: this.angle,
      child: Container(
        width: this.size,
        height: this.size,
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(this.radius),
        ),
      ),
    );
  }
}
