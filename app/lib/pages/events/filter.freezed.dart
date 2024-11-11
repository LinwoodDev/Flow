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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventFilter {
  String? get source => throw _privateConstructorUsedError;
  Uint8List? get group => throw _privateConstructorUsedError;
  Uint8List? get place => throw _privateConstructorUsedError;

  /// Create a copy of EventFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventFilterCopyWith<EventFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventFilterCopyWith<$Res> {
  factory $EventFilterCopyWith(
          EventFilter value, $Res Function(EventFilter) then) =
      _$EventFilterCopyWithImpl<$Res, EventFilter>;
  @useResult
  $Res call({String? source, Uint8List? group, Uint8List? place});
}

/// @nodoc
class _$EventFilterCopyWithImpl<$Res, $Val extends EventFilter>
    implements $EventFilterCopyWith<$Res> {
  _$EventFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? group = freezed,
    Object? place = freezed,
  }) {
    return _then(_value.copyWith(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventFilterImplCopyWith<$Res>
    implements $EventFilterCopyWith<$Res> {
  factory _$$EventFilterImplCopyWith(
          _$EventFilterImpl value, $Res Function(_$EventFilterImpl) then) =
      __$$EventFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? source, Uint8List? group, Uint8List? place});
}

/// @nodoc
class __$$EventFilterImplCopyWithImpl<$Res>
    extends _$EventFilterCopyWithImpl<$Res, _$EventFilterImpl>
    implements _$$EventFilterImplCopyWith<$Res> {
  __$$EventFilterImplCopyWithImpl(
      _$EventFilterImpl _value, $Res Function(_$EventFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? group = freezed,
    Object? place = freezed,
  }) {
    return _then(_$EventFilterImpl(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$EventFilterImpl extends _EventFilter {
  const _$EventFilterImpl({this.source, this.group, this.place}) : super._();

  @override
  final String? source;
  @override
  final Uint8List? group;
  @override
  final Uint8List? place;

  @override
  String toString() {
    return 'EventFilter(source: $source, group: $group, place: $place)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventFilterImpl &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.place, place) || other.place == place));
  }

  @override
  int get hashCode => Object.hash(runtimeType, source, group, place);

  /// Create a copy of EventFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventFilterImplCopyWith<_$EventFilterImpl> get copyWith =>
      __$$EventFilterImplCopyWithImpl<_$EventFilterImpl>(this, _$identity);
}

abstract class _EventFilter extends EventFilter {
  const factory _EventFilter(
      {final String? source,
      final Uint8List? group,
      final Uint8List? place}) = _$EventFilterImpl;
  const _EventFilter._() : super._();

  @override
  String? get source;
  @override
  Uint8List? get group;
  @override
  Uint8List? get place;

  /// Create a copy of EventFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventFilterImplCopyWith<_$EventFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
