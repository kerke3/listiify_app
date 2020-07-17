import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:listiify/components/rounded_button.dart';
import 'package:listiify/components/rounded_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:listiify/constants.dart';
import 'package:listiify/screens/lists_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
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
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      RoundedTextField(
                        inputType: TextInputType.emailAddress,
                        hint: 'Enter your email',
                        nullError: 'Please enter your email',
                        icon: Icon(Icons.email, color: Colors.blueAccent),
                        obscure: false,
                        onChanged: (value) async {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      RoundedTextField(
                        inputType: TextInputType.text,
                        hint: 'Enter your password',
                        nullError: 'Please enter your password',
                        icon: Icon(Icons.vpn_key, color: Colors.blueAccent),
                        obscure: true,
                        onChanged: (value) async {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: 15.0,
              ),
              Builder(builder: (BuildContext context) {
                return RoundedButton(
                    title: 'Log In',
                    colour: Colors.blueAccent,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      if (_formKey.currentState.validate()) {
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (user != null) {
                            // navigate to new page
                            Navigator.pushNamed(context, ListsScreen.id);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          setState(() {
                            showSpinner = false;
                          });

                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e.message),
                            backgroundColor: Colors.red,
                          ));
                        }
                      } else {
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
