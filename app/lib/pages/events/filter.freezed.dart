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
mixin _$EventFilter {
  String? get source => throw _privateConstructorUsedError;
  Multihash? get group => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventFilterCopyWith<EventFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventFilterCopyWith<$Res> {
  factory $EventFilterCopyWith(
          EventFilter value, $Res Function(EventFilter) then) =
      _$EventFilterCopyWithImpl<$Res, EventFilter>;
  @useResult
  $Res call({String? source, Multihash? group});
}

/// @nodoc
class _$EventFilterCopyWithImpl<$Res, $Val extends EventFilter>
    implements $EventFilterCopyWith<$Res> {
  _$EventFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? group = freezed,
  }) {
    return _then(_value.copyWith(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Multihash?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventFilterCopyWith<$Res>
    implements $EventFilterCopyWith<$Res> {
  factory _$$_EventFilterCopyWith(
          _$_EventFilter value, $Res Function(_$_EventFilter) then) =
      __$$_EventFilterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? source, Multihash? group});
}

/// @nodoc
class __$$_EventFilterCopyWithImpl<$Res>
    extends _$EventFilterCopyWithImpl<$Res, _$_EventFilter>
    implements _$$_EventFilterCopyWith<$Res> {
  __$$_EventFilterCopyWithImpl(
      _$_EventFilter _value, $Res Function(_$_EventFilter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? group = freezed,
  }) {
    return _then(_$_EventFilter(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Multihash?,
    ));
  }
}

/// @nodoc

class _$_EventFilter implements _EventFilter {
  const _$_EventFilter({this.source, this.group});

  @override
  final String? source;
  @override
  final Multihash? group;

  @override
  String toString() {
    return 'EventFilter(source: $source, group: $group)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventFilter &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.group, group) || other.group == group));
  }

  @override
  int get hashCode => Object.hash(runtimeType, source, group);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventFilterCopyWith<_$_EventFilter> get copyWith =>
      __$$_EventFilterCopyWithImpl<_$_EventFilter>(this, _$identity);
}

abstract class _EventFilter implements EventFilter {
  const factory _EventFilter({final String? source, final Multihash? group}) =
      _$_EventFilter;

  @override
  String? get source;
  @override
  Multihash? get group;
  @override
  @JsonKey(ignore: true)
  _$$_EventFilterCopyWith<_$_EventFilter> get copyWith =>
      throw _privateConstructorUsedError;
}
