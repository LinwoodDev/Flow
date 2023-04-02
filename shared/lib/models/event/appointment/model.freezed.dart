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

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'fixed':
      return FixedAppointment.fromJson(json);
    case 'repeating':
      return RepeatingAppointment.fromJson(json);
    case 'auto':
      return AutoAppointment.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Appointment',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Appointment {
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
    required TResult Function(FixedAppointment value) fixed,
    required TResult Function(RepeatingAppointment value) repeating,
    required TResult Function(AutoAppointment value) auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedAppointment value)? fixed,
    TResult? Function(RepeatingAppointment value)? repeating,
    TResult? Function(AutoAppointment value)? auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedAppointment value)? fixed,
    TResult Function(RepeatingAppointment value)? repeating,
    TResult Function(AutoAppointment value)? auto,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentCopyWith<Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentCopyWith<$Res> {
  factory $AppointmentCopyWith(
          Appointment value, $Res Function(Appointment) then) =
      _$AppointmentCopyWithImpl<$Res, Appointment>;
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
class _$AppointmentCopyWithImpl<$Res, $Val extends Appointment>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._value, this._then);

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
abstract class _$$FixedAppointmentCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$FixedAppointmentCopyWith(
          _$FixedAppointment value, $Res Function(_$FixedAppointment) then) =
      __$$FixedAppointmentCopyWithImpl<$Res>;
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
class __$$FixedAppointmentCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$FixedAppointment>
    implements _$$FixedAppointmentCopyWith<$Res> {
  __$$FixedAppointmentCopyWithImpl(
      _$FixedAppointment _value, $Res Function(_$FixedAppointment) _then)
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
    return _then(_$FixedAppointment(
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
class _$FixedAppointment extends FixedAppointment {
  const _$FixedAppointment(
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

  factory _$FixedAppointment.fromJson(Map<String, dynamic> json) =>
      _$$FixedAppointmentFromJson(json);

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
    return 'Appointment.fixed(id: $id, name: $name, description: $description, location: $location, eventId: $eventId, status: $status, start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixedAppointment &&
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
  _$$FixedAppointmentCopyWith<_$FixedAppointment> get copyWith =>
      __$$FixedAppointmentCopyWithImpl<_$FixedAppointment>(this, _$identity);

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
    required TResult Function(FixedAppointment value) fixed,
    required TResult Function(RepeatingAppointment value) repeating,
    required TResult Function(AutoAppointment value) auto,
  }) {
    return fixed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedAppointment value)? fixed,
    TResult? Function(RepeatingAppointment value)? repeating,
    TResult? Function(AutoAppointment value)? auto,
  }) {
    return fixed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedAppointment value)? fixed,
    TResult Function(RepeatingAppointment value)? repeating,
    TResult Function(AutoAppointment value)? auto,
    required TResult orElse(),
  }) {
    if (fixed != null) {
      return fixed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FixedAppointmentToJson(
      this,
    );
  }
}

abstract class FixedAppointment extends Appointment {
  const factory FixedAppointment(
      {final int id,
      final String name,
      final String description,
      final String location,
      final int? eventId,
      final EventStatus status,
      @DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end}) = _$FixedAppointment;
  const FixedAppointment._() : super._();

  factory FixedAppointment.fromJson(Map<String, dynamic> json) =
      _$FixedAppointment.fromJson;

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
  _$$FixedAppointmentCopyWith<_$FixedAppointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RepeatingAppointmentCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$RepeatingAppointmentCopyWith(_$RepeatingAppointment value,
          $Res Function(_$RepeatingAppointment) then) =
      __$$RepeatingAppointmentCopyWithImpl<$Res>;
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
class __$$RepeatingAppointmentCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$RepeatingAppointment>
    implements _$$RepeatingAppointmentCopyWith<$Res> {
  __$$RepeatingAppointmentCopyWithImpl(_$RepeatingAppointment _value,
      $Res Function(_$RepeatingAppointment) _then)
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
    return _then(_$RepeatingAppointment(
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
class _$RepeatingAppointment extends RepeatingAppointment {
  const _$RepeatingAppointment(
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

  factory _$RepeatingAppointment.fromJson(Map<String, dynamic> json) =>
      _$$RepeatingAppointmentFromJson(json);

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
    return 'Appointment.repeating(id: $id, name: $name, description: $description, location: $location, eventId: $eventId, status: $status, start: $start, end: $end, repeatType: $repeatType, interval: $interval, variation: $variation, count: $count, until: $until, exceptions: $exceptions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepeatingAppointment &&
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
  _$$RepeatingAppointmentCopyWith<_$RepeatingAppointment> get copyWith =>
      __$$RepeatingAppointmentCopyWithImpl<_$RepeatingAppointment>(
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
    required TResult Function(FixedAppointment value) fixed,
    required TResult Function(RepeatingAppointment value) repeating,
    required TResult Function(AutoAppointment value) auto,
  }) {
    return repeating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedAppointment value)? fixed,
    TResult? Function(RepeatingAppointment value)? repeating,
    TResult? Function(AutoAppointment value)? auto,
  }) {
    return repeating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedAppointment value)? fixed,
    TResult Function(RepeatingAppointment value)? repeating,
    TResult Function(AutoAppointment value)? auto,
    required TResult orElse(),
  }) {
    if (repeating != null) {
      return repeating(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RepeatingAppointmentToJson(
      this,
    );
  }
}

abstract class RepeatingAppointment extends Appointment {
  const factory RepeatingAppointment(
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
      final List<int> exceptions}) = _$RepeatingAppointment;
  const RepeatingAppointment._() : super._();

  factory RepeatingAppointment.fromJson(Map<String, dynamic> json) =
      _$RepeatingAppointment.fromJson;

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
  _$$RepeatingAppointmentCopyWith<_$RepeatingAppointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AutoAppointmentCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$AutoAppointmentCopyWith(
          _$AutoAppointment value, $Res Function(_$AutoAppointment) then) =
      __$$AutoAppointmentCopyWithImpl<$Res>;
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
class __$$AutoAppointmentCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$AutoAppointment>
    implements _$$AutoAppointmentCopyWith<$Res> {
  __$$AutoAppointmentCopyWithImpl(
      _$AutoAppointment _value, $Res Function(_$AutoAppointment) _then)
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
    return _then(_$AutoAppointment(
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
class _$AutoAppointment extends AutoAppointment {
  const _$AutoAppointment(
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

  factory _$AutoAppointment.fromJson(Map<String, dynamic> json) =>
      _$$AutoAppointmentFromJson(json);

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
    return 'Appointment.auto(id: $id, name: $name, description: $description, location: $location, eventId: $eventId, status: $status, start: $start, end: $end, autoGroupId: $autoGroupId, searchStart: $searchStart, autoDuration: $autoDuration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoAppointment &&
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
  _$$AutoAppointmentCopyWith<_$AutoAppointment> get copyWith =>
      __$$AutoAppointmentCopyWithImpl<_$AutoAppointment>(this, _$identity);

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
    required TResult Function(FixedAppointment value) fixed,
    required TResult Function(RepeatingAppointment value) repeating,
    required TResult Function(AutoAppointment value) auto,
  }) {
    return auto(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FixedAppointment value)? fixed,
    TResult? Function(RepeatingAppointment value)? repeating,
    TResult? Function(AutoAppointment value)? auto,
  }) {
    return auto?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FixedAppointment value)? fixed,
    TResult Function(RepeatingAppointment value)? repeating,
    TResult Function(AutoAppointment value)? auto,
    required TResult orElse(),
  }) {
    if (auto != null) {
      return auto(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AutoAppointmentToJson(
      this,
    );
  }
}

abstract class AutoAppointment extends Appointment {
  const factory AutoAppointment(
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
      final int autoDuration}) = _$AutoAppointment;
  const AutoAppointment._() : super._();

  factory AutoAppointment.fromJson(Map<String, dynamic> json) =
      _$AutoAppointment.fromJson;

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
  _$$AutoAppointmentCopyWith<_$AutoAppointment> get copyWith =>
      throw _privateConstructorUsedError;
}
