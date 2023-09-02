// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class User extends Equatable {
  String? name;
  String? email;
  String? phone;
  String? password;
  int? userId;

  User({this.name, this.email, this.phone, this.password, this.userId});

  @override
  List<Object?> get props => [name, email, phone, password, userId];
}
