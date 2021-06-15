import 'package:flutter/material.dart';
import 'package:pet_register/theme/normal_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final Function onChanged;

  const CustomTextFormField(
      {Key key,
      @required this.label,
      @required this.keyboardType,
      @required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.all(12.5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none),
          // labelText: label,
          hintText: label,
          labelStyle: TextStyle(
            color: NormalTheme.getColor('black'),
          ),
          errorStyle: TextStyle(fontSize: 0, height: 0),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.red))
          // suffixIcon: Icon(Icons.access_alarm),
          ),
      cursorColor: NormalTheme.getColor('black'),
      onChanged: onChanged,
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'El campo "$label" no puede estar vacío';
        }
        return null;
      },
    );
  }
}
