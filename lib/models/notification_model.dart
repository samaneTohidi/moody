import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String notificationId,
    required String userId,
    required String fromUserId,
    required String notificationType,
    @TimestampConverter() required Timestamp createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    if (data != null) {
      return NotificationModel.fromJson(data);
    } else {
      throw Exception('Document snapshot is null or does not exist');
    }
  }

  Map<String, dynamic> toJson() => {
    'notificationId': notificationId,
    'userId': userId,
    'fromUserId': fromUserId,
    'notificationType': notificationType,
    'createdAt': createdAt,
  };
}

class TimestampConverter implements JsonConverter<Timestamp, DateTime> {
  const TimestampConverter();

  @override
  Timestamp fromJson(DateTime json) => Timestamp.fromDate(json);

  @override
  DateTime toJson(Timestamp object) => object.toDate();
}