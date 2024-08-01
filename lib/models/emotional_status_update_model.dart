import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'emotional_status_update_model.freezed.dart';
part 'emotional_status_update_model.g.dart';

@freezed
class EmotionalStatusUpdateModel with _$EmotionalStatusUpdateModel {
  const factory EmotionalStatusUpdateModel({
    required String updateId,
    required String userId,
    required String emotionalStatus,
    @TimestampConverter() required Timestamp createdAt,
  }) = _EmotionalStatusUpdateModel;

  factory EmotionalStatusUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$EmotionalStatusUpdateModelFromJson(json);

  factory EmotionalStatusUpdateModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    if (data != null) {
      return EmotionalStatusUpdateModel.fromJson(data);
    } else {
      throw Exception('Document snapshot is null or does not exist');
    }
  }

  Map<String, dynamic> toJson() => {
    'updateId': updateId,
    'userId': userId,
    'emotionalStatus': emotionalStatus,
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
