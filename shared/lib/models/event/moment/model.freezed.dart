// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Moment _$MomentFromJson(Map<String, dynamic> json) {
  return _Moment.fromJson(json);
}

/// @nodoc
mixin _$Moment {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  int? get eventId => throw _privateConstructorUsedError;
  EventStatus get status => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MomentCopyWith<Moment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MomentCopyWith<$Res> {
  factory $MomentCopyWith(Moment value, $Res Function(Moment) then) =
      _$MomentCopyWithImpl<$Res, Moment>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String location,
      int? eventId,
      EventStatus status,
      @DateTimeConverter() DateTime? time});
}

/// @nodoc
class _$MomentCopyWithImpl<$Res, $Val extends Moment>
    implements $MomentCopyWith<$Res> {
  _$MomentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? eventId = freezed,
    Object? status = null,
    Object? time = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MomentCopyWith<$Res> implements $MomentCopyWith<$Res> {
  factory _$$_MomentCopyWith(_$_Moment value, $Res Function(_$_Moment) then) =
      __$$_MomentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String location,
      int? eventId,
      EventStatus status,
      @DateTimeConverter() DateTime? time});
}

/// @nodoc
class __$$_MomentCopyWithImpl<$Res>
    extends _$MomentCopyWithImpl<$Res, _$_Moment>
    implements _$$_MomentCopyWith<$Res> {
  __$$_MomentCopyWithImpl(_$_Moment _value, $Res Function(_$_Moment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? eventId = freezed,
    Object? status = null,
    Object? time = freezed,
  }) {
    return _then(_$_Moment(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Moment extends _Moment {
  const _$_Moment(
      {this.id = -1,
      this.name = '',
      this.description = '',
      this.location = '',
      this.eventId,
      this.status = EventStatus.confirmed,
      @DateTimeConverter() this.time})
      : super._();

  factory _$_Moment.fromJson(Map<String, dynamic> json) =>
      _$$_MomentFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String location;
  @override
  final int? eventId;
  @override
  @JsonKey()
  final EventStatus status;
  @override
  @DateTimeConverter()
  final DateTime? time;

  @override
  String toString() {
    return 'Moment(id: $id, name: $name, description: $description, location: $location, eventId: $eventId, status: $status, time: $time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Moment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, location, eventId, status, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MomentCopyWith<_$_Moment> get copyWith =>
      __$$_MomentCopyWithImpl<_$_Moment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MomentToJson(
      this,
    );
  }
}

abstract class _Moment extends Moment {
  const factory _Moment(
      {final int id,
      final String name,
      final String description,
      final String location,
      final int? eventId,
      final EventStatus status,
      @DateTimeConverter() final DateTime? time}) = _$_Moment;
  const _Moment._() : super._();

  factory _Moment.fromJson(Map<String, dynamic> json) = _$_Moment.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get location;
  @override
  int? get eventId;
  @override
  EventStatus get status;
  @override
  @DateTimeConverter()
  DateTime? get time;
  @override
  @JsonKey(ignore: true)
  _$$_MomentCopyWith<_$_Moment> get copyWith =>
      throw _privateConstructorUsedError;
}
