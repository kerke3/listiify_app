import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:listiify/components/rounded_button.dart';
import 'package:listiify/constants.dart';
import 'package:listiify/models/task.dart';
import 'package:listiify/models/task_data.dart';
import 'package:listiify/models/user_data.dart';
import 'package:listiify/widgets/task_list.dart';

class ListsScreen extends StatefulWidget {
  static const String id = 'lists_screen';

  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  @override
  Widget build(BuildContext context) {
//    List<Task> taskList = Provider.of<List<Task>>(context);
//    Provider.of<TaskData>(context, listen: false).setTaskList(taskList);
    final _formKey = GlobalKey<FormState>();
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
                child: Text('Hey ${Provider.of<UserData>(context).displayName}',
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
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: TasksList(),
              ),
            )
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
                    var width = MediaQuery.of(context).size.width;
                    return AlertDialog(
                        elevation: 5.0,
                        backgroundColor: Colors.white,
                        content: Container(
                          width: width,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              autofocus: true,
                              onChanged: (value) {
                                newTaskTitle = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a task name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        actions: [
                          Container(
                            width: width,
                            alignment: Alignment.center,
                            child: RoundedButton(
                                title: 'Add',
                                colour: Colors.blueAccent,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    final displayName =
                                        Provider.of<UserData>(context)
                                            .displayName;
                                    final email =
                                        Provider.of<UserData>(context).email;
                                    Provider.of<TaskData>(context).addTask(
                                        newTaskTitle, email, displayName);
                                    Navigator.pop(context);
                                  }
                                }),
                          ),
                        ]);
                  });
            }));
  }
}
