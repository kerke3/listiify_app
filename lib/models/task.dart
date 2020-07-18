import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String name;
  bool isDone;
  final String user;

  Task({this.name, this.isDone = false, this.user, this.id});

  void toggleDone() {
    isDone = !isDone;
  }

  Task.fromData(Map<dynamic, dynamic> data, documentID)
      : id = documentID,
        name = data['name'],
        isDone = data['isDone'],
        user = data['user'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isDone': isDone,
      'user': user,
    };
  }
}
