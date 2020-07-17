import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:listiify/components/rounded_button.dart';
import 'package:listiify/components/rounded_text_field.dart';
import 'package:listiify/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:listiify/screens/lists_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String displayName;
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
                      inputType: TextInputType.text,
                      hint: 'Enter your name',
                      nullError: 'Please enter your name',
                      icon: Icon(Icons.person, color: Colors.blueAccent),
                      obscure: false,
                      onChanged: (value) async {
                        setState(() {
                          displayName = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
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
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Builder(builder: (BuildContext context) {
                return RoundedButton(
                    title: 'Register',
                    colour: Colors.blueAccent,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      if (_formKey.currentState.validate()) {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            UserUpdateInfo updateUser = UserUpdateInfo();
                            updateUser.displayName = displayName;
                            final updatedUser =
                                await newUser.user.updateProfile(updateUser);
                            Navigator.pushNamed(context, ListsScreen.id);
                            // navigate to new page
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
              }),
            ],
          ),
        ),
      ),
    );
  }
}
