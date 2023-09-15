import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel(
      {required super.dateOfTheWeek,
      required super.temperature,
      required super.precipitation});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        dateOfTheWeek: DateTime.parse(json['dayOfTheWeek']),
        temperature: json['temperature'].toDouble(),
        precipitation: json['precipitation'].toDouble());
  }
}
