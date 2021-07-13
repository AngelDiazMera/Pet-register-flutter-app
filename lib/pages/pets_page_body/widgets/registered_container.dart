import 'package:flutter/material.dart';

class RegisteredContainer extends StatelessWidget {
  final Map<String, dynamic> register;

  const RegisteredContainer({Key key, @required this.register})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget personImg = Image(
      image: AssetImage(
          // Decide si usar imagen de hombre o de mujer
          this.register['sex'] == 'hombre'
              ? 'assets/user.png'
              : 'assets/woman.png'),
      fit: BoxFit.fill,
    );

    Widget description = Text(
      '${this.register['name']} ${this.register['last']}\n' +
          '${this.register['age']} ${(this.register['age'] > 1) ? 'años' : 'año'} de edad.\n\n' +
          '${this.register['sex'] == 'hombre' ? 'Dueño' : 'Dueña'} de un ${this.register['pet']['type']}\n' +
          'de ${this.register['pet']['age']} ' +
          '${(this.register['pet']['age'] > 1) ? 'años' : 'año'} llamado:\n',
      style: TextStyle(fontSize: 14),
    );

    return Column(
      children: [
        // Person container
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
                personImg,
                description,
              ],
            ),
          ),
        ),
        // Container of the pet
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
                  image: AssetImage(this.register['pet']['type'] == 'perro'
                      ? 'assets/dog.png'
                      : 'assets/cat.png'),
                  height: 65,
                ),
                Text(this.register['pet']['name'],
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
