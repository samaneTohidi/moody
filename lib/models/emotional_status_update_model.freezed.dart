// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emotional_status_update_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmotionalStatusUpdateModel _$EmotionalStatusUpdateModelFromJson(
    Map<String, dynamic> json) {
  return _EmotionalStatusUpdateModel.fromJson(json);
}

/// @nodoc
mixin _$EmotionalStatusUpdateModel {
  String get updateId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get emotionalStatus => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmotionalStatusUpdateModelCopyWith<EmotionalStatusUpdateModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmotionalStatusUpdateModelCopyWith<$Res> {
  factory $EmotionalStatusUpdateModelCopyWith(EmotionalStatusUpdateModel value,
          $Res Function(EmotionalStatusUpdateModel) then) =
      _$EmotionalStatusUpdateModelCopyWithImpl<$Res,
          EmotionalStatusUpdateModel>;
  @useResult
  $Res call(
      {String updateId,
      String userId,
      String emotionalStatus,
      @TimestampConverter() Timestamp createdAt});
}

/// @nodoc
class _$EmotionalStatusUpdateModelCopyWithImpl<$Res,
        $Val extends EmotionalStatusUpdateModel>
    implements $EmotionalStatusUpdateModelCopyWith<$Res> {
  _$EmotionalStatusUpdateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updateId = null,
    Object? userId = null,
    Object? emotionalStatus = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      updateId: null == updateId
          ? _value.updateId
          : updateId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      emotionalStatus: null == emotionalStatus
          ? _value.emotionalStatus
          : emotionalStatus // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmotionalStatusUpdateModelImplCopyWith<$Res>
    implements $EmotionalStatusUpdateModelCopyWith<$Res> {
  factory _$$EmotionalStatusUpdateModelImplCopyWith(
          _$EmotionalStatusUpdateModelImpl value,
          $Res Function(_$EmotionalStatusUpdateModelImpl) then) =
      __$$EmotionalStatusUpdateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String updateId,
      String userId,
      String emotionalStatus,
      @TimestampConverter() Timestamp createdAt});
}

/// @nodoc
class __$$EmotionalStatusUpdateModelImplCopyWithImpl<$Res>
    extends _$EmotionalStatusUpdateModelCopyWithImpl<$Res,
        _$EmotionalStatusUpdateModelImpl>
    implements _$$EmotionalStatusUpdateModelImplCopyWith<$Res> {
  __$$EmotionalStatusUpdateModelImplCopyWithImpl(
      _$EmotionalStatusUpdateModelImpl _value,
      $Res Function(_$EmotionalStatusUpdateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updateId = null,
    Object? userId = null,
    Object? emotionalStatus = null,
    Object? createdAt = null,
  }) {
    return _then(_$EmotionalStatusUpdateModelImpl(
      updateId: null == updateId
          ? _value.updateId
          : updateId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      emotionalStatus: null == emotionalStatus
          ? _value.emotionalStatus
          : emotionalStatus // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmotionalStatusUpdateModelImpl implements _EmotionalStatusUpdateModel {
  const _$EmotionalStatusUpdateModelImpl(
      {required this.updateId,
      required this.userId,
      required this.emotionalStatus,
      @TimestampConverter() required this.createdAt});

  factory _$EmotionalStatusUpdateModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EmotionalStatusUpdateModelImplFromJson(json);

  @override
  final String updateId;
  @override
  final String userId;
  @override
  final String emotionalStatus;
  @override
  @TimestampConverter()
  final Timestamp createdAt;

  @override
  String toString() {
    return 'EmotionalStatusUpdateModel(updateId: $updateId, userId: $userId, emotionalStatus: $emotionalStatus, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmotionalStatusUpdateModelImpl &&
            (identical(other.updateId, updateId) ||
                other.updateId == updateId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.emotionalStatus, emotionalStatus) ||
                other.emotionalStatus == emotionalStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, updateId, userId, emotionalStatus, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmotionalStatusUpdateModelImplCopyWith<_$EmotionalStatusUpdateModelImpl>
      get copyWith => __$$EmotionalStatusUpdateModelImplCopyWithImpl<
          _$EmotionalStatusUpdateModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmotionalStatusUpdateModelImplToJson(
      this,
    );
  }
}

abstract class _EmotionalStatusUpdateModel
    implements EmotionalStatusUpdateModel {
  const factory _EmotionalStatusUpdateModel(
          {required final String updateId,
          required final String userId,
          required final String emotionalStatus,
          @TimestampConverter() required final Timestamp createdAt}) =
      _$EmotionalStatusUpdateModelImpl;

  factory _EmotionalStatusUpdateModel.fromJson(Map<String, dynamic> json) =
      _$EmotionalStatusUpdateModelImpl.fromJson;

  @override
  String get updateId;
  @override
  String get userId;
  @override
  String get emotionalStatus;
  @override
  @TimestampConverter()
  Timestamp get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$EmotionalStatusUpdateModelImplCopyWith<_$EmotionalStatusUpdateModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
