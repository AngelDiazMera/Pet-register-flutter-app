import 'package:flutter/material.dart';
import 'package:pet_register/models/pet_model.dart';

class PersonModel {
  // Atributes
  String name;
  String last;
  String sex;
  int age;
  PetModel pet;

  // Constructor
  PersonModel({
    @required this.name,
    @required this.last,
    @required this.sex,
    @required this.age,
    @required this.pet,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        name: json['name'],
        last: json['last'],
        sex: json['sex'],
        age: json['age'],
        pet: json['pet'],
      );

  // data to map
  Map<String, dynamic> toJson() => {
        'name': name,
        'last': last,
        'sex': sex,
        'age': age,
        'pet': pet.toJson(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
