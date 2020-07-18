import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String displayName,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        UserUpdateInfo updateUser = UserUpdateInfo();
        updateUser.displayName = displayName;
        await authResult.user.updateProfile(updateUser);
      }
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future getCurrentUser() async {
    try {
      var user = await _firebaseAuth.currentUser();

      return (user != null ? user : '');
    } catch (e) {
      return e.message;
    }
  }
}
