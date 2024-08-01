// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      notificationId: json['notificationId'] as String,
      userId: json['userId'] as String,
      fromUserId: json['fromUserId'] as String,
      notificationType: json['notificationType'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as DateTime),
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'userId': instance.userId,
      'fromUserId': instance.fromUserId,
      'notificationType': instance.notificationType,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
