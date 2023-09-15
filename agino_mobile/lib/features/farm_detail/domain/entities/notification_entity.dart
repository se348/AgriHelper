import 'package:equatable/equatable.dart';

enum NotificationTypes { warning, error, info }

class NotificationEntity extends Equatable {
  final int notificationId;
  final String title;
  final String message;
  final int sentBy;
  final NotificationTypes status;
  final int fieldId;
  final DateTime timestamp;

  const NotificationEntity({
   required this.notificationId, 
   required this.title, 
   required this.message,
   required this.sentBy, 
   required this.status, 
   required this.fieldId, 
   required this.timestamp});

  @override
  List<Object?> get props =>
      [notificationId, title, message, sentBy, status, fieldId, timestamp];
}
