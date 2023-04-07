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

CalendarItem _$CalendarItemFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'fixed':
      return FixedCalendarItem.fromJson(json);
    case 'repeating':
      return RepeatingCalendarItem.fromJson(json);
    case 'auto':
      return AutoCalendarItem.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'CalendarItem',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$CalendarItem {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  int? get eventId => throw _privateConstructorUsedError;
  EventStatus get status => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get start => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get end => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)
        repeating,
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)
        auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FixedCalendarItem value) fixed,
    required TResult Function(RepeatingCalendarItem value) repeating,
    required TResult Function(AutoCalendarItem value) auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedCalendarItem value)? fixed,
    TResult? Function(RepeatingCalendarItem value)? repeating,
    TResult? Function(AutoCalendarItem value)? auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedCalendarItem value)? fixed,
    TResult Function(RepeatingCalendarItem value)? repeating,
    TResult Function(AutoCalendarItem value)? auto,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalendarItemCopyWith<CalendarItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarItemCopyWith<$Res> {
  factory $CalendarItemCopyWith(
          CalendarItem value, $Res Function(CalendarItem) then) =
      _$CalendarItemCopyWithImpl<$Res, CalendarItem>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String location,
      int? eventId,
      EventStatus status,
      @DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end});
}

/// @nodoc
class _$CalendarItemCopyWithImpl<$Res, $Val extends CalendarItem>
    implements $CalendarItemCopyWith<$Res> {
  _$CalendarItemCopyWithImpl(this._value, this._then);

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
    Object? start = freezed,
    Object? end = freezed,
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
abstract class _$$FixedCalendarItemCopyWith<$Res>
    implements $CalendarItemCopyWith<$Res> {
  factory _$$FixedCalendarItemCopyWith(
          _$FixedCalendarItem value, $Res Function(_$FixedCalendarItem) then) =
      __$$FixedCalendarItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String location,
      int? eventId,
      EventStatus status,
      @DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end});
}

/// @nodoc
class __$$FixedCalendarItemCopyWithImpl<$Res>
    extends _$CalendarItemCopyWithImpl<$Res, _$FixedCalendarItem>
    implements _$$FixedCalendarItemCopyWith<$Res> {
  __$$FixedCalendarItemCopyWithImpl(
      _$FixedCalendarItem _value, $Res Function(_$FixedCalendarItem) _then)
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
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_$FixedCalendarItem(
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
class _$FixedCalendarItem extends FixedCalendarItem {
  const _$FixedCalendarItem(
      {this.id = -1,
      this.name = '',
      this.description = '',
      this.location = '',
      this.eventId,
      this.status = EventStatus.confirmed,
      @DateTimeConverter() this.start,
      @DateTimeConverter() this.end,
      final String? $type})
      : $type = $type ?? 'fixed',
        super._();

  factory _$FixedCalendarItem.fromJson(Map<String, dynamic> json) =>
      _$$FixedCalendarItemFromJson(json);

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
  final DateTime? start;
  @override
  @DateTimeConverter()
  final DateTime? end;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CalendarItem.fixed(id: $id, name: $name, description: $description, location: $location, eventId: $eventId, status: $status, start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixedCalendarItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, location,
      eventId, status, start, end);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FixedCalendarItemCopyWith<_$FixedCalendarItem> get copyWith =>
      __$$FixedCalendarItemCopyWithImpl<_$FixedCalendarItem>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)
        repeating,
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)
        auto,
  }) {
    return fixed(id, name, description, location, eventId, status, start, end);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
  }) {
    return fixed?.call(
        id, name, description, location, eventId, status, start, end);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
    required TResult orElse(),
  }) {
    if (fixed != null) {
      return fixed(
          id, name, description, location, eventId, status, start, end);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FixedCalendarItem value) fixed,
    required TResult Function(RepeatingCalendarItem value) repeating,
    required TResult Function(AutoCalendarItem value) auto,
  }) {
    return fixed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedCalendarItem value)? fixed,
    TResult? Function(RepeatingCalendarItem value)? repeating,
    TResult? Function(AutoCalendarItem value)? auto,
  }) {
    return fixed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedCalendarItem value)? fixed,
    TResult Function(RepeatingCalendarItem value)? repeating,
    TResult Function(AutoCalendarItem value)? auto,
    required TResult orElse(),
  }) {
    if (fixed != null) {
      return fixed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FixedCalendarItemToJson(
      this,
    );
  }
}

abstract class FixedCalendarItem extends CalendarItem {
  const factory FixedCalendarItem(
      {final int id,
      final String name,
      final String description,
      final String location,
      final int? eventId,
      final EventStatus status,
      @DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end}) = _$FixedCalendarItem;
  const FixedCalendarItem._() : super._();

  factory FixedCalendarItem.fromJson(Map<String, dynamic> json) =
      _$FixedCalendarItem.fromJson;

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
  DateTime? get start;
  @override
  @DateTimeConverter()
  DateTime? get end;
  @override
  @JsonKey(ignore: true)
  _$$FixedCalendarItemCopyWith<_$FixedCalendarItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RepeatingCalendarItemCopyWith<$Res>
    implements $CalendarItemCopyWith<$Res> {
  factory _$$RepeatingCalendarItemCopyWith(_$RepeatingCalendarItem value,
          $Res Function(_$RepeatingCalendarItem) then) =
      __$$RepeatingCalendarItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String location,
      int? eventId,
      EventStatus status,
      @DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end,
      RepeatType repeatType,
      int interval,
      int variation,
      int count,
      @DateTimeConverter() DateTime? until,
      List<int> exceptions});
}

/// @nodoc
class __$$RepeatingCalendarItemCopyWithImpl<$Res>
    extends _$CalendarItemCopyWithImpl<$Res, _$RepeatingCalendarItem>
    implements _$$RepeatingCalendarItemCopyWith<$Res> {
  __$$RepeatingCalendarItemCopyWithImpl(_$RepeatingCalendarItem _value,
      $Res Function(_$RepeatingCalendarItem) _then)
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
    Object? start = freezed,
    Object? end = freezed,
    Object? repeatType = null,
    Object? interval = null,
    Object? variation = null,
    Object? count = null,
    Object? until = freezed,
    Object? exceptions = null,
  }) {
    return _then(_$RepeatingCalendarItem(
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
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      repeatType: null == repeatType
          ? _value.repeatType
          : repeatType // ignore: cast_nullable_to_non_nullable
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
class _$RepeatingCalendarItem extends RepeatingCalendarItem {
  const _$RepeatingCalendarItem(
      {this.id = -1,
      this.name = '',
      this.description = '',
      this.location = '',
      this.eventId,
      this.status = EventStatus.confirmed,
      @DateTimeConverter() this.start,
      @DateTimeConverter() this.end,
      this.repeatType = RepeatType.daily,
      this.interval = 1,
      this.variation = 0,
      this.count = 0,
      @DateTimeConverter() this.until,
      final List<int> exceptions = const [],
      final String? $type})
      : _exceptions = exceptions,
        $type = $type ?? 'repeating',
        super._();

  factory _$RepeatingCalendarItem.fromJson(Map<String, dynamic> json) =>
      _$$RepeatingCalendarItemFromJson(json);

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
  final DateTime? start;
  @override
  @DateTimeConverter()
  final DateTime? end;
  @override
  @JsonKey()
  final RepeatType repeatType;
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
    return 'CalendarItem.repeating(id: $id, name: $name, description: $description, location: $location, eventId: $eventId, status: $status, start: $start, end: $end, repeatType: $repeatType, interval: $interval, variation: $variation, count: $count, until: $until, exceptions: $exceptions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepeatingCalendarItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.repeatType, repeatType) ||
                other.repeatType == repeatType) &&
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
      id,
      name,
      description,
      location,
      eventId,
      status,
      start,
      end,
      repeatType,
      interval,
      variation,
      count,
      until,
      const DeepCollectionEquality().hash(_exceptions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RepeatingCalendarItemCopyWith<_$RepeatingCalendarItem> get copyWith =>
      __$$RepeatingCalendarItemCopyWithImpl<_$RepeatingCalendarItem>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)
        repeating,
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)
        auto,
  }) {
    return repeating(id, name, description, location, eventId, status, start,
        end, repeatType, interval, variation, count, until, exceptions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
  }) {
    return repeating?.call(id, name, description, location, eventId, status,
        start, end, repeatType, interval, variation, count, until, exceptions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
    required TResult orElse(),
  }) {
    if (repeating != null) {
      return repeating(id, name, description, location, eventId, status, start,
          end, repeatType, interval, variation, count, until, exceptions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FixedCalendarItem value) fixed,
    required TResult Function(RepeatingCalendarItem value) repeating,
    required TResult Function(AutoCalendarItem value) auto,
  }) {
    return repeating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedCalendarItem value)? fixed,
    TResult? Function(RepeatingCalendarItem value)? repeating,
    TResult? Function(AutoCalendarItem value)? auto,
  }) {
    return repeating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedCalendarItem value)? fixed,
    TResult Function(RepeatingCalendarItem value)? repeating,
    TResult Function(AutoCalendarItem value)? auto,
    required TResult orElse(),
  }) {
    if (repeating != null) {
      return repeating(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RepeatingCalendarItemToJson(
      this,
    );
  }
}

abstract class RepeatingCalendarItem extends CalendarItem {
  const factory RepeatingCalendarItem(
      {final int id,
      final String name,
      final String description,
      final String location,
      final int? eventId,
      final EventStatus status,
      @DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end,
      final RepeatType repeatType,
      final int interval,
      final int variation,
      final int count,
      @DateTimeConverter() final DateTime? until,
      final List<int> exceptions}) = _$RepeatingCalendarItem;
  const RepeatingCalendarItem._() : super._();

  factory RepeatingCalendarItem.fromJson(Map<String, dynamic> json) =
      _$RepeatingCalendarItem.fromJson;

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
  DateTime? get start;
  @override
  @DateTimeConverter()
  DateTime? get end;
  RepeatType get repeatType;
  int get interval;
  int get variation;
  int get count;
  @DateTimeConverter()
  DateTime? get until;
  List<int> get exceptions;
  @override
  @JsonKey(ignore: true)
  _$$RepeatingCalendarItemCopyWith<_$RepeatingCalendarItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AutoCalendarItemCopyWith<$Res>
    implements $CalendarItemCopyWith<$Res> {
  factory _$$AutoCalendarItemCopyWith(
          _$AutoCalendarItem value, $Res Function(_$AutoCalendarItem) then) =
      __$$AutoCalendarItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String location,
      int? eventId,
      EventStatus status,
      @DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end,
      int autoGroupId,
      @DateTimeConverter() DateTime? searchStart,
      int autoDuration});
}

/// @nodoc
class __$$AutoCalendarItemCopyWithImpl<$Res>
    extends _$CalendarItemCopyWithImpl<$Res, _$AutoCalendarItem>
    implements _$$AutoCalendarItemCopyWith<$Res> {
  __$$AutoCalendarItemCopyWithImpl(
      _$AutoCalendarItem _value, $Res Function(_$AutoCalendarItem) _then)
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
    Object? start = freezed,
    Object? end = freezed,
    Object? autoGroupId = null,
    Object? searchStart = freezed,
    Object? autoDuration = null,
  }) {
    return _then(_$AutoCalendarItem(
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
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      autoGroupId: null == autoGroupId
          ? _value.autoGroupId
          : autoGroupId // ignore: cast_nullable_to_non_nullable
              as int,
      searchStart: freezed == searchStart
          ? _value.searchStart
          : searchStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      autoDuration: null == autoDuration
          ? _value.autoDuration
          : autoDuration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AutoCalendarItem extends AutoCalendarItem {
  const _$AutoCalendarItem(
      {this.id = -1,
      this.name = '',
      this.description = '',
      this.location = '',
      this.eventId,
      this.status = EventStatus.confirmed,
      @DateTimeConverter() this.start,
      @DateTimeConverter() this.end,
      this.autoGroupId = -1,
      @DateTimeConverter() this.searchStart,
      this.autoDuration = 60,
      final String? $type})
      : $type = $type ?? 'auto',
        super._();

  factory _$AutoCalendarItem.fromJson(Map<String, dynamic> json) =>
      _$$AutoCalendarItemFromJson(json);

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
  final DateTime? start;
  @override
  @DateTimeConverter()
  final DateTime? end;
  @override
  @JsonKey()
  final int autoGroupId;
  @override
  @DateTimeConverter()
  final DateTime? searchStart;
  @override
  @JsonKey()
  final int autoDuration;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CalendarItem.auto(id: $id, name: $name, description: $description, location: $location, eventId: $eventId, status: $status, start: $start, end: $end, autoGroupId: $autoGroupId, searchStart: $searchStart, autoDuration: $autoDuration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoCalendarItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.autoGroupId, autoGroupId) ||
                other.autoGroupId == autoGroupId) &&
            (identical(other.searchStart, searchStart) ||
                other.searchStart == searchStart) &&
            (identical(other.autoDuration, autoDuration) ||
                other.autoDuration == autoDuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, location,
      eventId, status, start, end, autoGroupId, searchStart, autoDuration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoCalendarItemCopyWith<_$AutoCalendarItem> get copyWith =>
      __$$AutoCalendarItemCopyWithImpl<_$AutoCalendarItem>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)
        repeating,
    required TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)
        auto,
  }) {
    return auto(id, name, description, location, eventId, status, start, end,
        autoGroupId, searchStart, autoDuration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult? Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
  }) {
    return auto?.call(id, name, description, location, eventId, status, start,
        end, autoGroupId, searchStart, autoDuration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            RepeatType repeatType,
            int interval,
            int variation,
            int count,
            @DateTimeConverter() DateTime? until,
            List<int> exceptions)?
        repeating,
    TResult Function(
            int id,
            String name,
            String description,
            String location,
            int? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            int autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
    required TResult orElse(),
  }) {
    if (auto != null) {
      return auto(id, name, description, location, eventId, status, start, end,
          autoGroupId, searchStart, autoDuration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FixedCalendarItem value) fixed,
    required TResult Function(RepeatingCalendarItem value) repeating,
    required TResult Function(AutoCalendarItem value) auto,
  }) {
    return auto(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedCalendarItem value)? fixed,
    TResult? Function(RepeatingCalendarItem value)? repeating,
    TResult? Function(AutoCalendarItem value)? auto,
  }) {
    return auto?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedCalendarItem value)? fixed,
    TResult Function(RepeatingCalendarItem value)? repeating,
    TResult Function(AutoCalendarItem value)? auto,
    required TResult orElse(),
  }) {
    if (auto != null) {
      return auto(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AutoCalendarItemToJson(
      this,
    );
  }
}

abstract class AutoCalendarItem extends CalendarItem {
  const factory AutoCalendarItem(
      {final int id,
      final String name,
      final String description,
      final String location,
      final int? eventId,
      final EventStatus status,
      @DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end,
      final int autoGroupId,
      @DateTimeConverter() final DateTime? searchStart,
      final int autoDuration}) = _$AutoCalendarItem;
  const AutoCalendarItem._() : super._();

  factory AutoCalendarItem.fromJson(Map<String, dynamic> json) =
      _$AutoCalendarItem.fromJson;

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
  DateTime? get start;
  @override
  @DateTimeConverter()
  DateTime? get end;
  int get autoGroupId;
  @DateTimeConverter()
  DateTime? get searchStart;
  int get autoDuration;
  @override
  @JsonKey(ignore: true)
  _$$AutoCalendarItemCopyWith<_$AutoCalendarItem> get copyWith =>
      throw _privateConstructorUsedError;
}
