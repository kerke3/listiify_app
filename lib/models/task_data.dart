import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:listiify/models/task.dart';
import 'package:listiify/services/firestore_service.dart';
import 'package:listiify/services/authentication_service.dart';

class TaskData extends ChangeNotifier {
  AuthenticationService _authenticationService = AuthenticationService();
  FirestoreService _firestoreService = FirestoreService();

  List<Task> _tasks = [];

  String _displayname;

  String _email;

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  String get displayName {
    return _displayname;
  }

  String get email {
    return _email;
  }

  void addTask(String newTaskTitle) async {
    var task = Task(name: newTaskTitle, user: _email, isDone: false);
    var newTask = await _firestoreService.postTask(task);
    if (newTask is DocumentReference) {
      final task = Task(
          name: newTaskTitle,
          user: _email,
          isDone: false,
          id: newTask.documentID);
      _tasks.add(task);
      notifyListeners();
    } else {
      print(newTask);
    }
  }

  void getTaskList() async {
    var newTasks = await _firestoreService.getTasks(_email);
    if (newTasks is List<Task>) {
      _tasks = newTasks;
      notifyListeners();
    } else {
      print(newTasks);
    }
  }

  void setTaskList(List<Task> taskList) {
    _tasks = taskList;
    notifyListeners();
  }

  void updateTask(Task task) async {
    task.toggleDone();
    var sucess = await _firestoreService.updateTask(task.id, task);
    if (sucess is bool) {
      notifyListeners();
    } else {
      task.toggleDone();
      notifyListeners();
    }
  }

  void deleteTask(Task task) async {
    var sucess = await _firestoreService.deleteTask(task.id);
    if (sucess is bool) {
      _tasks.remove(task);
      notifyListeners();
    }
  }

  void setUserDisplay() async {
    _displayname = await _authenticationService.getUserDisplayName();
    notifyListeners();
  }

  void setUserEmail(String email) async {
    _email = email;
    notifyListeners();
  }
}
