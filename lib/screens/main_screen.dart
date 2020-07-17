import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:listiify/components/oval_button.dart';
import 'package:listiify/constants.dart';
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: SafeArea(
          child: Column(children: <Widget>[
        Stack(children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: 180,
              width: double.infinity,
              color: Colors.blueAccent,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 160,
            child: Text(
              'Hey Anas Mohammed',
              style: kGreetingTextStyle,
            ),
          ),
          Positioned(
              top: 135,
              left: 10,
              child: Text(
                'These are your lists',
                style: kInfoTextStyle,
              )),
        ]),
        Expanded(
          child: GridView.count(
              crossAxisCount: 2,
              children: List<Widget>.generate(12, (index) {
                return ListCard(
                  color: Colors.blue,
                );
              })),
        )
      ])),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 6.0,
        icon: const Icon(Icons.add),
        label: const Text('Add a list'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ListCard extends StatelessWidget {
  ListCard({this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        onLongPress: () {},
        child: Card(
          elevation: 10,
          child: Stack(children: <Widget>[
            Positioned(
              left: 16,
              top: 5,
              child: Icon(Icons.fiber_manual_record, color: color, size: 25),
            ),
            Positioned(
              left: 11,
              child: Icon(
                Icons.fiber_manual_record,
                color: color.withOpacity(0.3),
                size: 35,
              ),
            ),
            Positioned(
              bottom: 60,
              left: 20,
              child: Text(
                'Personal',
                style: TextStyle(
                    fontFamily: 'Red Rose', fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                '6 tasks',
                style: TextStyle(color: Colors.black.withOpacity(0.4)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
