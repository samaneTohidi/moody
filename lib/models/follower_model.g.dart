// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FollowerModelImpl _$$FollowerModelImplFromJson(Map<String, dynamic> json) =>
    _$FollowerModelImpl(
      followerId: json['followerId'] as String,
      userId: json['userId'] as String,
      followerUserId: json['followerUserId'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as DateTime),
    );

Map<String, dynamic> _$$FollowerModelImplToJson(_$FollowerModelImpl instance) =>
    <String, dynamic>{
      'followerId': instance.followerId,
      'userId': instance.userId,
      'followerUserId': instance.followerUserId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
