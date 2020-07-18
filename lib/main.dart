import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:listiify/models/task_data.dart';
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
    return ChangeNotifierProvider(
      builder: (context) => TaskData(),
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ListsScreen.id: (context) => ListsScreen(),
        },
      ),
    );
  }
}
