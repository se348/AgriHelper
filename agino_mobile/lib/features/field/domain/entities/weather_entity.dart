class WeatherEntity {
  final DateTime dateOfTheWeek;
  final double temperature;
  final double precipitation;

  WeatherEntity(
      {required this.dateOfTheWeek,
      required this.temperature,
      required this.precipitation});
}
