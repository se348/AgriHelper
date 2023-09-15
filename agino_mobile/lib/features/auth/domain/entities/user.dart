// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class User extends Equatable {
  String? name;
  String? email;
  String? phone;
  String? password;
  int? userId;
  String? token;

  User({this.name, this.email, this.phone, this.password, this.userId, this.token});

  @override
  List<Object?> get props => [name, email, phone, password, userId, token];
}
