import 'package:flutter/material.dart';

const kScaffoldBackground = Colors.white;

const kLogoTextStyle = TextStyle(
  color: Colors.blueAccent,
  fontSize: 70,
  fontWeight: FontWeight.w900,
  fontFamily: 'Square Sans Serif',
);

//const kMessageTextFieldDecoration = InputDecoration(
//  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//  hintText: 'Type your message here...',
//  border: InputBorder.none,
//);
//
//const kMessageContainerDecoration = BoxDecoration(
//  border: Border(
//    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//  ),
//);
//
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
