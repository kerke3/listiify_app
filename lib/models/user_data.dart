import 'package:flutter/foundation.dart';
import 'package:listiify/models/user.dart';
import 'package:listiify/services/authentication_service.dart';

class UserData extends ChangeNotifier {
  AuthenticationService _authenticationService = AuthenticationService();

  User _user;

  String get displayName {
    return _user.displayName;
  }

  String get email {
    return _user.email;
  }

  void setUser(email) async {
    _user = User(email: email);
    final user = await _authenticationService.getCurrentUser();
    _user = User(displayName: user.displayName, email: user.email);
    notifyListeners();
  }

  void registerUser(String email, String displayName) async {
    _user = User(
      displayName: displayName,
      email: email,
    );
    notifyListeners();
  }
}
