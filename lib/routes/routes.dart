import 'package:flutter/material.dart';

import 'package:pet_register/pages/home_page.dart';

// This function returns the routes of the app
Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{'/home': (BuildContext context) => HomePage()};
}

// MaterialPageRoute getRouteDepartamento(settings) {
//   final DepartamentoArguments args = settings.arguments;

//   return MaterialPageRoute(
//       builder: (BuildContext context) => DepaPage(id: args.id));
// }
