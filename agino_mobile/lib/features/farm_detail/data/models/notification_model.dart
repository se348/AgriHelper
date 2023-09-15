import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity{
  NotificationModel({
    required super.fieldId,
    required super.message,
    required super.notificationId,
    required super.sentBy,
    required super.status,
    required super.timestamp,
    required super.title,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
      fieldId: json["fieldId"], 
      message: json["message"], 
      notificationId: json["notificationId"], 
      sentBy: json["sendBy"], 
      status: NotificationTypes.values[json["status"]], 
      timestamp: DateTime.parse(json['timestamp']) , 
      title: json["title"]);
  }
}