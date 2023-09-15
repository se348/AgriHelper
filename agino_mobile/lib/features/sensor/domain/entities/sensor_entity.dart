import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SensorEntity extends Equatable {
  int? sensorId;
  final int fieldId;
  final String serialNumber;
  DateTime? lastCommunication;
  final int batteryStatus;
  final int optimalGdd;
  final DateTime cuttingDateCalculated;
  DateTime? lastForecastDate;
  final double latitude;
  final double longitude;
  DateTime? lastResetDate;
  final int baseTemp;
  final int state;
  int? calculatedGdd;

  SensorEntity({
    required this.fieldId,
    required this.serialNumber,
    required this.batteryStatus,
    required this.optimalGdd,
    required this.cuttingDateCalculated,
    required this.latitude,
    required this.longitude,
    required this.baseTemp,
    required this.state,
    this.lastResetDate,
    this.calculatedGdd,
    this.lastCommunication,
    this.lastForecastDate,
    this.sensorId,
  });

  @override
  List<Object?> get props => [
        sensorId,
        fieldId,
        serialNumber,
        batteryStatus,
        optimalGdd,
        cuttingDateCalculated,
        latitude,
        longitude,
        state,
        lastCommunication,
        lastForecastDate,
        lastResetDate,
        baseTemp,
        sensorId,
      ];
}
