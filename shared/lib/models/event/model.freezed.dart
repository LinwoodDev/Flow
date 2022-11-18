// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  int get id => throw _privateConstructorUsedError;
  int? get groupId => throw _privateConstructorUsedError;
  int? get placeId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get start => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get end => throw _privateConstructorUsedError;
  EventStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {int id,
      int? groupId,
      int? placeId,
      String name,
      String description,
      String location,
      @DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end,
      EventStatus status});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = freezed,
    Object? placeId = freezed,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? start = freezed,
    Object? end = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as int?,
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
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$_EventCopyWith(_$_Event value, $Res Function(_$_Event) then) =
      __$$_EventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? groupId,
      int? placeId,
      String name,
      String description,
      String location,
      @DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end,
      EventStatus status});
}

/// @nodoc
class __$$_EventCopyWithImpl<$Res> extends _$EventCopyWithImpl<$Res, _$_Event>
    implements _$$_EventCopyWith<$Res> {
  __$$_EventCopyWithImpl(_$_Event _value, $Res Function(_$_Event) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = freezed,
    Object? placeId = freezed,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? start = freezed,
    Object? end = freezed,
    Object? status = null,
  }) {
    return _then(_$_Event(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as int?,
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
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Event implements _Event {
  const _$_Event(
      {this.id = -1,
      this.groupId,
      this.placeId,
      this.name = '',
      this.description = '',
      this.location = '',
      @DateTimeConverter() this.start,
      @DateTimeConverter() this.end,
      this.status = EventStatus.confirmed});

  factory _$_Event.fromJson(Map<String, dynamic> json) =>
      _$$_EventFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int? groupId;
  @override
  final int? placeId;
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
  @DateTimeConverter()
  final DateTime? start;
  @override
  @DateTimeConverter()
  final DateTime? end;
  @override
  @JsonKey()
  final EventStatus status;

  @override
  String toString() {
    return 'Event(id: $id, groupId: $groupId, placeId: $placeId, name: $name, description: $description, location: $location, start: $start, end: $end, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Event &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, groupId, placeId, name,
      description, location, start, end, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventCopyWith<_$_Event> get copyWith =>
      __$$_EventCopyWithImpl<_$_Event>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {final int id,
      final int? groupId,
      final int? placeId,
      final String name,
      final String description,
      final String location,
      @DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end,
      final EventStatus status}) = _$_Event;

  factory _Event.fromJson(Map<String, dynamic> json) = _$_Event.fromJson;

  @override
  int get id;
  @override
  int? get groupId;
  @override
  int? get placeId;
  @override
  String get name;
  @override
  String get description;
  @override
  String get location;
  @override
  @DateTimeConverter()
  DateTime? get start;
  @override
  @DateTimeConverter()
  DateTime? get end;
  @override
  EventStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_EventCopyWith<_$_Event> get copyWith =>
      throw _privateConstructorUsedError;
}

EventGroup _$EventGroupFromJson(Map<String, dynamic> json) {
  return _EventGroup.fromJson(json);
}

/// @nodoc
mixin _$EventGroup {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get open => throw _privateConstructorUsedError;
  @Uint8ListConverter()
  Uint8List? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventGroupCopyWith<EventGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventGroupCopyWith<$Res> {
  factory $EventGroupCopyWith(
          EventGroup value, $Res Function(EventGroup) then) =
      _$EventGroupCopyWithImpl<$Res, EventGroup>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      bool open,
      @Uint8ListConverter() Uint8List? image});
}

/// @nodoc
class _$EventGroupCopyWithImpl<$Res, $Val extends EventGroup>
    implements $EventGroupCopyWith<$Res> {
  _$EventGroupCopyWithImpl(this._value, this._then);

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
    Object? open = null,
    Object? image = freezed,
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
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as bool,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventGroupCopyWith<$Res>
    implements $EventGroupCopyWith<$Res> {
  factory _$$_EventGroupCopyWith(
          _$_EventGroup value, $Res Function(_$_EventGroup) then) =
      __$$_EventGroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      bool open,
      @Uint8ListConverter() Uint8List? image});
}

/// @nodoc
class __$$_EventGroupCopyWithImpl<$Res>
    extends _$EventGroupCopyWithImpl<$Res, _$_EventGroup>
    implements _$$_EventGroupCopyWith<$Res> {
  __$$_EventGroupCopyWithImpl(
      _$_EventGroup _value, $Res Function(_$_EventGroup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? open = null,
    Object? image = freezed,
  }) {
    return _then(_$_EventGroup(
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
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as bool,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventGroup implements _EventGroup {
  const _$_EventGroup(
      {this.id = -1,
      this.name = '',
      this.description = '',
      this.open = true,
      @Uint8ListConverter() this.image});

  factory _$_EventGroup.fromJson(Map<String, dynamic> json) =>
      _$$_EventGroupFromJson(json);

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
  final bool open;
  @override
  @Uint8ListConverter()
  final Uint8List? image;

  @override
  String toString() {
    return 'EventGroup(id: $id, name: $name, description: $description, open: $open, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.open, open) || other.open == open) &&
            const DeepCollectionEquality().equals(other.image, image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, open,
      const DeepCollectionEquality().hash(image));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventGroupCopyWith<_$_EventGroup> get copyWith =>
      __$$_EventGroupCopyWithImpl<_$_EventGroup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventGroupToJson(
      this,
    );
  }
}

abstract class _EventGroup implements EventGroup {
  const factory _EventGroup(
      {final int id,
      final String name,
      final String description,
      final bool open,
      @Uint8ListConverter() final Uint8List? image}) = _$_EventGroup;

  factory _EventGroup.fromJson(Map<String, dynamic> json) =
      _$_EventGroup.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  bool get open;
  @override
  @Uint8ListConverter()
  Uint8List? get image;
  @override
  @JsonKey(ignore: true)
  _$$_EventGroupCopyWith<_$_EventGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

Repetition _$RepetitionFromJson(Map<String, dynamic> json) {
  return _Repetition.fromJson(json);
}

/// @nodoc
mixin _$Repetition {
  int get id => throw _privateConstructorUsedError;
  RepeatType get type => throw _privateConstructorUsedError;
  int get interval => throw _privateConstructorUsedError;
  int get variation => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get until => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepetitionCopyWith<Repetition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepetitionCopyWith<$Res> {
  factory $RepetitionCopyWith(
          Repetition value, $Res Function(Repetition) then) =
      _$RepetitionCopyWithImpl<$Res, Repetition>;
  @useResult
  $Res call(
      {int id,
      RepeatType type,
      int interval,
      int variation,
      int count,
      @DateTimeConverter() DateTime? until});
}

/// @nodoc
class _$RepetitionCopyWithImpl<$Res, $Val extends Repetition>
    implements $RepetitionCopyWith<$Res> {
  _$RepetitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? interval = null,
    Object? variation = null,
    Object? count = null,
    Object? until = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RepeatType,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int,
      variation: null == variation
          ? _value.variation
          : variation // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      until: freezed == until
          ? _value.until
          : until // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RepetitionCopyWith<$Res>
    implements $RepetitionCopyWith<$Res> {
  factory _$$_RepetitionCopyWith(
          _$_Repetition value, $Res Function(_$_Repetition) then) =
      __$$_RepetitionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      RepeatType type,
      int interval,
      int variation,
      int count,
      @DateTimeConverter() DateTime? until});
}

/// @nodoc
class __$$_RepetitionCopyWithImpl<$Res>
    extends _$RepetitionCopyWithImpl<$Res, _$_Repetition>
    implements _$$_RepetitionCopyWith<$Res> {
  __$$_RepetitionCopyWithImpl(
      _$_Repetition _value, $Res Function(_$_Repetition) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? interval = null,
    Object? variation = null,
    Object? count = null,
    Object? until = freezed,
  }) {
    return _then(_$_Repetition(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RepeatType,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int,
      variation: null == variation
          ? _value.variation
          : variation // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      until: freezed == until
          ? _value.until
          : until // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Repetition implements _Repetition {
  const _$_Repetition(
      {this.id = -1,
      this.type = RepeatType.daily,
      this.interval = 1,
      this.variation = 0,
      this.count = 0,
      @DateTimeConverter() this.until});

  factory _$_Repetition.fromJson(Map<String, dynamic> json) =>
      _$$_RepetitionFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final RepeatType type;
  @override
  @JsonKey()
  final int interval;
  @override
  @JsonKey()
  final int variation;
  @override
  @JsonKey()
  final int count;
  @override
  @DateTimeConverter()
  final DateTime? until;

  @override
  String toString() {
    return 'Repetition(id: $id, type: $type, interval: $interval, variation: $variation, count: $count, until: $until)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Repetition &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.variation, variation) ||
                other.variation == variation) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.until, until) || other.until == until));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, interval, variation, count, until);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RepetitionCopyWith<_$_Repetition> get copyWith =>
      __$$_RepetitionCopyWithImpl<_$_Repetition>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepetitionToJson(
      this,
    );
  }
}

abstract class _Repetition implements Repetition {
  const factory _Repetition(
      {final int id,
      final RepeatType type,
      final int interval,
      final int variation,
      final int count,
      @DateTimeConverter() final DateTime? until}) = _$_Repetition;

  factory _Repetition.fromJson(Map<String, dynamic> json) =
      _$_Repetition.fromJson;

  @override
  int get id;
  @override
  RepeatType get type;
  @override
  int get interval;
  @override
  int get variation;
  @override
  int get count;
  @override
  @DateTimeConverter()
  DateTime? get until;
  @override
  @JsonKey(ignore: true)
  _$$_RepetitionCopyWith<_$_Repetition> get copyWith =>
      throw _privateConstructorUsedError;
}
