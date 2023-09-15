// ignore_for_file: must_be_immutable

import 'package:agino_mobile/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {super.email,
      super.name,
      super.password,
      super.phone,
      super.userId,
      super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json["email"],
        name: json["name"],
        password: json["password"],
        userId: json["userId"],
        token: json["token"],
        phone: json["phone"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "password": password,
      "userId": userId,
      "token": token,
      "phone": phone
    };
  }
}
