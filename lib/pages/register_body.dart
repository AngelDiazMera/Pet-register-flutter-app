import 'package:flutter/material.dart';
import 'package:pet_register/widgets/blur_shape.dart';
import 'package:pet_register/widgets/form_pets.dart';
import 'package:pet_register/widgets/pets_image.dart';

class RegisterBody extends StatelessWidget {
  PageController pageController;

  RegisterBody({Key key, @required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = 525;
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: <Widget>[
          BlurShape(
            top: MediaQuery.of(context).size.height - height,
            height: height,
            radius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: FormPets(pageController: pageController),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - (75 + height),
            child: PetsImage(size: 150),
          ),
        ],
      ),
    );
  }
}
