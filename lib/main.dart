import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_register/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Statusbar style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: 'Pet Register',
      debugShowCheckedModeBanner: false, // Debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home', // Initial route
      routes: getApplicationRoutes(), // Page's routes
    );
  }
}