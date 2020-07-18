import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:listiify/components/oval_button.dart';
import 'package:listiify/widgets/task_tile.dart';
import 'package:listiify/models/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return Slidable(
              actionPane: SlidableBehindActionPane(),
              actionExtentRatio: 0.25,
              actions: <Widget>[
                OvalButton(
                  colour: Colors.red,
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    taskData.deleteTask(task);
                  },
                )
              ],
              child: TaskTile(
                taskTitle: task.name,
                isChecked: task.isDone,
                checkboxCallback: (checkboxState) {
                  taskData.updateTask(task);
                },
              ),
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
