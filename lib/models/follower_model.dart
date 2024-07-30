import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'follower_model.freezed.dart';
part 'follower_model.g.dart';


@freezed
class FollowerModel with _$FollowerModel {
  const factory FollowerModel({
    required String followerId,
    required String userId,
    required String followerUserId,
    @TimestampConverter() required Timestamp createdAt,
  }) = _FollowerModel;

  factory FollowerModel.fromJson(Map<String, dynamic> json) => _$FollowerModelFromJson(json);
}


class TimestampConverter implements JsonConverter<Timestamp, DateTime> {
  const TimestampConverter();

  @override
  Timestamp fromJson(DateTime json) => Timestamp.fromDate(json);

  @override
  DateTime toJson(Timestamp object) => object.toDate();
}
