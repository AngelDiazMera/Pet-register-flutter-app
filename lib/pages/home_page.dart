import 'package:flutter/material.dart';

import 'package:pet_register/pages/pets_page_body/pets_page_body.dart';
import 'package:pet_register/pages/register_body/register_body.dart';

import 'package:pet_register/widgets/background.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Background(),
          //Home body
          PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: [
              RegisterBody(pageController: controller),
              PetsPageBody(),
            ],
          )
        ],
      ),
    );
  }
}
