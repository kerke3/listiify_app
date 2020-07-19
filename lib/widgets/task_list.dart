import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
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
            return Dismissible(
              direction: DismissDirection.startToEnd,
              key: Key(key.toString()),
              onDismissed: (direction) {
                taskData.deleteTask(task);
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Task Deleted"),
                    backgroundColor: Colors.red));
              },
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
