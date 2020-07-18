import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:listiify/screens/lists_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:listiify/services/authentication_service.dart';
import 'package:listiify/screens/registration_screen.dart';
import 'package:listiify/constants.dart';
import 'package:listiify/components/rounded_button.dart';
import 'package:listiify/components/rounded_text_field.dart';
import 'package:listiify/models/task_data.dart';
import 'package:listiify/models/user_data.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
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
                        inputType: TextInputType.emailAddress,
                        hint: 'Enter your email',
                        nullError: 'Please enter your email',
                        icon: Icon(Icons.email, color: Colors.blueAccent),
                        obscure: false,
                        onChanged: (value) {
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
                        final result = await _authenticationService
                            .loginWithEmail(email: email, password: password);
                        setState(() {
                          showSpinner = false;
                        });
                        if (result is bool) {
                          if (result) {
                            Provider.of<UserData>(context).setUser();
                            Provider.of<TaskData>(context).getTaskList(email);
                            Navigator.pushNamed(context, ListsScreen.id);
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'General login failure. Please try again later'),
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
              RoundedButton(
                title: 'Register',
                colour: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
