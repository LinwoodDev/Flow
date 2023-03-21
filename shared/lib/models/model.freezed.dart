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

/// @nodoc
mixin _$SourcedModel<T> {
  String get source => throw _privateConstructorUsedError;
  T get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SourcedModelCopyWith<T, SourcedModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourcedModelCopyWith<T, $Res> {
  factory $SourcedModelCopyWith(
          SourcedModel<T> value, $Res Function(SourcedModel<T>) then) =
      _$SourcedModelCopyWithImpl<T, $Res, SourcedModel<T>>;
  @useResult
  $Res call({String source, T model});
}

/// @nodoc
class _$SourcedModelCopyWithImpl<T, $Res, $Val extends SourcedModel<T>>
    implements $SourcedModelCopyWith<T, $Res> {
  _$SourcedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? model = freezed,
  }) {
    return _then(_value.copyWith(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SourcedModelCopyWith<T, $Res>
    implements $SourcedModelCopyWith<T, $Res> {
  factory _$$_SourcedModelCopyWith(
          _$_SourcedModel<T> value, $Res Function(_$_SourcedModel<T>) then) =
      __$$_SourcedModelCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String source, T model});
}

/// @nodoc
class __$$_SourcedModelCopyWithImpl<T, $Res>
    extends _$SourcedModelCopyWithImpl<T, $Res, _$_SourcedModel<T>>
    implements _$$_SourcedModelCopyWith<T, $Res> {
  __$$_SourcedModelCopyWithImpl(
      _$_SourcedModel<T> _value, $Res Function(_$_SourcedModel<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? model = freezed,
  }) {
    return _then(_$_SourcedModel<T>(
      null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_SourcedModel<T> extends _SourcedModel<T> {
  const _$_SourcedModel(this.source, this.model) : super._();

  @override
  final String source;
  @override
  final T model;

  @override
  String toString() {
    return 'SourcedModel<$T>(source: $source, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SourcedModel<T> &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, source, const DeepCollectionEquality().hash(model));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SourcedModelCopyWith<T, _$_SourcedModel<T>> get copyWith =>
      __$$_SourcedModelCopyWithImpl<T, _$_SourcedModel<T>>(this, _$identity);
}

abstract class _SourcedModel<T> extends SourcedModel<T> {
  const factory _SourcedModel(final String source, final T model) =
      _$_SourcedModel<T>;
  const _SourcedModel._() : super._();

  @override
  String get source;
  @override
  T get model;
  @override
  @JsonKey(ignore: true)
  _$$_SourcedModelCopyWith<T, _$_SourcedModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
