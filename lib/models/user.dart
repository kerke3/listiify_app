class User {
  final String displayName;
  final String email;

  User({this.displayName, this.email});

  User.fromData(Map<dynamic, dynamic> data)
      : displayName = data['displayName'],
        email = data['email'];

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
    };
  }
}
