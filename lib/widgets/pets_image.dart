import 'package:flutter/material.dart';
import 'package:pet_register/theme/normal_theme.dart';

class PetsImage extends StatelessWidget {
  final double size;

  const PetsImage({Key key, @required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icono_perro_gato.png'),
        ),
        color: NormalTheme.getColor('black'),
        borderRadius: BorderRadius.all(
          Radius.circular(this.size / 2),
        ),
      ),
    );
  }
}
