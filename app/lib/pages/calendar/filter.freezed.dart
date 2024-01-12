// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CalendarFilter {
  List<EventStatus> get hiddenStatuses => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  Multihash? get group => throw _privateConstructorUsedError;
  Multihash? get event => throw _privateConstructorUsedError;
  Multihash? get place => throw _privateConstructorUsedError;
  bool get past => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalendarFilterCopyWith<CalendarFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarFilterCopyWith<$Res> {
  factory $CalendarFilterCopyWith(
          CalendarFilter value, $Res Function(CalendarFilter) then) =
      _$CalendarFilterCopyWithImpl<$Res, CalendarFilter>;
  @useResult
  $Res call(
      {List<EventStatus> hiddenStatuses,
      String? source,
      Multihash? group,
      Multihash? event,
      Multihash? place,
      bool past});
}

/// @nodoc
class _$CalendarFilterCopyWithImpl<$Res, $Val extends CalendarFilter>
    implements $CalendarFilterCopyWith<$Res> {
  _$CalendarFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hiddenStatuses = null,
    Object? source = freezed,
    Object? group = freezed,
    Object? event = freezed,
    Object? place = freezed,
    Object? past = null,
  }) {
    return _then(_value.copyWith(
      hiddenStatuses: null == hiddenStatuses
          ? _value.hiddenStatuses
          : hiddenStatuses // ignore: cast_nullable_to_non_nullable
              as List<EventStatus>,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      past: null == past
          ? _value.past
          : past // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarFilterImplCopyWith<$Res>
    implements $CalendarFilterCopyWith<$Res> {
  factory _$$CalendarFilterImplCopyWith(_$CalendarFilterImpl value,
          $Res Function(_$CalendarFilterImpl) then) =
      __$$CalendarFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<EventStatus> hiddenStatuses,
      String? source,
      Multihash? group,
      Multihash? event,
      Multihash? place,
      bool past});
}

/// @nodoc
class __$$CalendarFilterImplCopyWithImpl<$Res>
    extends _$CalendarFilterCopyWithImpl<$Res, _$CalendarFilterImpl>
    implements _$$CalendarFilterImplCopyWith<$Res> {
  __$$CalendarFilterImplCopyWithImpl(
      _$CalendarFilterImpl _value, $Res Function(_$CalendarFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hiddenStatuses = null,
    Object? source = freezed,
    Object? group = freezed,
    Object? event = freezed,
    Object? place = freezed,
    Object? past = null,
  }) {
    return _then(_$CalendarFilterImpl(
      hiddenStatuses: null == hiddenStatuses
          ? _value._hiddenStatuses
          : hiddenStatuses // ignore: cast_nullable_to_non_nullable
              as List<EventStatus>,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      past: null == past
          ? _value.past
          : past // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CalendarFilterImpl extends _CalendarFilter {
  const _$CalendarFilterImpl(
      {final List<EventStatus> hiddenStatuses = const [
        EventStatus.draft,
        EventStatus.cancelled
      ],
      this.source,
      this.group,
      this.event,
      this.place,
      this.past = false})
      : _hiddenStatuses = hiddenStatuses,
        super._();

  final List<EventStatus> _hiddenStatuses;
  @override
  @JsonKey()
  List<EventStatus> get hiddenStatuses {
    if (_hiddenStatuses is EqualUnmodifiableListView) return _hiddenStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hiddenStatuses);
  }

  @override
  final String? source;
  @override
  final Multihash? group;
  @override
  final Multihash? event;
  @override
  final Multihash? place;
  @override
  @JsonKey()
  final bool past;

  @override
  String toString() {
    return 'CalendarFilter(hiddenStatuses: $hiddenStatuses, source: $source, group: $group, event: $event, place: $place, past: $past)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarFilterImpl &&
            const DeepCollectionEquality()
                .equals(other._hiddenStatuses, _hiddenStatuses) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.place, place) || other.place == place) &&
            (identical(other.past, past) || other.past == past));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_hiddenStatuses),
      source,
      group,
      event,
      place,
      past);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarFilterImplCopyWith<_$CalendarFilterImpl> get copyWith =>
      __$$CalendarFilterImplCopyWithImpl<_$CalendarFilterImpl>(
          this, _$identity);
}

abstract class _CalendarFilter extends CalendarFilter {
  const factory _CalendarFilter(
      {final List<EventStatus> hiddenStatuses,
      final String? source,
      final Multihash? group,
      final Multihash? event,
      final Multihash? place,
      final bool past}) = _$CalendarFilterImpl;
  const _CalendarFilter._() : super._();

  @override
  List<EventStatus> get hiddenStatuses;
  @override
  String? get source;
  @override
  Multihash? get group;
  @override
  Multihash? get event;
  @override
  Multihash? get place;
  @override
  bool get past;
  @override
  @JsonKey(ignore: true)
  _$$CalendarFilterImplCopyWith<_$CalendarFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
