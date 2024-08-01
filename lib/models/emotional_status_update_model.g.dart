// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotional_status_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmotionalStatusUpdateModelImpl _$$EmotionalStatusUpdateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EmotionalStatusUpdateModelImpl(
      updateId: json['updateId'] as String,
      userId: json['userId'] as String,
      emotionalStatus: json['emotionalStatus'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as DateTime),
    );

Map<String, dynamic> _$$EmotionalStatusUpdateModelImplToJson(
        _$EmotionalStatusUpdateModelImpl instance) =>
    <String, dynamic>{
      'updateId': instance.updateId,
      'userId': instance.userId,
      'emotionalStatus': instance.emotionalStatus,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
