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
mixin _$ConnectedModel<A, B> {
  A get source => throw _privateConstructorUsedError;
  B get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConnectedModelCopyWith<A, B, ConnectedModel<A, B>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectedModelCopyWith<A, B, $Res> {
  factory $ConnectedModelCopyWith(ConnectedModel<A, B> value,
          $Res Function(ConnectedModel<A, B>) then) =
      _$ConnectedModelCopyWithImpl<A, B, $Res, ConnectedModel<A, B>>;
  @useResult
  $Res call({A source, B model});
}

/// @nodoc
class _$ConnectedModelCopyWithImpl<A, B, $Res,
        $Val extends ConnectedModel<A, B>>
    implements $ConnectedModelCopyWith<A, B, $Res> {
  _$ConnectedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? model = freezed,
  }) {
    return _then(_value.copyWith(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as A,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as B,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectedModelImplCopyWith<A, B, $Res>
    implements $ConnectedModelCopyWith<A, B, $Res> {
  factory _$$ConnectedModelImplCopyWith(_$ConnectedModelImpl<A, B> value,
          $Res Function(_$ConnectedModelImpl<A, B>) then) =
      __$$ConnectedModelImplCopyWithImpl<A, B, $Res>;
  @override
  @useResult
  $Res call({A source, B model});
}

/// @nodoc
class __$$ConnectedModelImplCopyWithImpl<A, B, $Res>
    extends _$ConnectedModelCopyWithImpl<A, B, $Res, _$ConnectedModelImpl<A, B>>
    implements _$$ConnectedModelImplCopyWith<A, B, $Res> {
  __$$ConnectedModelImplCopyWithImpl(_$ConnectedModelImpl<A, B> _value,
      $Res Function(_$ConnectedModelImpl<A, B>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? model = freezed,
  }) {
    return _then(_$ConnectedModelImpl<A, B>(
      freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as A,
      freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as B,
    ));
  }
}

/// @nodoc

class _$ConnectedModelImpl<A, B> extends _ConnectedModel<A, B> {
  const _$ConnectedModelImpl(this.source, this.model) : super._();

  @override
  final A source;
  @override
  final B model;

  @override
  String toString() {
    return 'ConnectedModel<$A, $B>(source: $source, model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectedModelImpl<A, B> &&
            const DeepCollectionEquality().equals(other.source, source) &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(source),
      const DeepCollectionEquality().hash(model));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectedModelImplCopyWith<A, B, _$ConnectedModelImpl<A, B>>
      get copyWith =>
          __$$ConnectedModelImplCopyWithImpl<A, B, _$ConnectedModelImpl<A, B>>(
              this, _$identity);
}

abstract class _ConnectedModel<A, B> extends ConnectedModel<A, B> {
  const factory _ConnectedModel(final A source, final B model) =
      _$ConnectedModelImpl<A, B>;
  const _ConnectedModel._() : super._();

  @override
  A get source;
  @override
  B get model;
  @override
  @JsonKey(ignore: true)
  _$$ConnectedModelImplCopyWith<A, B, _$ConnectedModelImpl<A, B>>
      get copyWith => throw _privateConstructorUsedError;
}
