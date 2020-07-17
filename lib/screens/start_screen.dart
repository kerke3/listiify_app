import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:listiify/constants.dart';
import 'package:listiify/components/rounded_button.dart';
import 'package:listiify/screens/login_screen.dart';
import 'package:listiify/screens/registration_screen.dart';

class StartScreen extends StatefulWidget {
  static const String id = 'start_screen';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            Center(
              child: Text(
                'Listiify',
                style: kLogoTextStyle,
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
