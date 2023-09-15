import 'notification_model.dart';

import '../../domain/entities/farm_detail.dart';
import '../../../field/data/models/field_model.dart';

class FarmDetailModel extends FarmDetail {
  FarmDetailModel({
    required super.city,
    required super.country,
    required super.postCode,
    required super.farmId,
    required super.name,
    required super.fields,
    super.notifications,
  });

  factory FarmDetailModel.fromJson(Map<String, dynamic> json){
      List<NotificationModel> notifications= [];
      for (var field in json["fields"]) {
        for (var notification in field["notifications"]){
          notifications.add(NotificationModel.fromJson(notification));
        }
      }
      return FarmDetailModel(
        farmId: json["farmId"],
        name: json["name"],
        postCode: json["postCode"],
        city: json["city"],
        country: json["country"],
        notifications: notifications,
        fields: List<FieldModel>.from(
            json["fields"].map((x) => FieldModel.fromJson2(x, json["farmId"]))),
      );
}
}