// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String,
      emotionalStatus: json['emotionalStatus'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as DateTime),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as DateTime),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'passwordHash': instance.passwordHash,
      'profilePictureUrl': instance.profilePictureUrl,
      'emotionalStatus': instance.emotionalStatus,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
