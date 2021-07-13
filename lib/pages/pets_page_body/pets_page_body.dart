import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pet_register/pages/pets_page_body/widgets/registered_container.dart';
import 'package:pet_register/pages/pets_page_body/widgets/image_info.dart';

import 'package:pet_register/theme/normal_theme.dart';

import 'package:pet_register/widgets/blur_shape.dart';
import 'package:pet_register/widgets/pets_image.dart';

// Class
class PetsPageBody extends StatefulWidget {
  PetsPageBody({Key key}) : super(key: key);

  @override
  _PetsPageBodyState createState() => _PetsPageBodyState();
}

// State
class _PetsPageBodyState extends State<PetsPageBody> {
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
              // Body of the page
              _getContainers(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _getContainers(BuildContext context) {
    // Use a StreamBuilder because we want to collect an
    // asynchronous set of data from Firestore
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('people') // People collection
            .snapshots(), // Snapshots from firestore
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // If something goes wrong
          if (snapshot.hasError)
            return ImageAndInfo(
              asset: 'assets/dog_error.gif',
              label: 'Parece que hubo un error',
            );
          // If loading
          if (!snapshot.hasData)
            return ImageAndInfo(
              asset: 'assets/cat_loading.gif',
              label: 'Preparando mascotitas...',
            );
          // If the collection is empty
          if (snapshot.data.docs.length == 0)
            return ImageAndInfo(
              asset: 'assets/dog_question.gif',
              label: 'Parece que aún no\n hay registros',
            );

          // List of containers foreach register
          List<StatelessWidget> containers = [];
          snapshot.data.docs.forEach((person) {
            containers.add(RegisteredContainer(register: person.data()));
          });
          // Add the containers to a listview
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return containers[index];
              },
            ),
          );
        });
  }
}
