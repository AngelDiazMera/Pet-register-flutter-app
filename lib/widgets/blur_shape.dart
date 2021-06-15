import 'dart:ui';

import 'package:flutter/material.dart';

class BlurShape extends StatelessWidget {
  final Widget child;
  final double top;
  final double height;
  final BorderRadius radius;
  final bool isGradient;

  final List<Color> colors; // if gradient
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final Color color; // if solid

  const BlurShape(
      {Key key,
      this.top = 0,
      @required this.height,
      this.radius,
      @required this.child,
      this.colors,
      this.color,
      this.gradientBegin = Alignment.topCenter,
      this.gradientEnd = Alignment.bottomCenter,
      this.isGradient = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: this.top,
      child: ClipRRect(
        borderRadius:
            this.radius == null ? BorderRadius.circular(15) : this.radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            height: this.height,
            width: MediaQuery.of(context).size.width,
            decoration: !this.isGradient
                ? BoxDecoration(
                    color: this.color == null
                        ? Color.fromRGBO(255, 255, 255, 0.6)
                        : this.color,
                    borderRadius: this.radius == null
                        ? BorderRadius.circular(15)
                        : this.radius,
                  )
                : BoxDecoration(
                    gradient: LinearGradient(
                        colors: this.colors == null
                            ? [
                                Color.fromRGBO(255, 255, 255, 0.6),
                                Color.fromRGBO(255, 255, 255, 0.0),
                              ]
                            : this.colors,
                        begin: this.gradientBegin,
                        end: this.gradientEnd,
                        stops: [0, 0.7]),
                    borderRadius: this.radius == null
                        ? BorderRadius.circular(15)
                        : this.radius,
                  ),
            child: child,
          ),
        ),
      ),
    );
  }
}
