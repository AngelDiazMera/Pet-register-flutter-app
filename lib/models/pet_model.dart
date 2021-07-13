import 'package:flutter/material.dart';

class PetModel {
  // Atributes
  String type;
  String name;
  int age;

  // Constructor
  PetModel({
    @required this.type,
    @required this.name,
    @required this.age,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        type: json['type'],
        name: json['name'],
        age: json['age'],
      );

  // data to map
  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'age': age,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
