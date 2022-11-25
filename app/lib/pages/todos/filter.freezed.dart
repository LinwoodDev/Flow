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
  bool get showDone => throw _privateConstructorUsedError;
  bool get showInProgress => throw _privateConstructorUsedError;
  bool get showTodo => throw _privateConstructorUsedError;

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
  $Res call({bool showDone, bool showInProgress, bool showTodo});
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
    Object? showDone = null,
    Object? showInProgress = null,
    Object? showTodo = null,
  }) {
    return _then(_value.copyWith(
      showDone: null == showDone
          ? _value.showDone
          : showDone // ignore: cast_nullable_to_non_nullable
              as bool,
      showInProgress: null == showInProgress
          ? _value.showInProgress
          : showInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      showTodo: null == showTodo
          ? _value.showTodo
          : showTodo // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call({bool showDone, bool showInProgress, bool showTodo});
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
    Object? showDone = null,
    Object? showInProgress = null,
    Object? showTodo = null,
  }) {
    return _then(_$_TodoFilter(
      showDone: null == showDone
          ? _value.showDone
          : showDone // ignore: cast_nullable_to_non_nullable
              as bool,
      showInProgress: null == showInProgress
          ? _value.showInProgress
          : showInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      showTodo: null == showTodo
          ? _value.showTodo
          : showTodo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TodoFilter extends _TodoFilter {
  const _$_TodoFilter(
      {this.showDone = true, this.showInProgress = true, this.showTodo = true})
      : super._();

  @override
  @JsonKey()
  final bool showDone;
  @override
  @JsonKey()
  final bool showInProgress;
  @override
  @JsonKey()
  final bool showTodo;

  @override
  String toString() {
    return 'TodoFilter(showDone: $showDone, showInProgress: $showInProgress, showTodo: $showTodo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoFilter &&
            (identical(other.showDone, showDone) ||
                other.showDone == showDone) &&
            (identical(other.showInProgress, showInProgress) ||
                other.showInProgress == showInProgress) &&
            (identical(other.showTodo, showTodo) ||
                other.showTodo == showTodo));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, showDone, showInProgress, showTodo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TodoFilterCopyWith<_$_TodoFilter> get copyWith =>
      __$$_TodoFilterCopyWithImpl<_$_TodoFilter>(this, _$identity);
}

abstract class _TodoFilter extends TodoFilter {
  const factory _TodoFilter(
      {final bool showDone,
      final bool showInProgress,
      final bool showTodo}) = _$_TodoFilter;
  const _TodoFilter._() : super._();

  @override
  bool get showDone;
  @override
  bool get showInProgress;
  @override
  bool get showTodo;
  @override
  @JsonKey(ignore: true)
  _$$_TodoFilterCopyWith<_$_TodoFilter> get copyWith =>
      throw _privateConstructorUsedError;
}
