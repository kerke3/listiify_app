import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listiify/widgets/task_list.dart';
import 'package:listiify/services/authentication_service.dart';
import 'package:listiify/models/task.dart';
import 'package:listiify/models/task_data.dart';

class TasksStream extends StatelessWidget {
  final AuthenticationService _authenticationService = AuthenticationService();
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('tasks')
            .where('user', isEqualTo: Provider.of<TaskData>(context).email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data.documents.reversed;
            List<Task> taskList = [];
            for (var task in tasks) {
              taskList.add(Task.fromData(task.data, task.documentID));
            }
//            Provider.of<TaskData>(context).setTaskList(taskList);
          }
          return Expanded(
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
          );
        });
  }
}
