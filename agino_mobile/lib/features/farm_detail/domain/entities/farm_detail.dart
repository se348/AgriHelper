import 'notification_entity.dart';

import '../../../field/domain/entities/field_entity.dart';

class FarmDetail {
  final int farmId;
  final String name;
  final String postCode;
  final String city;
  final String country;

  final List<FieldEntity> fields;
  final List<NotificationEntity>? notifications;

  FarmDetail(
      {required this.farmId,
      required this.name,
      required this.postCode,
      required this.city,
      required this.country,
      this.notifications,
      required this.fields});
}
