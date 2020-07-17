import 'package:flutter/material.dart';
import 'package:listiify/constants.dart';

class RoundedTextField extends StatelessWidget {
  RoundedTextField(
      {this.inputType,
      @required this.hint,
      @required this.icon,
      @required this.onChanged,
      @required this.obscure,
      @required this.nullError});

  final TextInputType inputType;
  final String hint;
  final Icon icon;
  final bool obscure;
  final Function onChanged;
  final String nullError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return nullError;
          }
          return null;
        },
        keyboardType: inputType,
        obscureText: obscure,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        decoration:
            kTextFieldDecoration.copyWith(hintText: hint, prefixIcon: icon),
      ),
    );
  }
}
