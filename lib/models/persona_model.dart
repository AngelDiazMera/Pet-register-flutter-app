import 'package:flutter/material.dart';

class PersonaModel {
  // Atributos
  int id;
  String nombre;
  String apellido;
  String sexo;
  int edad;

  // Constructor
  PersonaModel({
    this.id,
    @required this.nombre,
    @required this.apellido,
    @required this.sexo,
    @required this.edad,
  });

  factory PersonaModel.fromJson(Map<String, dynamic> json) => PersonaModel(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        sexo: json['sexo'],
        edad: json['edad'],
      );

  // datos a Json
  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'apellido': apellido,
        'sexo': sexo,
        'edad': edad,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  // Getters y setters
  /*num get id => _id;

  set id(int id) {
    _id = id;
  }

  String get nombre => _nombre;

  set nombre(String nombre) {
    _nombre = nombre;
  }

  String get apellido => _apellido;

  set apellido(String apellido) {
    _apellido = apellido;
  }

  String get sexo => _sexo;

  set sexo(String sexo) {
    _sexo = sexo;
  }

  int get edad => _edad;

  set edad(int edad) {
    _edad = edad;
  }

  String get tipo => _tipo;

  set tipo(String tipo) {
    _tipo = tipo;
  }

  String get nombreMascota => _nombreMascota;

  set nombreMascota(String nombreMascota) {
    _nombreMascota = nombreMascota;
  }

  int get edadMascota => _edadMascota;

  set edadMascota(int edadMascota) {
    _edadMascota = edadMascota;
  }*/
}
