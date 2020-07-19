import 'package:listiify/models/user.dart';

class Task {
  final String id;
  final String name;
  bool isDone;
  final User user;

  Task({this.name, this.isDone = false, this.user, this.id});

  void toggleDone() {
    isDone = !isDone;
  }

  Task.fromData(Map<String, dynamic> data, documentID)
      : id = documentID,
        name = data['name'],
        isDone = data['isDone'],
        user = User.fromData(data['user']);

  Task.fromStream(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        isDone = data['isDone'],
        user = data['user'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isDone': isDone,
      'user': user.toJson(),
    };
  }
}
