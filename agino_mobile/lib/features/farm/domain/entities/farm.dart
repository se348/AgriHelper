import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Farm extends Equatable {
  int? farmId;
  final String name;
  final String postCode;
  final String city;
  int? userId;
  final String country;

  Farm(
      {this.farmId,
      required this.name,
      required this.postCode,
      required this.city,
      this.userId,
      required this.country});

  @override
  List<Object?> get props => [farmId, name, postCode, city, country];
}
