import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:random_color/random_color.dart';
import 'package:listiify/components/oval_button.dart';
import 'package:listiify/constants.dart';
import 'package:listiify/widgets/list_card.dart';

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
              children: List<Widget>.generate(8, (index) {
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
