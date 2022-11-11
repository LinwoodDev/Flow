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
mixin _$TodoFilter {
  bool get showCompleted => throw _privateConstructorUsedError;
  bool get showIncompleted => throw _privateConstructorUsedError;
  String get search => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodoFilterCopyWith<TodoFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoFilterCopyWith<$Res> {
  factory $TodoFilterCopyWith(
          TodoFilter value, $Res Function(TodoFilter) then) =
      _$TodoFilterCopyWithImpl<$Res, TodoFilter>;
  @useResult
  $Res call({bool showCompleted, bool showIncompleted, String search});
}

/// @nodoc
class _$TodoFilterCopyWithImpl<$Res, $Val extends TodoFilter>
    implements $TodoFilterCopyWith<$Res> {
  _$TodoFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showCompleted = null,
    Object? showIncompleted = null,
    Object? search = null,
  }) {
    return _then(_value.copyWith(
      showCompleted: null == showCompleted
          ? _value.showCompleted
          : showCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      showIncompleted: null == showIncompleted
          ? _value.showIncompleted
          : showIncompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TodoFilterCopyWith<$Res>
    implements $TodoFilterCopyWith<$Res> {
  factory _$$_TodoFilterCopyWith(
          _$_TodoFilter value, $Res Function(_$_TodoFilter) then) =
      __$$_TodoFilterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool showCompleted, bool showIncompleted, String search});
}

/// @nodoc
class __$$_TodoFilterCopyWithImpl<$Res>
    extends _$TodoFilterCopyWithImpl<$Res, _$_TodoFilter>
    implements _$$_TodoFilterCopyWith<$Res> {
  __$$_TodoFilterCopyWithImpl(
      _$_TodoFilter _value, $Res Function(_$_TodoFilter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showCompleted = null,
    Object? showIncompleted = null,
    Object? search = null,
  }) {
    return _then(_$_TodoFilter(
      showCompleted: null == showCompleted
          ? _value.showCompleted
          : showCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      showIncompleted: null == showIncompleted
          ? _value.showIncompleted
          : showIncompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TodoFilter implements _TodoFilter {
  const _$_TodoFilter(
      {this.showCompleted = true,
      this.showIncompleted = true,
      this.search = ''});

  @override
  @JsonKey()
  final bool showCompleted;
  @override
  @JsonKey()
  final bool showIncompleted;
  @override
  @JsonKey()
  final String search;

  @override
  String toString() {
    return 'TodoFilter(showCompleted: $showCompleted, showIncompleted: $showIncompleted, search: $search)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoFilter &&
            (identical(other.showCompleted, showCompleted) ||
                other.showCompleted == showCompleted) &&
            (identical(other.showIncompleted, showIncompleted) ||
                other.showIncompleted == showIncompleted) &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, showCompleted, showIncompleted, search);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TodoFilterCopyWith<_$_TodoFilter> get copyWith =>
      __$$_TodoFilterCopyWithImpl<_$_TodoFilter>(this, _$identity);
}

abstract class _TodoFilter implements TodoFilter {
  const factory _TodoFilter(
      {final bool showCompleted,
      final bool showIncompleted,
      final String search}) = _$_TodoFilter;

  @override
  bool get showCompleted;
  @override
  bool get showIncompleted;
  @override
  String get search;
  @override
  @JsonKey(ignore: true)
  _$$_TodoFilterCopyWith<_$_TodoFilter> get copyWith =>
      throw _privateConstructorUsedError;
}
