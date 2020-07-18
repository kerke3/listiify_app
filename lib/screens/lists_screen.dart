import 'package:listiify/widgets/tasks_stream.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:listiify/components/rounded_button.dart';
import 'package:listiify/constants.dart';
import 'package:listiify/models/task_data.dart';

class ListsScreen extends StatefulWidget {
  static const String id = 'lists_screen';

  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    return Scaffold(
        backgroundColor: kScaffoldBackground,
        body: SafeArea(
            child: Column(
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
//              Container(
//                padding:
//                    EdgeInsets.only(top: 20, left: 10, right: 15, bottom: 15),
//                constraints: BoxConstraints.tight(Size(100, 100)),
//                child: RawMaterialButton(
//                  elevation: 5.0,
//                  onPressed: () {
//                    Navigator.pushNamed(context, MainScreen.id);
//                  },
//                  fillColor: Colors.white,
//                  shape: CircleBorder(),
//                  child: Icon(
//                    Icons.list,
//                    size: 35,
//                    color: Colors.blueAccent,
//                  ),
//                ),
//              ),
              Container(
                alignment: Alignment.center,
                height: 160,
                child: Text('Hey ${Provider.of<TaskData>(context).displayName}',
                    style: kGreetingTextStyle),
              ),
              Positioned(
                  top: 135,
                  left: 30,
                  child: Text(
                    '${Provider.of<TaskData>(context).taskCount} Tasks',
                    style: kInfoTextStyle,
                  ))
            ]),
            TasksStream()
          ],
        )),
        floatingActionButton: FloatingActionButton.extended(
            elevation: 6.0,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: const Text('Add a task'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        elevation: 5.0,
                        backgroundColor: Colors.white,
                        content: TextField(
                          textAlign: TextAlign.center,
                          autofocus: true,
                          onChanged: (value) {
                            newTaskTitle = value;
                          },
                        ),
                        actions: [
                          RoundedButton(
                              title: 'Add',
                              colour: Colors.blueAccent,
                              onPressed: () {
                                Provider.of<TaskData>(context)
                                    .addTask(newTaskTitle);
                                Navigator.pop(context);
                              }),
                        ]);
                  });
            }));
  }
}
