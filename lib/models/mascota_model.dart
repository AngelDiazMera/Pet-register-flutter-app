import 'package:flutter/material.dart';

class MascotaModel {
  // Atributos
  int id;
  String tipo;
  String nombreMascota;
  int edadMascota;
  int idDuenio;

  // Constructor
  MascotaModel({
    this.id,
    @required this.tipo,
    @required this.nombreMascota,
    @required this.edadMascota,
    this.idDuenio,
  });

  factory MascotaModel.fromJson(Map<String, dynamic> json) => MascotaModel(
        id: json['id'],
        tipo: json['tipo'],
        nombreMascota: json['nombreMascota'],
        edadMascota: json['edadMascota'],
        idDuenio: json['idDuenio'],
      );

  // datos a Json
  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo': tipo,
        'nombreMascota': nombreMascota,
        'edadMascota': edadMascota,
        'idDuenio': idDuenio,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
