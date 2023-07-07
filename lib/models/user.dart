import 'dart:convert';

class User {
  final String? id;
  final String password;
  final String email;

  User({
    this.id,
    required this.password,
    required this.email,
  });
  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'password': password,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? "",
        password: map['password'] ?? "",
        email: map['email'] ?? "",
        );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
