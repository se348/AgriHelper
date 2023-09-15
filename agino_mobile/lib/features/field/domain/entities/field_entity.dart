import 'weather_entity.dart';
import '../../../sensor/domain/entities/sensor_entity.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class FieldEntity extends Equatable {
  // public int FieldId { get; set; }
  //     public int FarmId { get; set; }
  //     public Farm? Farm { get; set; }
  //     public int Altitude { get; set; }
  //     public string Polygon { get; set; }

  //     public ICollection<Sensor>? Sensors { get; set; }
  final int? farmId;
  final int altitude;
  int? fieldId;
  final String polygon;
  final List<WeatherEntity>? weatherEntities;
  final List<SensorEntity>? sensorEntities;
  FieldEntity(
      {required this.farmId,
      required this.altitude,
      this.weatherEntities,
      this.sensorEntities,
      this.fieldId,
      required this.polygon});

  @override
  List<Object?> get props => [farmId, fieldId, altitude, polygon];
}
