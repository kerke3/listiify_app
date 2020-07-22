import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:listiify/components/rounded_button.dart';
import 'package:listiify/models/user_data.dart';
import 'package:listiify/models/task_data.dart';

class AddTask extends StatelessWidget {
  AddTask({this.width, this.context, this.formKey});

  final double width;
  final textController = TextEditingController();
  final GlobalKey<FormState> formKey;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          width: width,
          child: Form(
            key: formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              autofocus: true,
              controller: textController,
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
                  if (formKey.currentState.validate()) {
                    final displayName =
                        Provider.of<UserData>(context).displayName;
                    final email = Provider.of<UserData>(context).email;
                    Provider.of<TaskData>(context)
                        .addTask(textController.text, email, displayName);
                    Navigator.pop(context);
                  }
                }),
          ),
        ]);
  }
}
