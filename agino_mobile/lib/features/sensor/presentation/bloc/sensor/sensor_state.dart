part of 'sensor_bloc.dart';

abstract class SensorState extends Equatable {}

class SensorCreatedSuccessfully extends SensorState {
  final int id;

  SensorCreatedSuccessfully(this.id);
  @override
  List<Object?> get props => [id];
}

class SensorFailed extends SensorState {
  @override
  List<Object?> get props => [];
}

class SensorLoading extends SensorState {
  @override
  List<Object?> get props => [];
}

class SensorIdle extends SensorState {
  @override
  List<Object?> get props => [];
}
