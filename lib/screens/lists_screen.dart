import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:listiify/constants.dart';
import 'package:listiify/widgets/add_task.dart';
import 'package:listiify/models/task_data.dart';
import 'package:listiify/models/user_data.dart';
import 'package:listiify/widgets/task_list.dart';

// TODO Stream the tasks somehow

class ListsScreen extends StatelessWidget {
  ListsScreen(context) {
    final email = Provider.of<UserData>(context).email;
    Provider.of<TaskData>(context).streamTasks(email);
  }
  static const String id = 'lists_screen';
  final formKey = GlobalKey<FormState>();

//  ListsScreen(context) {}

  @override
  Widget build(BuildContext context) {
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
                    return AddTask(
                        width: width, context: context, formKey: formKey);
                  });
            }));
  }
}
