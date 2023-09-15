import 'package:equatable/equatable.dart';

class PositionEntity extends Equatable {
  final double latitude;
  final double longitude;

  const PositionEntity({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
