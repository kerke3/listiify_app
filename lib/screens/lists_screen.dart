import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:listiify/components/rounded_button.dart';
import 'package:listiify/constants.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
final _scaffoldKey = GlobalKey<ScaffoldState>();

class ListsScreen extends StatefulWidget {
  static const String id = 'lists_screen';

  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      } else {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext bc) {
              return Container(
                padding: EdgeInsets.all(20),
                color: Colors.red,
                child: Text(
                  'An error has occurred, Please Log in again.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            });
      }
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kScaffoldBackground,
        body: SafeArea(
            child: ListView(
          children: <Widget>[
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
                padding:
                    EdgeInsets.only(top: 20, left: 10, right: 15, bottom: 15),
                constraints: BoxConstraints.tight(Size(100, 100)),
                child: RawMaterialButton(
                  elevation: 5.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.list,
                    size: 35,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 160,
                child: Text('Personal', style: kGreetingTextStyle),
              ),
              Positioned(
                  top: 135,
                  left: 30,
                  child: Text(
                    '12 Tasks',
                    style: kInfoTextStyle,
                  ))
            ]),
            SizedBox(
              height: 8.0,
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
            elevation: 5.0,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        elevation: 5.0,
                        backgroundColor: Colors.white,
                        content: TextField(
                          autofocus: true,
                        ),
                        actions: [
                          RoundedButton(
                              title: 'Add',
                              colour: Colors.blueAccent,
                              onPressed: () {}),
                        ]);
                  });
            }));
  }
}

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Function longPressCallback;

  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.checkboxCallback,
      this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: MyCheckBox(),
          title: Text('Task 1'),
        ),
        Divider(
          thickness: 1,
          indent: 30,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}

class MyCheckBox extends StatefulWidget {
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: false,
      checkColor: Colors.lightGreen.shade400,
    );
  }
}
