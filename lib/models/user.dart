import 'dart:convert';

class User {
  String? userId;
  String? userPassword;
  String? token;
  String? userStatus;
  bool? rememberMe;

  User({
    this.userId,
    this.userPassword,
    this.token,
    this.userStatus,
    this.rememberMe,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userPassword': userPassword,
      'token': token,
      'userStatus': userStatus,
      'rememberMe': rememberMe,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      userPassword: map['userPassword'],
      token: map['token'],
      userStatus: map['userStatus'],
      rememberMe: map['rememberMe'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
