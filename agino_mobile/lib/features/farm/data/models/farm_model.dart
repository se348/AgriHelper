import '../../domain/entities/farm.dart';

// ignore: must_be_immutable
class FarmModel extends Farm {
  FarmModel({
    required super.city,
    required super.country,
    super.farmId,
    required super.name,
    super.userId,
    required super.postCode,
  });

  factory FarmModel.fromJson(Map<String, dynamic> json) {
    return FarmModel(
        city: json["city"],
        country: json["country"],
        name: json["name"],
        farmId: json["farmId"],
        userId: json["userId"],
        postCode: json["postCode"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "farmId": farmId,
      "city": city,
      "country": country,
      "name": name,
      "userId": userId,
      "postCode": postCode,
    };
  }
}
