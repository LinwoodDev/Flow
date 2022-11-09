// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  String get search => throw _privateConstructorUsedError;

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
  $Res call({List<EventStatus> hiddenStatuses, String search});
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
    Object? search = null,
  }) {
    return _then(_value.copyWith(
      hiddenStatuses: null == hiddenStatuses
          ? _value.hiddenStatuses
          : hiddenStatuses // ignore: cast_nullable_to_non_nullable
              as List<EventStatus>,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CalendarFilterCopyWith<$Res>
    implements $CalendarFilterCopyWith<$Res> {
  factory _$$_CalendarFilterCopyWith(
          _$_CalendarFilter value, $Res Function(_$_CalendarFilter) then) =
      __$$_CalendarFilterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<EventStatus> hiddenStatuses, String search});
}

/// @nodoc
class __$$_CalendarFilterCopyWithImpl<$Res>
    extends _$CalendarFilterCopyWithImpl<$Res, _$_CalendarFilter>
    implements _$$_CalendarFilterCopyWith<$Res> {
  __$$_CalendarFilterCopyWithImpl(
      _$_CalendarFilter _value, $Res Function(_$_CalendarFilter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hiddenStatuses = null,
    Object? search = null,
  }) {
    return _then(_$_CalendarFilter(
      hiddenStatuses: null == hiddenStatuses
          ? _value._hiddenStatuses
          : hiddenStatuses // ignore: cast_nullable_to_non_nullable
              as List<EventStatus>,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CalendarFilter implements _CalendarFilter {
  const _$_CalendarFilter(
      {final List<EventStatus> hiddenStatuses = const [
        EventStatus.draft,
        EventStatus.cancelled
      ],
      this.search = ''})
      : _hiddenStatuses = hiddenStatuses;

  final List<EventStatus> _hiddenStatuses;
  @override
  @JsonKey()
  List<EventStatus> get hiddenStatuses {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hiddenStatuses);
  }

  @override
  @JsonKey()
  final String search;

  @override
  String toString() {
    return 'CalendarFilter(hiddenStatuses: $hiddenStatuses, search: $search)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CalendarFilter &&
            const DeepCollectionEquality()
                .equals(other._hiddenStatuses, _hiddenStatuses) &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_hiddenStatuses), search);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CalendarFilterCopyWith<_$_CalendarFilter> get copyWith =>
      __$$_CalendarFilterCopyWithImpl<_$_CalendarFilter>(this, _$identity);
}

abstract class _CalendarFilter implements CalendarFilter {
  const factory _CalendarFilter(
      {final List<EventStatus> hiddenStatuses,
      final String search}) = _$_CalendarFilter;

  @override
  List<EventStatus> get hiddenStatuses;
  @override
  String get search;
  @override
  @JsonKey(ignore: true)
  _$$_CalendarFilterCopyWith<_$_CalendarFilter> get copyWith =>
      throw _privateConstructorUsedError;
}
