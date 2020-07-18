import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:listiify/components/rounded_button.dart';
import 'package:listiify/components/rounded_text_field.dart';
import 'package:listiify/constants.dart';
import 'package:listiify/screens/lists_screen.dart';
import 'package:listiify/services/authentication_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:listiify/models/task_data.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationService _authenticationService = AuthenticationService();
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
                  height: 180,
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
                        final result =
                            await _authenticationService.signUpWithEmail(
                                email: email,
                                password: password,
                                displayName: displayName);

                        setState(() {
                          showSpinner = false;
                        });

                        if (result is bool) {
                          if (result) {
                            Provider.of<TaskData>(context).setUserEmail(email);
                            Provider.of<TaskData>(context).setUserDisplay();
                            Provider.of<TaskData>(context).getTaskList();
                            Navigator.pushNamed(context, ListsScreen.id);
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Please try again later'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(result),
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
