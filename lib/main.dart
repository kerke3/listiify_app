import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listiify/screens/start_screen.dart';
import 'package:listiify/screens/login_screen.dart';
import 'package:listiify/screens/registration_screen.dart';
import 'package:listiify/screens/lists_screen.dart';

void main() {
  runApp(Listiify());
}

class Listiify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF005CB2),
    ));
    return MaterialApp(
      initialRoute: StartScreen.id,
      routes: {
        StartScreen.id: (context) => StartScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ListsScreen.id: (context) => ListsScreen(),
      },
    );
  }
}
