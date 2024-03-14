// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FlowState {
  List<String> get disabledSources => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FlowStateCopyWith<FlowState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlowStateCopyWith<$Res> {
  factory $FlowStateCopyWith(FlowState value, $Res Function(FlowState) then) =
      _$FlowStateCopyWithImpl<$Res, FlowState>;
  @useResult
  $Res call({List<String> disabledSources});
}

/// @nodoc
class _$FlowStateCopyWithImpl<$Res, $Val extends FlowState>
    implements $FlowStateCopyWith<$Res> {
  _$FlowStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? disabledSources = null,
  }) {
    return _then(_value.copyWith(
      disabledSources: null == disabledSources
          ? _value.disabledSources
          : disabledSources // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlowStateImplCopyWith<$Res>
    implements $FlowStateCopyWith<$Res> {
  factory _$$FlowStateImplCopyWith(
          _$FlowStateImpl value, $Res Function(_$FlowStateImpl) then) =
      __$$FlowStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> disabledSources});
}

/// @nodoc
class __$$FlowStateImplCopyWithImpl<$Res>
    extends _$FlowStateCopyWithImpl<$Res, _$FlowStateImpl>
    implements _$$FlowStateImplCopyWith<$Res> {
  __$$FlowStateImplCopyWithImpl(
      _$FlowStateImpl _value, $Res Function(_$FlowStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? disabledSources = null,
  }) {
    return _then(_$FlowStateImpl(
      disabledSources: null == disabledSources
          ? _value._disabledSources
          : disabledSources // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$FlowStateImpl implements _FlowState {
  const _$FlowStateImpl({final List<String> disabledSources = const []})
      : _disabledSources = disabledSources;

  final List<String> _disabledSources;
  @override
  @JsonKey()
  List<String> get disabledSources {
    if (_disabledSources is EqualUnmodifiableListView) return _disabledSources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_disabledSources);
  }

  @override
  String toString() {
    return 'FlowState(disabledSources: $disabledSources)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowStateImpl &&
            const DeepCollectionEquality()
                .equals(other._disabledSources, _disabledSources));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_disabledSources));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FlowStateImplCopyWith<_$FlowStateImpl> get copyWith =>
      __$$FlowStateImplCopyWithImpl<_$FlowStateImpl>(this, _$identity);
}

abstract class _FlowState implements FlowState {
  const factory _FlowState({final List<String> disabledSources}) =
      _$FlowStateImpl;

  @override
  List<String> get disabledSources;
  @override
  @JsonKey(ignore: true)
  _$$FlowStateImplCopyWith<_$FlowStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
