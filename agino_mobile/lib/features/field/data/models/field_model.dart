import '../../../sensor/data/models/sensor_model.dart';
import '../../domain/entities/field_entity.dart';
import '../../domain/entities/weather_entity.dart';
import 'weather_model.dart';

// ignore: must_be_immutable
class FieldModel extends FieldEntity {
  FieldModel(
      {required super.altitude,
       super.farmId,
      required super.polygon,
      super.sensorEntities,
      super.weatherEntities,
      super.fieldId});

  Map<String, dynamic> toJson() {
    return {"altitude": altitude, "farmId": farmId, "polygon": polygon};
  }

  factory FieldModel.fromJson(Map<String, dynamic> json) =>
      FieldModel(
          fieldId: json["fieldId"],
          altitude: json["altitude"],
          polygon: json["polygon"],
          weatherEntities: List<WeatherEntity>.from(
            json["weathers"].map((x) => WeatherModel.fromJson(x))
          ),
          sensorEntities: List<SensorModel>.from(
            json["sensors"].map((x) => SensorModel.fromJson(x))),
          farmId: json["farmId"]);

  factory FieldModel.fromJson2(Map<String, dynamic> json, int farmId) =>
      FieldModel(
          fieldId: json["fieldId"],
          altitude: json["altitude"],
          polygon: json["polygon"],
          farmId: farmId);
}
