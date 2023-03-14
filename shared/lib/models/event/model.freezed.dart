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

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  int get id => throw _privateConstructorUsedError;
  int? get parentId => throw _privateConstructorUsedError;
  int? get groupId => throw _privateConstructorUsedError;
  int? get placeId => throw _privateConstructorUsedError;
  bool get blocked => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  EventTime get time => throw _privateConstructorUsedError;
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
      int? parentId,
      int? groupId,
      int? placeId,
      bool blocked,
      String name,
      String description,
      String location,
      EventTime time,
      EventStatus status});

  $EventTimeCopyWith<$Res> get time;
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
    Object? parentId = freezed,
    Object? groupId = freezed,
    Object? placeId = freezed,
    Object? blocked = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? time = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as int?,
      blocked: null == blocked
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as bool,
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
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as EventTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EventTimeCopyWith<$Res> get time {
    return $EventTimeCopyWith<$Res>(_value.time, (value) {
      return _then(_value.copyWith(time: value) as $Val);
    });
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
      int? parentId,
      int? groupId,
      int? placeId,
      bool blocked,
      String name,
      String description,
      String location,
      EventTime time,
      EventStatus status});

  @override
  $EventTimeCopyWith<$Res> get time;
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
    Object? parentId = freezed,
    Object? groupId = freezed,
    Object? placeId = freezed,
    Object? blocked = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? time = null,
    Object? status = null,
  }) {
    return _then(_$_Event(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as int?,
      blocked: null == blocked
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as bool,
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
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as EventTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Event extends _Event {
  const _$_Event(
      {this.id = -1,
      this.parentId,
      this.groupId,
      this.placeId,
      this.blocked = true,
      this.name = '',
      this.description = '',
      this.location = '',
      this.time = const EventTime.fixed(),
      this.status = EventStatus.confirmed})
      : super._();

  factory _$_Event.fromJson(Map<String, dynamic> json) =>
      _$$_EventFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int? parentId;
  @override
  final int? groupId;
  @override
  final int? placeId;
  @override
  @JsonKey()
  final bool blocked;
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
  @JsonKey()
  final EventTime time;
  @override
  @JsonKey()
  final EventStatus status;

  @override
  String toString() {
    return 'Event(id: $id, parentId: $parentId, groupId: $groupId, placeId: $placeId, blocked: $blocked, name: $name, description: $description, location: $location, time: $time, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Event &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.blocked, blocked) || other.blocked == blocked) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, parentId, groupId, placeId,
      blocked, name, description, location, time, status);

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

abstract class _Event extends Event {
  const factory _Event(
      {final int id,
      final int? parentId,
      final int? groupId,
      final int? placeId,
      final bool blocked,
      final String name,
      final String description,
      final String location,
      final EventTime time,
      final EventStatus status}) = _$_Event;
  const _Event._() : super._();

  factory _Event.fromJson(Map<String, dynamic> json) = _$_Event.fromJson;

  @override
  int get id;
  @override
  int? get parentId;
  @override
  int? get groupId;
  @override
  int? get placeId;
  @override
  bool get blocked;
  @override
  String get name;
  @override
  String get description;
  @override
  String get location;
  @override
  EventTime get time;
  @override
  EventStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_EventCopyWith<_$_Event> get copyWith =>
      throw _privateConstructorUsedError;
}

EventTime _$EventTimeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'fixed':
      return FixedEventTime.fromJson(json);
    case 'repeating':
      return RepeatingEventTime.fromJson(json);
    case 'auto':
      return AutoEventTime.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'EventTime',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$EventTime {
  @DateTimeConverter()
  DateTime? get start => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get end => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)
        repeating,
    required TResult Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult? Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        auto,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FixedEventTime value) fixed,
    required TResult Function(RepeatingEventTime value) repeating,
    required TResult Function(AutoEventTime value) auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedEventTime value)? fixed,
    TResult? Function(RepeatingEventTime value)? repeating,
    TResult? Function(AutoEventTime value)? auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedEventTime value)? fixed,
    TResult Function(RepeatingEventTime value)? repeating,
    TResult Function(AutoEventTime value)? auto,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventTimeCopyWith<EventTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventTimeCopyWith<$Res> {
  factory $EventTimeCopyWith(EventTime value, $Res Function(EventTime) then) =
      _$EventTimeCopyWithImpl<$Res, EventTime>;
  @useResult
  $Res call(
      {@DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end});
}

/// @nodoc
class _$EventTimeCopyWithImpl<$Res, $Val extends EventTime>
    implements $EventTimeCopyWith<$Res> {
  _$EventTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FixedEventTimeCopyWith<$Res>
    implements $EventTimeCopyWith<$Res> {
  factory _$$FixedEventTimeCopyWith(
          _$FixedEventTime value, $Res Function(_$FixedEventTime) then) =
      __$$FixedEventTimeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end});
}

/// @nodoc
class __$$FixedEventTimeCopyWithImpl<$Res>
    extends _$EventTimeCopyWithImpl<$Res, _$FixedEventTime>
    implements _$$FixedEventTimeCopyWith<$Res> {
  __$$FixedEventTimeCopyWithImpl(
      _$FixedEventTime _value, $Res Function(_$FixedEventTime) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_$FixedEventTime(
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FixedEventTime implements FixedEventTime {
  const _$FixedEventTime(
      {@DateTimeConverter() this.start,
      @DateTimeConverter() this.end,
      final String? $type})
      : $type = $type ?? 'fixed';

  factory _$FixedEventTime.fromJson(Map<String, dynamic> json) =>
      _$$FixedEventTimeFromJson(json);

  @override
  @DateTimeConverter()
  final DateTime? start;
  @override
  @DateTimeConverter()
  final DateTime? end;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'EventTime.fixed(start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixedEventTime &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FixedEventTimeCopyWith<_$FixedEventTime> get copyWith =>
      __$$FixedEventTimeCopyWithImpl<_$FixedEventTime>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)
        repeating,
    required TResult Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        auto,
  }) {
    return fixed(start, end);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult? Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        auto,
  }) {
    return fixed?.call(start, end);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        auto,
    required TResult orElse(),
  }) {
    if (fixed != null) {
      return fixed(start, end);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FixedEventTime value) fixed,
    required TResult Function(RepeatingEventTime value) repeating,
    required TResult Function(AutoEventTime value) auto,
  }) {
    return fixed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedEventTime value)? fixed,
    TResult? Function(RepeatingEventTime value)? repeating,
    TResult? Function(AutoEventTime value)? auto,
  }) {
    return fixed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedEventTime value)? fixed,
    TResult Function(RepeatingEventTime value)? repeating,
    TResult Function(AutoEventTime value)? auto,
    required TResult orElse(),
  }) {
    if (fixed != null) {
      return fixed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FixedEventTimeToJson(
      this,
    );
  }
}

abstract class FixedEventTime implements EventTime {
  const factory FixedEventTime(
      {@DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end}) = _$FixedEventTime;

  factory FixedEventTime.fromJson(Map<String, dynamic> json) =
      _$FixedEventTime.fromJson;

  @override
  @DateTimeConverter()
  DateTime? get start;
  @override
  @DateTimeConverter()
  DateTime? get end;
  @override
  @JsonKey(ignore: true)
  _$$FixedEventTimeCopyWith<_$FixedEventTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RepeatingEventTimeCopyWith<$Res>
    implements $EventTimeCopyWith<$Res> {
  factory _$$RepeatingEventTimeCopyWith(_$RepeatingEventTime value,
          $Res Function(_$RepeatingEventTime) then) =
      __$$RepeatingEventTimeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end,
      int id,
      RepeatType type,
      int interval,
      int variation,
      int count,
      @DateTimeConverter() DateTime? until,
      List<int> exceptions});
}

/// @nodoc
class __$$RepeatingEventTimeCopyWithImpl<$Res>
    extends _$EventTimeCopyWithImpl<$Res, _$RepeatingEventTime>
    implements _$$RepeatingEventTimeCopyWith<$Res> {
  __$$RepeatingEventTimeCopyWithImpl(
      _$RepeatingEventTime _value, $Res Function(_$RepeatingEventTime) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = freezed,
    Object? end = freezed,
    Object? id = null,
    Object? type = null,
    Object? interval = null,
    Object? variation = null,
    Object? count = null,
    Object? until = freezed,
    Object? exceptions = null,
  }) {
    return _then(_$RepeatingEventTime(
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      exceptions: null == exceptions
          ? _value._exceptions
          : exceptions // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RepeatingEventTime implements RepeatingEventTime {
  const _$RepeatingEventTime(
      {@DateTimeConverter() this.start,
      @DateTimeConverter() this.end,
      this.id = -1,
      this.type = RepeatType.daily,
      this.interval = 1,
      this.variation = 0,
      this.count = 0,
      @DateTimeConverter() this.until,
      final List<int> exceptions = const [],
      final String? $type})
      : _exceptions = exceptions,
        $type = $type ?? 'repeating';

  factory _$RepeatingEventTime.fromJson(Map<String, dynamic> json) =>
      _$$RepeatingEventTimeFromJson(json);

  @override
  @DateTimeConverter()
  final DateTime? start;
  @override
  @DateTimeConverter()
  final DateTime? end;
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
  final List<int> _exceptions;
  @override
  @JsonKey()
  List<int> get exceptions {
    if (_exceptions is EqualUnmodifiableListView) return _exceptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exceptions);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'EventTime.repeating(start: $start, end: $end, id: $id, type: $type, interval: $interval, variation: $variation, count: $count, until: $until, exceptions: $exceptions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepeatingEventTime &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.variation, variation) ||
                other.variation == variation) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.until, until) || other.until == until) &&
            const DeepCollectionEquality()
                .equals(other._exceptions, _exceptions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      start,
      end,
      id,
      type,
      interval,
      variation,
      count,
      until,
      const DeepCollectionEquality().hash(_exceptions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RepeatingEventTimeCopyWith<_$RepeatingEventTime> get copyWith =>
      __$$RepeatingEventTimeCopyWithImpl<_$RepeatingEventTime>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)
        repeating,
    required TResult Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        auto,
  }) {
    return repeating(
        start, end, id, type, interval, variation, count, until, exceptions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult? Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        auto,
  }) {
    return repeating?.call(
        start, end, id, type, interval, variation, count, until, exceptions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        auto,
    required TResult orElse(),
  }) {
    if (repeating != null) {
      return repeating(
          start, end, id, type, interval, variation, count, until, exceptions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FixedEventTime value) fixed,
    required TResult Function(RepeatingEventTime value) repeating,
    required TResult Function(AutoEventTime value) auto,
  }) {
    return repeating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedEventTime value)? fixed,
    TResult? Function(RepeatingEventTime value)? repeating,
    TResult? Function(AutoEventTime value)? auto,
  }) {
    return repeating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedEventTime value)? fixed,
    TResult Function(RepeatingEventTime value)? repeating,
    TResult Function(AutoEventTime value)? auto,
    required TResult orElse(),
  }) {
    if (repeating != null) {
      return repeating(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RepeatingEventTimeToJson(
      this,
    );
  }
}

abstract class RepeatingEventTime implements EventTime {
  const factory RepeatingEventTime(
      {@DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end,
      final int id,
      final RepeatType type,
      final int interval,
      final int variation,
      final int count,
      @DateTimeConverter() final DateTime? until,
      final List<int> exceptions}) = _$RepeatingEventTime;

  factory RepeatingEventTime.fromJson(Map<String, dynamic> json) =
      _$RepeatingEventTime.fromJson;

  @override
  @DateTimeConverter()
  DateTime? get start;
  @override
  @DateTimeConverter()
  DateTime? get end;
  int get id;
  RepeatType get type;
  int get interval;
  int get variation;
  int get count;
  @DateTimeConverter()
  DateTime? get until;
  List<int> get exceptions;
  @override
  @JsonKey(ignore: true)
  _$$RepeatingEventTimeCopyWith<_$RepeatingEventTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AutoEventTimeCopyWith<$Res>
    implements $EventTimeCopyWith<$Res> {
  factory _$$AutoEventTimeCopyWith(
          _$AutoEventTime value, $Res Function(_$AutoEventTime) then) =
      __$$AutoEventTimeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int groupId,
      @DateTimeConverter() DateTime? searchStart,
      int duration,
      @DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end});
}

/// @nodoc
class __$$AutoEventTimeCopyWithImpl<$Res>
    extends _$EventTimeCopyWithImpl<$Res, _$AutoEventTime>
    implements _$$AutoEventTimeCopyWith<$Res> {
  __$$AutoEventTimeCopyWithImpl(
      _$AutoEventTime _value, $Res Function(_$AutoEventTime) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? searchStart = freezed,
    Object? duration = null,
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_$AutoEventTime(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      searchStart: freezed == searchStart
          ? _value.searchStart
          : searchStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AutoEventTime implements AutoEventTime {
  const _$AutoEventTime(
      {this.groupId = -1,
      @DateTimeConverter() this.searchStart,
      this.duration = 60,
      @DateTimeConverter() this.start,
      @DateTimeConverter() this.end,
      final String? $type})
      : $type = $type ?? 'auto';

  factory _$AutoEventTime.fromJson(Map<String, dynamic> json) =>
      _$$AutoEventTimeFromJson(json);

  @override
  @JsonKey()
  final int groupId;
  @override
  @DateTimeConverter()
  final DateTime? searchStart;
  @override
  @JsonKey()
  final int duration;
  @override
  @DateTimeConverter()
  final DateTime? start;
  @override
  @DateTimeConverter()
  final DateTime? end;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'EventTime.auto(groupId: $groupId, searchStart: $searchStart, duration: $duration, start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoEventTime &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.searchStart, searchStart) ||
                other.searchStart == searchStart) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, groupId, searchStart, duration, start, end);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoEventTimeCopyWith<_$AutoEventTime> get copyWith =>
      __$$AutoEventTimeCopyWithImpl<_$AutoEventTime>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)
        repeating,
    required TResult Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        auto,
  }) {
    return auto(groupId, searchStart, duration, start, end);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult? Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        auto,
  }) {
    return auto?.call(groupId, searchStart, duration, start, end);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int id,
            RepeatType type,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult Function(
            int groupId,
            @DateTimeConverter() DateTime? searchStart,
            int duration,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        auto,
    required TResult orElse(),
  }) {
    if (auto != null) {
      return auto(groupId, searchStart, duration, start, end);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FixedEventTime value) fixed,
    required TResult Function(RepeatingEventTime value) repeating,
    required TResult Function(AutoEventTime value) auto,
  }) {
    return auto(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedEventTime value)? fixed,
    TResult? Function(RepeatingEventTime value)? repeating,
    TResult? Function(AutoEventTime value)? auto,
  }) {
    return auto?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedEventTime value)? fixed,
    TResult Function(RepeatingEventTime value)? repeating,
    TResult Function(AutoEventTime value)? auto,
    required TResult orElse(),
  }) {
    if (auto != null) {
      return auto(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AutoEventTimeToJson(
      this,
    );
  }
}

abstract class AutoEventTime implements EventTime {
  const factory AutoEventTime(
      {final int groupId,
      @DateTimeConverter() final DateTime? searchStart,
      final int duration,
      @DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end}) = _$AutoEventTime;

  factory AutoEventTime.fromJson(Map<String, dynamic> json) =
      _$AutoEventTime.fromJson;

  int get groupId;
  @DateTimeConverter()
  DateTime? get searchStart;
  int get duration;
  @override
  @DateTimeConverter()
  DateTime? get start;
  @override
  @DateTimeConverter()
  DateTime? get end;
  @override
  @JsonKey(ignore: true)
  _$$AutoEventTimeCopyWith<_$AutoEventTime> get copyWith =>
      throw _privateConstructorUsedError;
}
