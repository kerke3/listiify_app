import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listiify/models/task.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _tasksCollectionReference =
      Firestore.instance.collection('tasks');

  CollectionReference get taskscollection {
    return _tasksCollectionReference;
  }

  Future postTask(Task task) async {
    try {
      DocumentReference newTask =
          await _tasksCollectionReference.add(task.toJson());
      return newTask;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future updateTask(documentID, Task task) async {
    try {
      await _tasksCollectionReference
          .document(documentID)
          .updateData({'isDone': task.isDone});
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future deleteTask(documentID) async {
    try {
      await _tasksCollectionReference.document(documentID).delete();
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getTasks(String email) async {
    try {
      List<Task> taskList = [];
      var userData = await _tasksCollectionReference
          .where('user.email', isEqualTo: email)
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((result) {
          taskList.add(Task.fromData(result.data, result.documentID));
        });
      });
      return taskList;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
