import 'package:flutter/material.dart';

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
