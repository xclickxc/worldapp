import 'package:flutter/material.dart';
import 'package:worldapp/view/profile_view/signup_screen.dart';
import 'package:worldapp/view/profile_view/login_screen.dart';
import 'package:worldapp/home.dart';

class AppStart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen()
      },
    );
  }
}