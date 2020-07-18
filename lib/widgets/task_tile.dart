import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;

  TaskTile({this.isChecked, this.taskTitle, this.checkboxCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Checkbox(
            value: isChecked,
            onChanged: checkboxCallback,
            activeColor: Colors.lightBlueAccent,
          ),
          title: Text(
            taskTitle,
            style: TextStyle(
                decoration: isChecked ? TextDecoration.lineThrough : null),
          ),
        ),
        Divider(
          thickness: 1,
          indent: 30,
          color: Colors.grey.shade400,
        ),
      ],
    );
  }
}
