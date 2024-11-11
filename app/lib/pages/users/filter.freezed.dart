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
mixin _$UserFilter {
  String? get source => throw _privateConstructorUsedError;
  Uint8List? get group => throw _privateConstructorUsedError;

  /// Create a copy of UserFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserFilterCopyWith<UserFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFilterCopyWith<$Res> {
  factory $UserFilterCopyWith(
          UserFilter value, $Res Function(UserFilter) then) =
      _$UserFilterCopyWithImpl<$Res, UserFilter>;
  @useResult
  $Res call({String? source, Uint8List? group});
}

/// @nodoc
class _$UserFilterCopyWithImpl<$Res, $Val extends UserFilter>
    implements $UserFilterCopyWith<$Res> {
  _$UserFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserFilter
  /// with the given fields replaced by the non-null parameter values.
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
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserFilterImplCopyWith<$Res>
    implements $UserFilterCopyWith<$Res> {
  factory _$$UserFilterImplCopyWith(
          _$UserFilterImpl value, $Res Function(_$UserFilterImpl) then) =
      __$$UserFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? source, Uint8List? group});
}

/// @nodoc
class __$$UserFilterImplCopyWithImpl<$Res>
    extends _$UserFilterCopyWithImpl<$Res, _$UserFilterImpl>
    implements _$$UserFilterImplCopyWith<$Res> {
  __$$UserFilterImplCopyWithImpl(
      _$UserFilterImpl _value, $Res Function(_$UserFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? group = freezed,
  }) {
    return _then(_$UserFilterImpl(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$UserFilterImpl implements _UserFilter {
  const _$UserFilterImpl({this.source, this.group});

  @override
  final String? source;
  @override
  final Uint8List? group;

  @override
  String toString() {
    return 'UserFilter(source: $source, group: $group)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserFilterImpl &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.group, group) || other.group == group));
  }

  @override
  int get hashCode => Object.hash(runtimeType, source, group);

  /// Create a copy of UserFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserFilterImplCopyWith<_$UserFilterImpl> get copyWith =>
      __$$UserFilterImplCopyWithImpl<_$UserFilterImpl>(this, _$identity);
}

abstract class _UserFilter implements UserFilter {
  const factory _UserFilter({final String? source, final Uint8List? group}) =
      _$UserFilterImpl;

  @override
  String? get source;
  @override
  Uint8List? get group;

  /// Create a copy of UserFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserFilterImplCopyWith<_$UserFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
