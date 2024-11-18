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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
  @Uint8ListConverter()
  Uint8List? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @Uint8ListConverter()
  Uint8List? get groupId => throw _privateConstructorUsedError;
  @Uint8ListConverter()
  Uint8List? get placeId => throw _privateConstructorUsedError;
  @Uint8ListConverter()
  Uint8List? get eventId => throw _privateConstructorUsedError;
  EventStatus get status => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get start => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get end => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)
        auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
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

  /// Serializes this CalendarItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@Uint8ListConverter() Uint8List? id,
      String name,
      String description,
      String location,
      @Uint8ListConverter() Uint8List? groupId,
      @Uint8ListConverter() Uint8List? placeId,
      @Uint8ListConverter() Uint8List? eventId,
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

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? groupId = freezed,
    Object? placeId = freezed,
    Object? eventId = freezed,
    Object? status = null,
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
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
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
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
abstract class _$$FixedCalendarItemImplCopyWith<$Res>
    implements $CalendarItemCopyWith<$Res> {
  factory _$$FixedCalendarItemImplCopyWith(_$FixedCalendarItemImpl value,
          $Res Function(_$FixedCalendarItemImpl) then) =
      __$$FixedCalendarItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Uint8ListConverter() Uint8List? id,
      String name,
      String description,
      String location,
      @Uint8ListConverter() Uint8List? groupId,
      @Uint8ListConverter() Uint8List? placeId,
      @Uint8ListConverter() Uint8List? eventId,
      EventStatus status,
      @DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end});
}

/// @nodoc
class __$$FixedCalendarItemImplCopyWithImpl<$Res>
    extends _$CalendarItemCopyWithImpl<$Res, _$FixedCalendarItemImpl>
    implements _$$FixedCalendarItemImplCopyWith<$Res> {
  __$$FixedCalendarItemImplCopyWithImpl(_$FixedCalendarItemImpl _value,
      $Res Function(_$FixedCalendarItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? groupId = freezed,
    Object? placeId = freezed,
    Object? eventId = freezed,
    Object? status = null,
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_$FixedCalendarItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
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
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
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
class _$FixedCalendarItemImpl extends FixedCalendarItem {
  const _$FixedCalendarItemImpl(
      {@Uint8ListConverter() this.id,
      this.name = '',
      this.description = '',
      this.location = '',
      @Uint8ListConverter() this.groupId,
      @Uint8ListConverter() this.placeId,
      @Uint8ListConverter() this.eventId,
      this.status = EventStatus.confirmed,
      @DateTimeConverter() this.start,
      @DateTimeConverter() this.end,
      final String? $type})
      : $type = $type ?? 'fixed',
        super._();

  factory _$FixedCalendarItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FixedCalendarItemImplFromJson(json);

  @override
  @Uint8ListConverter()
  final Uint8List? id;
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
  @Uint8ListConverter()
  final Uint8List? groupId;
  @override
  @Uint8ListConverter()
  final Uint8List? placeId;
  @override
  @Uint8ListConverter()
  final Uint8List? eventId;
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
    return 'CalendarItem.fixed(id: $id, name: $name, description: $description, location: $location, groupId: $groupId, placeId: $placeId, eventId: $eventId, status: $status, start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixedCalendarItemImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other.groupId, groupId) &&
            const DeepCollectionEquality().equals(other.placeId, placeId) &&
            const DeepCollectionEquality().equals(other.eventId, eventId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      name,
      description,
      location,
      const DeepCollectionEquality().hash(groupId),
      const DeepCollectionEquality().hash(placeId),
      const DeepCollectionEquality().hash(eventId),
      status,
      start,
      end);

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixedCalendarItemImplCopyWith<_$FixedCalendarItemImpl> get copyWith =>
      __$$FixedCalendarItemImplCopyWithImpl<_$FixedCalendarItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)
        auto,
  }) {
    return fixed(id, name, description, location, groupId, placeId, eventId,
        status, start, end);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
  }) {
    return fixed?.call(id, name, description, location, groupId, placeId,
        eventId, status, start, end);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
    required TResult orElse(),
  }) {
    if (fixed != null) {
      return fixed(id, name, description, location, groupId, placeId, eventId,
          status, start, end);
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
    return _$$FixedCalendarItemImplToJson(
      this,
    );
  }
}

abstract class FixedCalendarItem extends CalendarItem {
  const factory FixedCalendarItem(
      {@Uint8ListConverter() final Uint8List? id,
      final String name,
      final String description,
      final String location,
      @Uint8ListConverter() final Uint8List? groupId,
      @Uint8ListConverter() final Uint8List? placeId,
      @Uint8ListConverter() final Uint8List? eventId,
      final EventStatus status,
      @DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end}) = _$FixedCalendarItemImpl;
  const FixedCalendarItem._() : super._();

  factory FixedCalendarItem.fromJson(Map<String, dynamic> json) =
      _$FixedCalendarItemImpl.fromJson;

  @override
  @Uint8ListConverter()
  Uint8List? get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get location;
  @override
  @Uint8ListConverter()
  Uint8List? get groupId;
  @override
  @Uint8ListConverter()
  Uint8List? get placeId;
  @override
  @Uint8ListConverter()
  Uint8List? get eventId;
  @override
  EventStatus get status;
  @override
  @DateTimeConverter()
  DateTime? get start;
  @override
  @DateTimeConverter()
  DateTime? get end;

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixedCalendarItemImplCopyWith<_$FixedCalendarItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RepeatingCalendarItemImplCopyWith<$Res>
    implements $CalendarItemCopyWith<$Res> {
  factory _$$RepeatingCalendarItemImplCopyWith(
          _$RepeatingCalendarItemImpl value,
          $Res Function(_$RepeatingCalendarItemImpl) then) =
      __$$RepeatingCalendarItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Uint8ListConverter() Uint8List? id,
      String name,
      String description,
      String location,
      @Uint8ListConverter() Uint8List? groupId,
      @Uint8ListConverter() Uint8List? placeId,
      @Uint8ListConverter() Uint8List? eventId,
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
class __$$RepeatingCalendarItemImplCopyWithImpl<$Res>
    extends _$CalendarItemCopyWithImpl<$Res, _$RepeatingCalendarItemImpl>
    implements _$$RepeatingCalendarItemImplCopyWith<$Res> {
  __$$RepeatingCalendarItemImplCopyWithImpl(_$RepeatingCalendarItemImpl _value,
      $Res Function(_$RepeatingCalendarItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? groupId = freezed,
    Object? placeId = freezed,
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
    return _then(_$RepeatingCalendarItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
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
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
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
class _$RepeatingCalendarItemImpl extends RepeatingCalendarItem {
  const _$RepeatingCalendarItemImpl(
      {@Uint8ListConverter() this.id,
      this.name = '',
      this.description = '',
      this.location = '',
      @Uint8ListConverter() this.groupId,
      @Uint8ListConverter() this.placeId,
      @Uint8ListConverter() this.eventId,
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

  factory _$RepeatingCalendarItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepeatingCalendarItemImplFromJson(json);

  @override
  @Uint8ListConverter()
  final Uint8List? id;
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
  @Uint8ListConverter()
  final Uint8List? groupId;
  @override
  @Uint8ListConverter()
  final Uint8List? placeId;
  @override
  @Uint8ListConverter()
  final Uint8List? eventId;
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
    return 'CalendarItem.repeating(id: $id, name: $name, description: $description, location: $location, groupId: $groupId, placeId: $placeId, eventId: $eventId, status: $status, start: $start, end: $end, repeatType: $repeatType, interval: $interval, variation: $variation, count: $count, until: $until, exceptions: $exceptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepeatingCalendarItemImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other.groupId, groupId) &&
            const DeepCollectionEquality().equals(other.placeId, placeId) &&
            const DeepCollectionEquality().equals(other.eventId, eventId) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      name,
      description,
      location,
      const DeepCollectionEquality().hash(groupId),
      const DeepCollectionEquality().hash(placeId),
      const DeepCollectionEquality().hash(eventId),
      status,
      start,
      end,
      repeatType,
      interval,
      variation,
      count,
      until,
      const DeepCollectionEquality().hash(_exceptions));

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepeatingCalendarItemImplCopyWith<_$RepeatingCalendarItemImpl>
      get copyWith => __$$RepeatingCalendarItemImplCopyWithImpl<
          _$RepeatingCalendarItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)
        auto,
  }) {
    return repeating(
        id,
        name,
        description,
        location,
        groupId,
        placeId,
        eventId,
        status,
        start,
        end,
        repeatType,
        interval,
        variation,
        count,
        until,
        exceptions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
  }) {
    return repeating?.call(
        id,
        name,
        description,
        location,
        groupId,
        placeId,
        eventId,
        status,
        start,
        end,
        repeatType,
        interval,
        variation,
        count,
        until,
        exceptions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
    required TResult orElse(),
  }) {
    if (repeating != null) {
      return repeating(
          id,
          name,
          description,
          location,
          groupId,
          placeId,
          eventId,
          status,
          start,
          end,
          repeatType,
          interval,
          variation,
          count,
          until,
          exceptions);
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
    return _$$RepeatingCalendarItemImplToJson(
      this,
    );
  }
}

abstract class RepeatingCalendarItem extends CalendarItem {
  const factory RepeatingCalendarItem(
      {@Uint8ListConverter() final Uint8List? id,
      final String name,
      final String description,
      final String location,
      @Uint8ListConverter() final Uint8List? groupId,
      @Uint8ListConverter() final Uint8List? placeId,
      @Uint8ListConverter() final Uint8List? eventId,
      final EventStatus status,
      @DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end,
      final RepeatType repeatType,
      final int interval,
      final int variation,
      final int count,
      @DateTimeConverter() final DateTime? until,
      final List<int> exceptions}) = _$RepeatingCalendarItemImpl;
  const RepeatingCalendarItem._() : super._();

  factory RepeatingCalendarItem.fromJson(Map<String, dynamic> json) =
      _$RepeatingCalendarItemImpl.fromJson;

  @override
  @Uint8ListConverter()
  Uint8List? get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get location;
  @override
  @Uint8ListConverter()
  Uint8List? get groupId;
  @override
  @Uint8ListConverter()
  Uint8List? get placeId;
  @override
  @Uint8ListConverter()
  Uint8List? get eventId;
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

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepeatingCalendarItemImplCopyWith<_$RepeatingCalendarItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AutoCalendarItemImplCopyWith<$Res>
    implements $CalendarItemCopyWith<$Res> {
  factory _$$AutoCalendarItemImplCopyWith(_$AutoCalendarItemImpl value,
          $Res Function(_$AutoCalendarItemImpl) then) =
      __$$AutoCalendarItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Uint8ListConverter() Uint8List? id,
      String name,
      String description,
      String location,
      @Uint8ListConverter() Uint8List? groupId,
      @Uint8ListConverter() Uint8List? placeId,
      @Uint8ListConverter() Uint8List? eventId,
      EventStatus status,
      @DateTimeConverter() DateTime? start,
      @DateTimeConverter() DateTime? end,
      @Uint8ListConverter() Uint8List? autoGroupId,
      @DateTimeConverter() DateTime? searchStart,
      int autoDuration});
}

/// @nodoc
class __$$AutoCalendarItemImplCopyWithImpl<$Res>
    extends _$CalendarItemCopyWithImpl<$Res, _$AutoCalendarItemImpl>
    implements _$$AutoCalendarItemImplCopyWith<$Res> {
  __$$AutoCalendarItemImplCopyWithImpl(_$AutoCalendarItemImpl _value,
      $Res Function(_$AutoCalendarItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? groupId = freezed,
    Object? placeId = freezed,
    Object? eventId = freezed,
    Object? status = null,
    Object? start = freezed,
    Object? end = freezed,
    Object? autoGroupId = freezed,
    Object? searchStart = freezed,
    Object? autoDuration = null,
  }) {
    return _then(_$AutoCalendarItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
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
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
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
      autoGroupId: freezed == autoGroupId
          ? _value.autoGroupId
          : autoGroupId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
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
class _$AutoCalendarItemImpl extends AutoCalendarItem {
  const _$AutoCalendarItemImpl(
      {@Uint8ListConverter() this.id,
      this.name = '',
      this.description = '',
      this.location = '',
      @Uint8ListConverter() this.groupId,
      @Uint8ListConverter() this.placeId,
      @Uint8ListConverter() this.eventId,
      this.status = EventStatus.confirmed,
      @DateTimeConverter() this.start,
      @DateTimeConverter() this.end,
      @Uint8ListConverter() this.autoGroupId,
      @DateTimeConverter() this.searchStart,
      this.autoDuration = 60,
      final String? $type})
      : $type = $type ?? 'auto',
        super._();

  factory _$AutoCalendarItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AutoCalendarItemImplFromJson(json);

  @override
  @Uint8ListConverter()
  final Uint8List? id;
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
  @Uint8ListConverter()
  final Uint8List? groupId;
  @override
  @Uint8ListConverter()
  final Uint8List? placeId;
  @override
  @Uint8ListConverter()
  final Uint8List? eventId;
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
  @Uint8ListConverter()
  final Uint8List? autoGroupId;
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
    return 'CalendarItem.auto(id: $id, name: $name, description: $description, location: $location, groupId: $groupId, placeId: $placeId, eventId: $eventId, status: $status, start: $start, end: $end, autoGroupId: $autoGroupId, searchStart: $searchStart, autoDuration: $autoDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoCalendarItemImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other.groupId, groupId) &&
            const DeepCollectionEquality().equals(other.placeId, placeId) &&
            const DeepCollectionEquality().equals(other.eventId, eventId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            const DeepCollectionEquality()
                .equals(other.autoGroupId, autoGroupId) &&
            (identical(other.searchStart, searchStart) ||
                other.searchStart == searchStart) &&
            (identical(other.autoDuration, autoDuration) ||
                other.autoDuration == autoDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      name,
      description,
      location,
      const DeepCollectionEquality().hash(groupId),
      const DeepCollectionEquality().hash(placeId),
      const DeepCollectionEquality().hash(eventId),
      status,
      start,
      end,
      const DeepCollectionEquality().hash(autoGroupId),
      searchStart,
      autoDuration);

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoCalendarItemImplCopyWith<_$AutoCalendarItemImpl> get copyWith =>
      __$$AutoCalendarItemImplCopyWithImpl<_$AutoCalendarItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)
        fixed,
    required TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)
        auto,
  }) {
    return auto(id, name, description, location, groupId, placeId, eventId,
        status, start, end, autoGroupId, searchStart, autoDuration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult? Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
  }) {
    return auto?.call(id, name, description, location, groupId, placeId,
        eventId, status, start, end, autoGroupId, searchStart, autoDuration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end)?
        fixed,
    TResult Function(
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
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
            @Uint8ListConverter() Uint8List? id,
            String name,
            String description,
            String location,
            @Uint8ListConverter() Uint8List? groupId,
            @Uint8ListConverter() Uint8List? placeId,
            @Uint8ListConverter() Uint8List? eventId,
            EventStatus status,
            @DateTimeConverter() DateTime? start,
            @DateTimeConverter() DateTime? end,
            @Uint8ListConverter() Uint8List? autoGroupId,
            @DateTimeConverter() DateTime? searchStart,
            int autoDuration)?
        auto,
    required TResult orElse(),
  }) {
    if (auto != null) {
      return auto(id, name, description, location, groupId, placeId, eventId,
          status, start, end, autoGroupId, searchStart, autoDuration);
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
    return _$$AutoCalendarItemImplToJson(
      this,
    );
  }
}

abstract class AutoCalendarItem extends CalendarItem {
  const factory AutoCalendarItem(
      {@Uint8ListConverter() final Uint8List? id,
      final String name,
      final String description,
      final String location,
      @Uint8ListConverter() final Uint8List? groupId,
      @Uint8ListConverter() final Uint8List? placeId,
      @Uint8ListConverter() final Uint8List? eventId,
      final EventStatus status,
      @DateTimeConverter() final DateTime? start,
      @DateTimeConverter() final DateTime? end,
      @Uint8ListConverter() final Uint8List? autoGroupId,
      @DateTimeConverter() final DateTime? searchStart,
      final int autoDuration}) = _$AutoCalendarItemImpl;
  const AutoCalendarItem._() : super._();

  factory AutoCalendarItem.fromJson(Map<String, dynamic> json) =
      _$AutoCalendarItemImpl.fromJson;

  @override
  @Uint8ListConverter()
  Uint8List? get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get location;
  @override
  @Uint8ListConverter()
  Uint8List? get groupId;
  @override
  @Uint8ListConverter()
  Uint8List? get placeId;
  @override
  @Uint8ListConverter()
  Uint8List? get eventId;
  @override
  EventStatus get status;
  @override
  @DateTimeConverter()
  DateTime? get start;
  @override
  @DateTimeConverter()
  DateTime? get end;
  @Uint8ListConverter()
  Uint8List? get autoGroupId;
  @DateTimeConverter()
  DateTime? get searchStart;
  int get autoDuration;

  /// Create a copy of CalendarItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AutoCalendarItemImplCopyWith<_$AutoCalendarItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
