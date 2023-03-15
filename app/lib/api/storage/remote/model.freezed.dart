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

RemoteStorage _$RemoteStorageFromJson(Map<String, dynamic> json) {
  return CalDavStorage.fromJson(json);
}

/// @nodoc
mixin _$RemoteStorage {
  String get url => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, String username) calDav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CalDavStorage value) calDav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RemoteStorageCopyWith<RemoteStorage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteStorageCopyWith<$Res> {
  factory $RemoteStorageCopyWith(
          RemoteStorage value, $Res Function(RemoteStorage) then) =
      _$RemoteStorageCopyWithImpl<$Res, RemoteStorage>;
  @useResult
  $Res call({String url, String username});
}

/// @nodoc
class _$RemoteStorageCopyWithImpl<$Res, $Val extends RemoteStorage>
    implements $RemoteStorageCopyWith<$Res> {
  _$RemoteStorageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalDavStorageCopyWith<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  factory _$$CalDavStorageCopyWith(
          _$CalDavStorage value, $Res Function(_$CalDavStorage) then) =
      __$$CalDavStorageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String username});
}

/// @nodoc
class __$$CalDavStorageCopyWithImpl<$Res>
    extends _$RemoteStorageCopyWithImpl<$Res, _$CalDavStorage>
    implements _$$CalDavStorageCopyWith<$Res> {
  __$$CalDavStorageCopyWithImpl(
      _$CalDavStorage _value, $Res Function(_$CalDavStorage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? username = null,
  }) {
    return _then(_$CalDavStorage(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalDavStorage extends CalDavStorage {
  const _$CalDavStorage({required this.url, required this.username})
      : super._();

  factory _$CalDavStorage.fromJson(Map<String, dynamic> json) =>
      _$$CalDavStorageFromJson(json);

  @override
  final String url;
  @override
  final String username;

  @override
  String toString() {
    return 'RemoteStorage.calDav(url: $url, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalDavStorage &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalDavStorageCopyWith<_$CalDavStorage> get copyWith =>
      __$$CalDavStorageCopyWithImpl<_$CalDavStorage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, String username) calDav,
  }) {
    return calDav(url, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
  }) {
    return calDav?.call(url, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    required TResult orElse(),
  }) {
    if (calDav != null) {
      return calDav(url, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CalDavStorage value) calDav,
  }) {
    return calDav(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
  }) {
    return calDav?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    required TResult orElse(),
  }) {
    if (calDav != null) {
      return calDav(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CalDavStorageToJson(
      this,
    );
  }
}

abstract class CalDavStorage extends RemoteStorage {
  const factory CalDavStorage(
      {required final String url,
      required final String username}) = _$CalDavStorage;
  const CalDavStorage._() : super._();

  factory CalDavStorage.fromJson(Map<String, dynamic> json) =
      _$CalDavStorage.fromJson;

  @override
  String get url;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$CalDavStorageCopyWith<_$CalDavStorage> get copyWith =>
      throw _privateConstructorUsedError;
}
