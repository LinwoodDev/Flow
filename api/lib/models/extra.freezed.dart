// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extra.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExtraProperties _$ExtraPropertiesFromJson(Map<String, dynamic> json) {
  return CalDavExtraProperties.fromJson(json);
}

/// @nodoc
mixin _$ExtraProperties {
  String get etag => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String etag, String path) calDav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String etag, String path)? calDav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String etag, String path)? calDav,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CalDavExtraProperties value) calDav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavExtraProperties value)? calDav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavExtraProperties value)? calDav,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExtraPropertiesCopyWith<ExtraProperties> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtraPropertiesCopyWith<$Res> {
  factory $ExtraPropertiesCopyWith(
          ExtraProperties value, $Res Function(ExtraProperties) then) =
      _$ExtraPropertiesCopyWithImpl<$Res, ExtraProperties>;
  @useResult
  $Res call({String etag, String path});
}

/// @nodoc
class _$ExtraPropertiesCopyWithImpl<$Res, $Val extends ExtraProperties>
    implements $ExtraPropertiesCopyWith<$Res> {
  _$ExtraPropertiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? etag = null,
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      etag: null == etag
          ? _value.etag
          : etag // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalDavExtraPropertiesImplCopyWith<$Res>
    implements $ExtraPropertiesCopyWith<$Res> {
  factory _$$CalDavExtraPropertiesImplCopyWith(
          _$CalDavExtraPropertiesImpl value,
          $Res Function(_$CalDavExtraPropertiesImpl) then) =
      __$$CalDavExtraPropertiesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String etag, String path});
}

/// @nodoc
class __$$CalDavExtraPropertiesImplCopyWithImpl<$Res>
    extends _$ExtraPropertiesCopyWithImpl<$Res, _$CalDavExtraPropertiesImpl>
    implements _$$CalDavExtraPropertiesImplCopyWith<$Res> {
  __$$CalDavExtraPropertiesImplCopyWithImpl(_$CalDavExtraPropertiesImpl _value,
      $Res Function(_$CalDavExtraPropertiesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? etag = null,
    Object? path = null,
  }) {
    return _then(_$CalDavExtraPropertiesImpl(
      etag: null == etag
          ? _value.etag
          : etag // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalDavExtraPropertiesImpl implements CalDavExtraProperties {
  const _$CalDavExtraPropertiesImpl({required this.etag, required this.path});

  factory _$CalDavExtraPropertiesImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalDavExtraPropertiesImplFromJson(json);

  @override
  final String etag;
  @override
  final String path;

  @override
  String toString() {
    return 'ExtraProperties.calDav(etag: $etag, path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalDavExtraPropertiesImpl &&
            (identical(other.etag, etag) || other.etag == etag) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, etag, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalDavExtraPropertiesImplCopyWith<_$CalDavExtraPropertiesImpl>
      get copyWith => __$$CalDavExtraPropertiesImplCopyWithImpl<
          _$CalDavExtraPropertiesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String etag, String path) calDav,
  }) {
    return calDav(etag, path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String etag, String path)? calDav,
  }) {
    return calDav?.call(etag, path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String etag, String path)? calDav,
    required TResult orElse(),
  }) {
    if (calDav != null) {
      return calDav(etag, path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CalDavExtraProperties value) calDav,
  }) {
    return calDav(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavExtraProperties value)? calDav,
  }) {
    return calDav?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavExtraProperties value)? calDav,
    required TResult orElse(),
  }) {
    if (calDav != null) {
      return calDav(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CalDavExtraPropertiesImplToJson(
      this,
    );
  }
}

abstract class CalDavExtraProperties implements ExtraProperties {
  const factory CalDavExtraProperties(
      {required final String etag,
      required final String path}) = _$CalDavExtraPropertiesImpl;

  factory CalDavExtraProperties.fromJson(Map<String, dynamic> json) =
      _$CalDavExtraPropertiesImpl.fromJson;

  @override
  String get etag;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$CalDavExtraPropertiesImplCopyWith<_$CalDavExtraPropertiesImpl>
      get copyWith => throw _privateConstructorUsedError;
}
