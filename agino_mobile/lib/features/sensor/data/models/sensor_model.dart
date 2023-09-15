import '../../domain/entities/sensor_entity.dart';

// ignore: must_be_immutable
class SensorModel extends SensorEntity {
  SensorModel(
      {required super.fieldId,
      required super.serialNumber,
      required super.batteryStatus,
      required super.optimalGdd,
      required super.cuttingDateCalculated,
      required super.latitude,
      required super.longitude,
      super.sensorId,
      super.lastResetDate,
      required super.baseTemp,
      super.calculatedGdd,
      super.lastCommunication,
      super.lastForecastDate,
      required super.state});

  Map<String, dynamic> toJson() {
    return {
      "sensorNo": serialNumber,
      "optimalGDD": optimalGdd,
      "cuttingDatCalculated": cuttingDateCalculated.toIso8601String(),
      "latitude": latitude,
      "longitude": longitude,
      "fieldId": fieldId,
      "baseTemp": baseTemp
    };
  }

  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
        fieldId: json["fieldId"],
        serialNumber: json["sensorNo"],
        batteryStatus: json["batteryStatus"],
        optimalGdd: json["optimalGDD"],
        cuttingDateCalculated: DateTime.parse(json["cuttingDatCalculated"]),
        latitude: json['latitude'].toDouble(),
        longitude: json["longitude"].toDouble(),
        baseTemp: json["baseTemp"],
        state: json["state"],
        sensorId: json["sensorId"],
        lastResetDate: json["lastResetDate"],
        calculatedGdd: json["calculatedGdd"],
        lastCommunication: json["lastCommunication"],
        lastForecastDate: json["lastForecastDate"]);
  }
}
