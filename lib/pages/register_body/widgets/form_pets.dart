import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:pet_register/models/pet_model.dart';
import 'package:pet_register/models/person_model.dart';

import 'package:pet_register/widgets/custom_radio.dart';
import 'package:pet_register/widgets/custom_text_form_field.dart';

import 'package:pet_register/theme/normal_theme.dart';

class FormPets extends StatefulWidget {
  final PageController pageController; // Atributte to change the page
  FormPets({Key key, @required this.pageController}) : super(key: key);

  @override
  _FormPetsState createState() => _FormPetsState();
}

class _FormPetsState extends State<FormPets> {
  final _formKey = GlobalKey<FormState>();
  // State variables
  String _name = '';
  String _last = '';
  String _sex = 'hombre';
  int _age = 0;
  int _petType = 1;
  String _petName = '';
  int _petAge = 0;
  // Build method
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

  // Draws the body of the form
  Widget _drawFormBody() {
    return Column(
      children: [
        Container(
          height: 70,
          margin: EdgeInsets.only(bottom: 15),
          width: double.infinity,
          // Sex checkboxes
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadio(
                  onTap: changeStateMan,
                  icon: FontAwesome.male,
                  label: 'Hombre',
                  selected: this._sex == 'hombre'),
              CustomRadio(
                  onTap: changeStateWoman,
                  icon: FontAwesome.female,
                  label: 'Mujer',
                  selected: this._sex == 'mujer'),
            ],
          ),
        ),
        // Field Name
        CustomTextFormField(
            label: 'Nombre',
            keyboardType: TextInputType.text,
            onChanged: changeStateName),
        SizedBox(height: 15),
        //Field Last name
        CustomTextFormField(
            label: 'Apellido',
            keyboardType: TextInputType.text,
            onChanged: changeStateLast),
        SizedBox(height: 15),
        // Field age
        CustomTextFormField(
            label: 'Edad',
            keyboardType: TextInputType.number,
            onChanged: changeStateAge),
        SizedBox(height: 15),
        // Pet type checkboxes
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(12.5),
              child: Text('Tengo: ', style: TextStyle(fontSize: 16)),
            ),
            CustomRadio(
                onTap: changeStateDog,
                isRow: true,
                icon: FontAwesome5Solid.dog,
                label: 'Perro',
                selected: this._petType == 1),
            CustomRadio(
                onTap: changeStateCat,
                isRow: true,
                icon: FontAwesome5Solid.cat,
                label: 'Gato',
                selected: this._petType == 2),
          ],
        ),
        SizedBox(height: 15),
        // Pet name field
        CustomTextFormField(
            label: 'Nombre de mi mascota',
            keyboardType: TextInputType.text,
            onChanged: changeStatePetName),
        SizedBox(height: 15),
        // Pet age field
        CustomTextFormField(
            label: 'Edad de mi mascota',
            keyboardType: TextInputType.number,
            onChanged: changeStatePetAge),
        SizedBox(height: 15),
        // Register button
        ElevatedButton(
          onPressed: _registrer,
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

  void _registrer() async {
    if (this._formKey.currentState.validate()) {
      // Enum values for the Pets selection
      Map<int, String> parseMascotas = {1: 'perro', 2: 'gato'};
      // Collection of people on Firestore
      CollectionReference people =
          FirebaseFirestore.instance.collection('people');
      // New pet model instance
      PetModel pet = new PetModel(
          type: parseMascotas[this._petType],
          name: this._petName,
          age: this._petAge);
      // New person model instance
      PersonModel person = new PersonModel(
          name: this._name,
          last: this._last,
          sex: this._sex,
          age: this._age,
          pet: pet);
      // Try-catch block if adding goes wrong
      try {
        print(person);
        // Add person to Firestore collection
        people.add(person.toJson());
        // A message at the bottom of the page is shown
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Mascota registrada con éxito.'),
          duration: Duration(seconds: 2),
        ));
        // Animate to the second page
        widget.pageController.animateToPage(1,
            duration: Duration(seconds: 1), curve: Curves.easeInOut);
      } catch (error) {
        print(error);
        // A message at the bottom of the page is shown
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Hubo un error...')));
      }
    }
  }

  // Change state methods...
  void onRadioChangedValue(int value) {
    setState(() {
      this._petType = value;
    });
  }

  changeStateName(String value) {
    setState(() {
      this._name = value;
    });
  }

  changeStateLast(String value) {
    setState(() {
      this._last = value;
    });
  }

  changeStateAge(String value) {
    setState(() {
      this._age = int.parse(value);
    });
  }

  changeStatePetName(String value) {
    setState(() {
      this._petName = value;
    });
  }

  changeStatePetAge(String value) {
    setState(() {
      this._petAge = int.parse(value);
    });
  }

  changeStateMan() {
    setState(() {
      this._sex = 'hombre';
    });
  }

  changeStateWoman() {
    setState(() {
      this._sex = 'mujer';
    });
  }

  changeStateDog() {
    setState(() {
      this._petType = 1;
    });
  }

  changeStateCat() {
    setState(() {
      this._petType = 2;
    });
  }
}
