// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follower_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FollowerModel _$FollowerModelFromJson(Map<String, dynamic> json) {
  return _FollowerModel.fromJson(json);
}

/// @nodoc
mixin _$FollowerModel {
  String get followerId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get followerUserId => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FollowerModelCopyWith<FollowerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowerModelCopyWith<$Res> {
  factory $FollowerModelCopyWith(
          FollowerModel value, $Res Function(FollowerModel) then) =
      _$FollowerModelCopyWithImpl<$Res, FollowerModel>;
  @useResult
  $Res call(
      {String followerId,
      String userId,
      String followerUserId,
      @TimestampConverter() Timestamp createdAt});
}

/// @nodoc
class _$FollowerModelCopyWithImpl<$Res, $Val extends FollowerModel>
    implements $FollowerModelCopyWith<$Res> {
  _$FollowerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followerId = null,
    Object? userId = null,
    Object? followerUserId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      followerId: null == followerId
          ? _value.followerId
          : followerId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      followerUserId: null == followerUserId
          ? _value.followerUserId
          : followerUserId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FollowerModelImplCopyWith<$Res>
    implements $FollowerModelCopyWith<$Res> {
  factory _$$FollowerModelImplCopyWith(
          _$FollowerModelImpl value, $Res Function(_$FollowerModelImpl) then) =
      __$$FollowerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String followerId,
      String userId,
      String followerUserId,
      @TimestampConverter() Timestamp createdAt});
}

/// @nodoc
class __$$FollowerModelImplCopyWithImpl<$Res>
    extends _$FollowerModelCopyWithImpl<$Res, _$FollowerModelImpl>
    implements _$$FollowerModelImplCopyWith<$Res> {
  __$$FollowerModelImplCopyWithImpl(
      _$FollowerModelImpl _value, $Res Function(_$FollowerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followerId = null,
    Object? userId = null,
    Object? followerUserId = null,
    Object? createdAt = null,
  }) {
    return _then(_$FollowerModelImpl(
      followerId: null == followerId
          ? _value.followerId
          : followerId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      followerUserId: null == followerUserId
          ? _value.followerUserId
          : followerUserId // ignore: cast_nullable_to_non_nullable
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
class _$FollowerModelImpl implements _FollowerModel {
  const _$FollowerModelImpl(
      {required this.followerId,
      required this.userId,
      required this.followerUserId,
      @TimestampConverter() required this.createdAt});

  factory _$FollowerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FollowerModelImplFromJson(json);

  @override
  final String followerId;
  @override
  final String userId;
  @override
  final String followerUserId;
  @override
  @TimestampConverter()
  final Timestamp createdAt;

  @override
  String toString() {
    return 'FollowerModel(followerId: $followerId, userId: $userId, followerUserId: $followerUserId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowerModelImpl &&
            (identical(other.followerId, followerId) ||
                other.followerId == followerId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.followerUserId, followerUserId) ||
                other.followerUserId == followerUserId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, followerId, userId, followerUserId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowerModelImplCopyWith<_$FollowerModelImpl> get copyWith =>
      __$$FollowerModelImplCopyWithImpl<_$FollowerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FollowerModelImplToJson(
      this,
    );
  }
}

abstract class _FollowerModel implements FollowerModel {
  const factory _FollowerModel(
          {required final String followerId,
          required final String userId,
          required final String followerUserId,
          @TimestampConverter() required final Timestamp createdAt}) =
      _$FollowerModelImpl;

  factory _FollowerModel.fromJson(Map<String, dynamic> json) =
      _$FollowerModelImpl.fromJson;

  @override
  String get followerId;
  @override
  String get userId;
  @override
  String get followerUserId;
  @override
  @TimestampConverter()
  Timestamp get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FollowerModelImplCopyWith<_$FollowerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
