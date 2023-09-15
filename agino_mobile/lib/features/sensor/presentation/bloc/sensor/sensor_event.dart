part of 'sensor_bloc.dart';

abstract class SensorEvent extends Equatable {}

class CreateSensorEvent extends SensorEvent {
  final SensorEntity sensorEntity;

  CreateSensorEvent(this.sensorEntity);

  @override
  List<Object?> get props => [sensorEntity];
}
