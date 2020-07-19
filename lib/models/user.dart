class User {
  final String displayName;
  final String email;
  bool isAdmin;

  User({this.displayName, this.isAdmin = false, this.email});

  User.fromData(Map<dynamic, dynamic> data)
      : displayName = data['displayName'],
        email = data['email'],
        isAdmin = data['isAdmin'];

  Map<String, dynamic> toJson() {
    return {
      'diplayName': displayName,
      'email': email,
      'isAdmin': isAdmin,
    };
  }
}
