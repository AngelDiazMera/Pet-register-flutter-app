import 'package:flutter/material.dart';

import 'package:pet_register/providers/db_providers.dart';

import 'package:pet_register/theme/normal_theme.dart';

import 'package:pet_register/widgets/blur_shape.dart';
import 'package:pet_register/widgets/pets_image.dart';
import 'package:pet_register/widgets/registered_container.dart';

class PetsPageBody extends StatefulWidget {
  PetsPageBody({Key key}) : super(key: key);

  @override
  _PetsPageBodyState createState() => _PetsPageBodyState();
}

class _PetsPageBodyState extends State<PetsPageBody> {
  List<Map<String, dynamic>> registros;

  void _getPersonas() async {
    if (registros != null) return;
    List val = await DBProvider.db.getAllMascotas();
    setState(() {
      registros = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: BlurShape(
        radius: BorderRadius.zero,
        height: double.infinity,
        isGradient: true,
        child: SafeArea(
          child: Column(
            // alignment: Alignment.center,
            // fit: StackFit.loose,
            children: [
              SizedBox(height: 10),
              PetsImage(size: 75),
              SizedBox(height: 10),
              Container(
                height: 3,
                width: double.infinity,
                decoration:
                    BoxDecoration(color: NormalTheme.getColor('green_0')),
              ),
              SizedBox(height: 10),
              Text(
                'Bienvenidos',
                style: TextStyle(fontSize: 34),
              ),
              SizedBox(height: 10),
              _getContainers(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _getContainers(BuildContext context) {
    _getPersonas();
    if (registros == null)
      return ImageAndInfo(
        asset: 'assets/cat_loading.gif',
        label: 'Preparando mascotitas...',
      );

    List<StatelessWidget> contenedores = [];
    registros.forEach((registro) {
      contenedores.add(RegisteredContainer(registro: registro));
    });

    if (registros.length > 0)
      return Expanded(
        child: ListView.builder(
          itemCount: contenedores.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return contenedores[index];
          },
        ),
      );
    return ImageAndInfo(
      asset: 'assets/dog_question.gif',
      label: 'Parece que aún no\n hay registros.',
    );
  }
}

class ImageAndInfo extends StatelessWidget {
  final String label;
  final String asset;

  const ImageAndInfo({Key key, this.label, this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: (MediaQuery.of(context).size.height / 2) - 250),
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(this.asset),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(25),
                child: Text(
                  this.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
