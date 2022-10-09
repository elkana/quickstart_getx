import 'dart:convert';

class UserModel {
  String? userId;
  String? userPassword;
  String? fullName;
  bool? isAnonym;
  String? avatarUrl;
  String? token;
  String? userStatus;
  bool? rememberMe;
  bool? emailVerified;
  String? phone;
  DateTime? createdDate;

  UserModel({
    this.userId,
    this.userPassword,
    this.fullName,
    this.isAnonym,
    this.avatarUrl,
    this.token,
    this.userStatus,
    this.rememberMe,
    this.emailVerified,
    this.phone,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userPassword': userPassword,
      'fullName': fullName,
      'isAnonym': isAnonym,
      'avatarUrl': avatarUrl,
      'token': token,
      'userStatus': userStatus,
      'rememberMe': rememberMe,
      'emailVerified': emailVerified,
      'phone': phone,
      'createdDate': createdDate?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      userPassword: map['userPassword'],
      fullName: map['fullName'],
      isAnonym: map['isAnonym'],
      avatarUrl: map['avatarUrl'],
      token: map['token'],
      userStatus: map['userStatus'],
      rememberMe: map['rememberMe'],
      emailVerified: map['emailVerified'],
      phone: map['phone'],
      createdDate: map['createdDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdDate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, userPassword: $userPassword, fullName: $fullName, isAnonym: $isAnonym, avatarUrl: $avatarUrl, token: $token, userStatus: $userStatus, rememberMe: $rememberMe, emailVerified: $emailVerified, phone: $phone, createdDate: $createdDate)';
  }
}
