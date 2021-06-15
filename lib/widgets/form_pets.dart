import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:pet_register/models/mascota_model.dart';
import 'package:pet_register/models/persona_model.dart';

import 'package:pet_register/providers/db_providers.dart';

import 'package:pet_register/widgets/custom_radio.dart';
import 'package:pet_register/widgets/custom_text_form_field.dart';

import 'package:pet_register/theme/normal_theme.dart';

class FormPets extends StatefulWidget {
  final PageController pageController;
  FormPets({Key key, @required this.pageController}) : super(key: key);

  @override
  _FormPetsState createState() => _FormPetsState();
}

class _FormPetsState extends State<FormPets> {
  final _formKey = GlobalKey<FormState>();

  String _nombre = '';
  String _apellidos = '';
  String _sexo = 'hombre';
  int _edad = 0;
  int _tipoMascota = 1;
  String _nombreMascota = '';
  int _edadMascota = 0;

  int _varTemp = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
          child: Form(key: _formKey, child: _drawFormBody()),
        ),
      ],
    );
  }

  Widget _drawFormBody() {
    return Column(
      children: [
        Container(
          height: 70,
          margin: EdgeInsets.only(bottom: 15),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadio(
                  onTap: changeStateHombre,
                  icon: FontAwesome.male,
                  label: 'Hombre',
                  selected: this._sexo == 'hombre'),
              CustomRadio(
                  onTap: changeStateMujer,
                  icon: FontAwesome.female,
                  label: 'Mujer',
                  selected: this._sexo == 'mujer'),
            ],
          ),
        ),
        CustomTextFormField(
            label: 'Nombre',
            keyboardType: TextInputType.text,
            onChanged: changeStateNombre),
        SizedBox(height: 15),
        CustomTextFormField(
            label: 'Apellido',
            keyboardType: TextInputType.text,
            onChanged: changeStateApellido),
        SizedBox(height: 15),
        CustomTextFormField(
            label: 'Edad',
            keyboardType: TextInputType.number,
            onChanged: changeStateEdad),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(12.5),
              child: Text('Tengo: ', style: TextStyle(fontSize: 16)),
            ),
            CustomRadio(
                onTap: changeStatePerro,
                isRow: true,
                icon: FontAwesome5Solid.dog,
                label: 'Perro',
                selected: this._tipoMascota == 1),
            CustomRadio(
                onTap: changeStateGato,
                isRow: true,
                icon: FontAwesome5Solid.cat,
                label: 'Gato',
                selected: this._tipoMascota == 2),
          ],
        ),
        SizedBox(height: 15),
        CustomTextFormField(
            label: 'Nombre de mi mascota',
            keyboardType: TextInputType.text,
            onChanged: changeStateNombreMascota),
        SizedBox(height: 15),
        CustomTextFormField(
            label: 'Edad de mi mascota',
            keyboardType: TextInputType.number,
            onChanged: changeStateEdadMascota),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: _registrar,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                NormalTheme.getColor('green_0')),
            foregroundColor:
                MaterialStateProperty.all<Color>(NormalTheme.getColor('white')),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
          ),
          child: Text(
            'Registrar',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  void _registrar() async {
    if (this._formKey.currentState.validate()) {
      Map<int, String> parseMascotas = {1: 'perro', 2: 'gato'};
      PersonaModel persona = new PersonaModel(
          nombre: this._nombre,
          apellido: this._apellidos,
          sexo: this._sexo,
          edad: this._edad);
      MascotaModel mascota = new MascotaModel(
          tipo: parseMascotas[this._tipoMascota],
          nombreMascota: this._nombreMascota,
          edadMascota: this._edadMascota);
      try {
        int id = await DBProvider.db.nuevaMascota(
          persona: persona,
          mascota: mascota,
        );
        if (id == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('La mascota ya ha sido registrada')));
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mascota registrada con éxito. (id: $id)')));
        widget.pageController.animateToPage(1,
            duration: Duration(seconds: 1), curve: Curves.easeInOut);
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Hubo un error...')));
      }
    }
  }

  void onRadioChangedValue(value) {
    setState(() {
      this._tipoMascota = value;
    });
  }

  changeStateNombre(valor) {
    setState(() {
      this._nombre = valor;
    });
  }

  changeStateApellido(valor) {
    setState(() {
      this._apellidos = valor;
    });
  }

  changeStateEdad(valor) {
    setState(() {
      this._edad = int.parse(valor);
    });
  }

  changeStateNombreMascota(valor) {
    setState(() {
      this._nombreMascota = valor;
    });
  }

  changeStateEdadMascota(valor) {
    setState(() {
      this._edadMascota = int.parse(valor);
    });
  }

  changeStateHombre() {
    setState(() {
      this._sexo = 'hombre';
    });
  }

  changeStateMujer() {
    setState(() {
      this._sexo = 'mujer';
    });
  }

  changeStatePerro() {
    setState(() {
      this._tipoMascota = 1;
    });
  }

  changeStateGato() {
    setState(() {
      this._tipoMascota = 2;
    });
  }
}
