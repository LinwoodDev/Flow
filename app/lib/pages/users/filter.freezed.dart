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
mixin _$UserFilter {
  String? get source => throw _privateConstructorUsedError;
  String? get group => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserFilterCopyWith<UserFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFilterCopyWith<$Res> {
  factory $UserFilterCopyWith(
          UserFilter value, $Res Function(UserFilter) then) =
      _$UserFilterCopyWithImpl<$Res, UserFilter>;
  @useResult
  $Res call({String? source, String? group});
}

/// @nodoc
class _$UserFilterCopyWithImpl<$Res, $Val extends UserFilter>
    implements $UserFilterCopyWith<$Res> {
  _$UserFilterCopyWithImpl(this._value, this._then);

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
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserFilterCopyWith<$Res>
    implements $UserFilterCopyWith<$Res> {
  factory _$$_UserFilterCopyWith(
          _$_UserFilter value, $Res Function(_$_UserFilter) then) =
      __$$_UserFilterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? source, String? group});
}

/// @nodoc
class __$$_UserFilterCopyWithImpl<$Res>
    extends _$UserFilterCopyWithImpl<$Res, _$_UserFilter>
    implements _$$_UserFilterCopyWith<$Res> {
  __$$_UserFilterCopyWithImpl(
      _$_UserFilter _value, $Res Function(_$_UserFilter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? group = freezed,
  }) {
    return _then(_$_UserFilter(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_UserFilter implements _UserFilter {
  const _$_UserFilter({this.source, this.group});

  @override
  final String? source;
  @override
  final String? group;

  @override
  String toString() {
    return 'UserFilter(source: $source, group: $group)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserFilter &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.group, group) || other.group == group));
  }

  @override
  int get hashCode => Object.hash(runtimeType, source, group);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserFilterCopyWith<_$_UserFilter> get copyWith =>
      __$$_UserFilterCopyWithImpl<_$_UserFilter>(this, _$identity);
}

abstract class _UserFilter implements UserFilter {
  const factory _UserFilter({final String? source, final String? group}) =
      _$_UserFilter;

  @override
  String? get source;
  @override
  String? get group;
  @override
  @JsonKey(ignore: true)
  _$$_UserFilterCopyWith<_$_UserFilter> get copyWith =>
      throw _privateConstructorUsedError;
}
