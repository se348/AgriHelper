import '../../domain/entities/location.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.country,
    required super.postcode,
    required super.city,
    required super.displayName,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      country: json["address"]["country"],
      city: json["address"]["city"] ?? "Addis Ababa",
      postcode: int.parse(json["address"]["postcode"]),
      displayName: json["display_name"],
    );
  }
}
