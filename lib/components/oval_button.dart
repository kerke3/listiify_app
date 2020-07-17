import 'package:flutter/material.dart';

class OvalButton extends StatelessWidget {
  OvalButton({this.colour, this.onPressed, @required this.icon});

  final Color colour;
  final Function onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: GestureDetector(
          onTap: onPressed,
          child: ClipOval(
            child: Container(
              color: colour,
              height: 50,
              width: 50,
              child: Center(child: icon),
            ),
          ),
        ));
  }
}
