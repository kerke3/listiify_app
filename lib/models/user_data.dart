import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:listiify/models/user.dart';
import 'package:listiify/models/task.dart';
import 'package:listiify/services/firestore_service.dart';
import 'package:listiify/services/authentication_service.dart';

class UserData extends ChangeNotifier {
  FirestoreService _firestoreService = FirestoreService();
  AuthenticationService _authenticationService = AuthenticationService();

  User _user;

  String get displayName {
    return _user.displayName;
  }

  String get email {
    return _user.email;
  }

  Stream<List<Task>> get streamTasks {
    CollectionReference tasksCollectionRefere =
        _firestoreService.taskscollection;
    return tasksCollectionRefere.snapshots().map((event) => event.documents
        .map((DocumentSnapshot documentSnapshot) =>
            Task.fromStream(documentSnapshot.data))
        .toList());
  }

  void setUser() async {
    final user = await _authenticationService.getCurrentUser();
    _user = User(displayName: user.displayName, email: user.email);
    notifyListeners();
  }

  void registerUser(String email, String displayName) async {
    final newUser = User(email: email, displayName: displayName);
    final user = await _firestoreService.postUser(newUser);
    _user = User(displayName: newUser.displayName, email: newUser.email);
    notifyListeners();
  }
}
