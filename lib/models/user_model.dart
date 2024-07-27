import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String email,
    required String passwordHash,
    required String profilePictureUrl,
    required String emotionalStatus,
    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    if (data != null) {
      return UserModel.fromJson(data);
    } else {
      throw Exception('Document snapshot is null or does not exist');
    }
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'email': email,
        'passwordHash': passwordHash,
        'profilePictureUrl': profilePictureUrl,
        'emotionalStatus': emotionalStatus,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class TimestampConverter implements JsonConverter<Timestamp, DateTime> {
  const TimestampConverter();

  @override
  Timestamp fromJson(DateTime json) => Timestamp.fromDate(json);

  @override
  DateTime toJson(Timestamp object) => object.toDate();
}
