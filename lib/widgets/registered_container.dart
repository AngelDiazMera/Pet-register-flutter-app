import 'package:flutter/material.dart';

class RegisteredContainer extends StatelessWidget {
  final Map<String, dynamic> registro;

  const RegisteredContainer({Key key, @required this.registro})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget personaImg = Image(
      image: AssetImage(
          // Decide si usar imagen de hombre o de mujer
          this.registro['sexo'] == 'hombre'
              ? 'assets/user.png'
              : 'assets/woman.png'),
      fit: BoxFit.fill,
    );

    Widget descripcion = Text(
      '${this.registro['nombre']} ${this.registro['apellido']}\n' +
          // Control de 'año' y 'años' para [erspma]
          '${this.registro['edad']} ${(this.registro['edad'] > 1) ? 'años' : 'año'} de edad.\n\n' +
          // Decide si poner 'Dueño' o 'Dueña'
          '${this.registro['sexo'] == 'hombre' ? 'Dueño' : 'Dueña'} de un ${this.registro['tipoMascota']}\n' + // tipo es string ('perro', 'gato')
          'de ${this.registro['edadMascota']} ' +
          // Control de 'año' y 'años' para mascota
          '${(this.registro['edadMascota'] > 1) ? 'años' : 'año'} llamado:\n',
      style: TextStyle(fontSize: 14),
    );

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 35),
          constraints: BoxConstraints(maxWidth: 260, maxHeight: 144),
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 15, right: 15, bottom: 15, left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                personaImg,
                descripcion,
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25),
          constraints: BoxConstraints(maxWidth: 160, maxHeight: 110),
          width: 145,
          height: 95,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  image: AssetImage(this.registro['tipoMascota'] == 'perro'
                      ? 'assets/dog.png'
                      : 'assets/cat.png'),
                  height: 65,
                ),
                Text(this.registro['nombreMascota'],
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
