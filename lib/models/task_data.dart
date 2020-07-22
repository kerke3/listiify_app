import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:listiify/models/task.dart';
import 'package:listiify/models/user.dart';
import 'package:listiify/services/firestore_service.dart';

class TaskData extends ChangeNotifier {
  FirestoreService _firestoreService = FirestoreService();

  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle, String email, String displayName) async {
    final currentUser = User(email: email, displayName: displayName);
    var task = Task(name: newTaskTitle, user: currentUser, isDone: false);
    var newTask = await _firestoreService.postTask(task);
    if (newTask is DocumentReference) {
      final task = Task(
          name: newTaskTitle,
          user: currentUser,
          isDone: false,
          id: newTask.documentID);
      _tasks.add(task);
      notifyListeners();
    } else {
      print(newTask);
    }
  }

  void streamTasks(email) {
    _firestoreService.taskscollection
        .where("user.email", isEqualTo: email)
        .snapshots()
        .listen((snapshot) {
      List<Task> newsTasks = [];
      for (var document in snapshot.documents) {
        newsTasks.add(Task.fromData(document.data, document.documentID));
      }
      _tasks = newsTasks;
      notifyListeners();
    });
  }

  void getTaskList(String email) async {
    var newTasks = await _firestoreService.getTasks(email);
    if (newTasks is List<Task>) {
      _tasks = newTasks;
      notifyListeners();
    } else {}
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
}
