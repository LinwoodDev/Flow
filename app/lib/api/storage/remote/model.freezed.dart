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
  switch (json['runtimeType']) {
    case 'calDav':
      return CalDavStorage.fromJson(json);
    case 'webDav':
      return WebDavStorage.fromJson(json);
    case 'sia':
      return SiaStorage.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'RemoteStorage',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$RemoteStorage {
  String get url => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, String username) calDav,
    required TResult Function(String url, String username) webDav,
    required TResult Function(String url, String username) sia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
    TResult? Function(String url, String username)? webDav,
    TResult? Function(String url, String username)? sia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    TResult Function(String url, String username)? webDav,
    TResult Function(String url, String username)? sia,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CalDavStorage value) calDav,
    required TResult Function(WebDavStorage value) webDav,
    required TResult Function(SiaStorage value) sia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
    TResult? Function(WebDavStorage value)? webDav,
    TResult? Function(SiaStorage value)? sia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    TResult Function(WebDavStorage value)? webDav,
    TResult Function(SiaStorage value)? sia,
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
  const _$CalDavStorage(
      {required this.url, required this.username, final String? $type})
      : $type = $type ?? 'calDav',
        super._();

  factory _$CalDavStorage.fromJson(Map<String, dynamic> json) =>
      _$$CalDavStorageFromJson(json);

  @override
  final String url;
  @override
  final String username;

  @JsonKey(name: 'runtimeType')
  final String $type;

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
    required TResult Function(String url, String username) webDav,
    required TResult Function(String url, String username) sia,
  }) {
    return calDav(url, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
    TResult? Function(String url, String username)? webDav,
    TResult? Function(String url, String username)? sia,
  }) {
    return calDav?.call(url, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    TResult Function(String url, String username)? webDav,
    TResult Function(String url, String username)? sia,
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
    required TResult Function(WebDavStorage value) webDav,
    required TResult Function(SiaStorage value) sia,
  }) {
    return calDav(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
    TResult? Function(WebDavStorage value)? webDav,
    TResult? Function(SiaStorage value)? sia,
  }) {
    return calDav?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    TResult Function(WebDavStorage value)? webDav,
    TResult Function(SiaStorage value)? sia,
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

/// @nodoc
abstract class _$$WebDavStorageCopyWith<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  factory _$$WebDavStorageCopyWith(
          _$WebDavStorage value, $Res Function(_$WebDavStorage) then) =
      __$$WebDavStorageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String username});
}

/// @nodoc
class __$$WebDavStorageCopyWithImpl<$Res>
    extends _$RemoteStorageCopyWithImpl<$Res, _$WebDavStorage>
    implements _$$WebDavStorageCopyWith<$Res> {
  __$$WebDavStorageCopyWithImpl(
      _$WebDavStorage _value, $Res Function(_$WebDavStorage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? username = null,
  }) {
    return _then(_$WebDavStorage(
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
class _$WebDavStorage extends WebDavStorage {
  const _$WebDavStorage(
      {required this.url, required this.username, final String? $type})
      : $type = $type ?? 'webDav',
        super._();

  factory _$WebDavStorage.fromJson(Map<String, dynamic> json) =>
      _$$WebDavStorageFromJson(json);

  @override
  final String url;
  @override
  final String username;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RemoteStorage.webDav(url: $url, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebDavStorage &&
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
  _$$WebDavStorageCopyWith<_$WebDavStorage> get copyWith =>
      __$$WebDavStorageCopyWithImpl<_$WebDavStorage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, String username) calDav,
    required TResult Function(String url, String username) webDav,
    required TResult Function(String url, String username) sia,
  }) {
    return webDav(url, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
    TResult? Function(String url, String username)? webDav,
    TResult? Function(String url, String username)? sia,
  }) {
    return webDav?.call(url, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    TResult Function(String url, String username)? webDav,
    TResult Function(String url, String username)? sia,
    required TResult orElse(),
  }) {
    if (webDav != null) {
      return webDav(url, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CalDavStorage value) calDav,
    required TResult Function(WebDavStorage value) webDav,
    required TResult Function(SiaStorage value) sia,
  }) {
    return webDav(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
    TResult? Function(WebDavStorage value)? webDav,
    TResult? Function(SiaStorage value)? sia,
  }) {
    return webDav?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    TResult Function(WebDavStorage value)? webDav,
    TResult Function(SiaStorage value)? sia,
    required TResult orElse(),
  }) {
    if (webDav != null) {
      return webDav(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WebDavStorageToJson(
      this,
    );
  }
}

abstract class WebDavStorage extends RemoteStorage {
  const factory WebDavStorage(
      {required final String url,
      required final String username}) = _$WebDavStorage;
  const WebDavStorage._() : super._();

  factory WebDavStorage.fromJson(Map<String, dynamic> json) =
      _$WebDavStorage.fromJson;

  @override
  String get url;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$WebDavStorageCopyWith<_$WebDavStorage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SiaStorageCopyWith<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  factory _$$SiaStorageCopyWith(
          _$SiaStorage value, $Res Function(_$SiaStorage) then) =
      __$$SiaStorageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String username});
}

/// @nodoc
class __$$SiaStorageCopyWithImpl<$Res>
    extends _$RemoteStorageCopyWithImpl<$Res, _$SiaStorage>
    implements _$$SiaStorageCopyWith<$Res> {
  __$$SiaStorageCopyWithImpl(
      _$SiaStorage _value, $Res Function(_$SiaStorage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? username = null,
  }) {
    return _then(_$SiaStorage(
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
class _$SiaStorage extends SiaStorage {
  const _$SiaStorage(
      {required this.url, required this.username, final String? $type})
      : $type = $type ?? 'sia',
        super._();

  factory _$SiaStorage.fromJson(Map<String, dynamic> json) =>
      _$$SiaStorageFromJson(json);

  @override
  final String url;
  @override
  final String username;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RemoteStorage.sia(url: $url, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SiaStorage &&
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
  _$$SiaStorageCopyWith<_$SiaStorage> get copyWith =>
      __$$SiaStorageCopyWithImpl<_$SiaStorage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, String username) calDav,
    required TResult Function(String url, String username) webDav,
    required TResult Function(String url, String username) sia,
  }) {
    return sia(url, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
    TResult? Function(String url, String username)? webDav,
    TResult? Function(String url, String username)? sia,
  }) {
    return sia?.call(url, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    TResult Function(String url, String username)? webDav,
    TResult Function(String url, String username)? sia,
    required TResult orElse(),
  }) {
    if (sia != null) {
      return sia(url, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CalDavStorage value) calDav,
    required TResult Function(WebDavStorage value) webDav,
    required TResult Function(SiaStorage value) sia,
  }) {
    return sia(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
    TResult? Function(WebDavStorage value)? webDav,
    TResult? Function(SiaStorage value)? sia,
  }) {
    return sia?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    TResult Function(WebDavStorage value)? webDav,
    TResult Function(SiaStorage value)? sia,
    required TResult orElse(),
  }) {
    if (sia != null) {
      return sia(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SiaStorageToJson(
      this,
    );
  }
}

abstract class SiaStorage extends RemoteStorage {
  const factory SiaStorage(
      {required final String url,
      required final String username}) = _$SiaStorage;
  const SiaStorage._() : super._();

  factory SiaStorage.fromJson(Map<String, dynamic> json) =
      _$SiaStorage.fromJson;

  @override
  String get url;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$SiaStorageCopyWith<_$SiaStorage> get copyWith =>
      throw _privateConstructorUsedError;
}
