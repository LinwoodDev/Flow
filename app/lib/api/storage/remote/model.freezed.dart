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
    case 'iCal':
      return ICalStorage.fromJson(json);
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
    required TResult Function(String url, String username) iCal,
    required TResult Function(String url, String username) webDav,
    required TResult Function(String url, String username) sia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
    TResult? Function(String url, String username)? iCal,
    TResult? Function(String url, String username)? webDav,
    TResult? Function(String url, String username)? sia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    TResult Function(String url, String username)? iCal,
    TResult Function(String url, String username)? webDav,
    TResult Function(String url, String username)? sia,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CalDavStorage value) calDav,
    required TResult Function(ICalStorage value) iCal,
    required TResult Function(WebDavStorage value) webDav,
    required TResult Function(SiaStorage value) sia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
    TResult? Function(ICalStorage value)? iCal,
    TResult? Function(WebDavStorage value)? webDav,
    TResult? Function(SiaStorage value)? sia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    TResult Function(ICalStorage value)? iCal,
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
abstract class _$$CalDavStorageImplCopyWith<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  factory _$$CalDavStorageImplCopyWith(
          _$CalDavStorageImpl value, $Res Function(_$CalDavStorageImpl) then) =
      __$$CalDavStorageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String username});
}

/// @nodoc
class __$$CalDavStorageImplCopyWithImpl<$Res>
    extends _$RemoteStorageCopyWithImpl<$Res, _$CalDavStorageImpl>
    implements _$$CalDavStorageImplCopyWith<$Res> {
  __$$CalDavStorageImplCopyWithImpl(
      _$CalDavStorageImpl _value, $Res Function(_$CalDavStorageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? username = null,
  }) {
    return _then(_$CalDavStorageImpl(
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
class _$CalDavStorageImpl extends CalDavStorage {
  const _$CalDavStorageImpl(
      {required this.url, required this.username, final String? $type})
      : $type = $type ?? 'calDav',
        super._();

  factory _$CalDavStorageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalDavStorageImplFromJson(json);

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
            other is _$CalDavStorageImpl &&
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
  _$$CalDavStorageImplCopyWith<_$CalDavStorageImpl> get copyWith =>
      __$$CalDavStorageImplCopyWithImpl<_$CalDavStorageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, String username) calDav,
    required TResult Function(String url, String username) iCal,
    required TResult Function(String url, String username) webDav,
    required TResult Function(String url, String username) sia,
  }) {
    return calDav(url, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
    TResult? Function(String url, String username)? iCal,
    TResult? Function(String url, String username)? webDav,
    TResult? Function(String url, String username)? sia,
  }) {
    return calDav?.call(url, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    TResult Function(String url, String username)? iCal,
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
    required TResult Function(ICalStorage value) iCal,
    required TResult Function(WebDavStorage value) webDav,
    required TResult Function(SiaStorage value) sia,
  }) {
    return calDav(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
    TResult? Function(ICalStorage value)? iCal,
    TResult? Function(WebDavStorage value)? webDav,
    TResult? Function(SiaStorage value)? sia,
  }) {
    return calDav?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    TResult Function(ICalStorage value)? iCal,
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
    return _$$CalDavStorageImplToJson(
      this,
    );
  }
}

abstract class CalDavStorage extends RemoteStorage {
  const factory CalDavStorage(
      {required final String url,
      required final String username}) = _$CalDavStorageImpl;
  const CalDavStorage._() : super._();

  factory CalDavStorage.fromJson(Map<String, dynamic> json) =
      _$CalDavStorageImpl.fromJson;

  @override
  String get url;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$CalDavStorageImplCopyWith<_$CalDavStorageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ICalStorageImplCopyWith<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  factory _$$ICalStorageImplCopyWith(
          _$ICalStorageImpl value, $Res Function(_$ICalStorageImpl) then) =
      __$$ICalStorageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String username});
}

/// @nodoc
class __$$ICalStorageImplCopyWithImpl<$Res>
    extends _$RemoteStorageCopyWithImpl<$Res, _$ICalStorageImpl>
    implements _$$ICalStorageImplCopyWith<$Res> {
  __$$ICalStorageImplCopyWithImpl(
      _$ICalStorageImpl _value, $Res Function(_$ICalStorageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? username = null,
  }) {
    return _then(_$ICalStorageImpl(
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
class _$ICalStorageImpl extends ICalStorage {
  const _$ICalStorageImpl(
      {required this.url, required this.username, final String? $type})
      : $type = $type ?? 'iCal',
        super._();

  factory _$ICalStorageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ICalStorageImplFromJson(json);

  @override
  final String url;
  @override
  final String username;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RemoteStorage.iCal(url: $url, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ICalStorageImpl &&
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
  _$$ICalStorageImplCopyWith<_$ICalStorageImpl> get copyWith =>
      __$$ICalStorageImplCopyWithImpl<_$ICalStorageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, String username) calDav,
    required TResult Function(String url, String username) iCal,
    required TResult Function(String url, String username) webDav,
    required TResult Function(String url, String username) sia,
  }) {
    return iCal(url, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
    TResult? Function(String url, String username)? iCal,
    TResult? Function(String url, String username)? webDav,
    TResult? Function(String url, String username)? sia,
  }) {
    return iCal?.call(url, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    TResult Function(String url, String username)? iCal,
    TResult Function(String url, String username)? webDav,
    TResult Function(String url, String username)? sia,
    required TResult orElse(),
  }) {
    if (iCal != null) {
      return iCal(url, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CalDavStorage value) calDav,
    required TResult Function(ICalStorage value) iCal,
    required TResult Function(WebDavStorage value) webDav,
    required TResult Function(SiaStorage value) sia,
  }) {
    return iCal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
    TResult? Function(ICalStorage value)? iCal,
    TResult? Function(WebDavStorage value)? webDav,
    TResult? Function(SiaStorage value)? sia,
  }) {
    return iCal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    TResult Function(ICalStorage value)? iCal,
    TResult Function(WebDavStorage value)? webDav,
    TResult Function(SiaStorage value)? sia,
    required TResult orElse(),
  }) {
    if (iCal != null) {
      return iCal(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ICalStorageImplToJson(
      this,
    );
  }
}

abstract class ICalStorage extends RemoteStorage {
  const factory ICalStorage(
      {required final String url,
      required final String username}) = _$ICalStorageImpl;
  const ICalStorage._() : super._();

  factory ICalStorage.fromJson(Map<String, dynamic> json) =
      _$ICalStorageImpl.fromJson;

  @override
  String get url;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$ICalStorageImplCopyWith<_$ICalStorageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebDavStorageImplCopyWith<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  factory _$$WebDavStorageImplCopyWith(
          _$WebDavStorageImpl value, $Res Function(_$WebDavStorageImpl) then) =
      __$$WebDavStorageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String username});
}

/// @nodoc
class __$$WebDavStorageImplCopyWithImpl<$Res>
    extends _$RemoteStorageCopyWithImpl<$Res, _$WebDavStorageImpl>
    implements _$$WebDavStorageImplCopyWith<$Res> {
  __$$WebDavStorageImplCopyWithImpl(
      _$WebDavStorageImpl _value, $Res Function(_$WebDavStorageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? username = null,
  }) {
    return _then(_$WebDavStorageImpl(
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
class _$WebDavStorageImpl extends WebDavStorage {
  const _$WebDavStorageImpl(
      {required this.url, required this.username, final String? $type})
      : $type = $type ?? 'webDav',
        super._();

  factory _$WebDavStorageImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebDavStorageImplFromJson(json);

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
            other is _$WebDavStorageImpl &&
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
  _$$WebDavStorageImplCopyWith<_$WebDavStorageImpl> get copyWith =>
      __$$WebDavStorageImplCopyWithImpl<_$WebDavStorageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, String username) calDav,
    required TResult Function(String url, String username) iCal,
    required TResult Function(String url, String username) webDav,
    required TResult Function(String url, String username) sia,
  }) {
    return webDav(url, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
    TResult? Function(String url, String username)? iCal,
    TResult? Function(String url, String username)? webDav,
    TResult? Function(String url, String username)? sia,
  }) {
    return webDav?.call(url, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    TResult Function(String url, String username)? iCal,
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
    required TResult Function(ICalStorage value) iCal,
    required TResult Function(WebDavStorage value) webDav,
    required TResult Function(SiaStorage value) sia,
  }) {
    return webDav(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
    TResult? Function(ICalStorage value)? iCal,
    TResult? Function(WebDavStorage value)? webDav,
    TResult? Function(SiaStorage value)? sia,
  }) {
    return webDav?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    TResult Function(ICalStorage value)? iCal,
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
    return _$$WebDavStorageImplToJson(
      this,
    );
  }
}

abstract class WebDavStorage extends RemoteStorage {
  const factory WebDavStorage(
      {required final String url,
      required final String username}) = _$WebDavStorageImpl;
  const WebDavStorage._() : super._();

  factory WebDavStorage.fromJson(Map<String, dynamic> json) =
      _$WebDavStorageImpl.fromJson;

  @override
  String get url;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$WebDavStorageImplCopyWith<_$WebDavStorageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SiaStorageImplCopyWith<$Res>
    implements $RemoteStorageCopyWith<$Res> {
  factory _$$SiaStorageImplCopyWith(
          _$SiaStorageImpl value, $Res Function(_$SiaStorageImpl) then) =
      __$$SiaStorageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String username});
}

/// @nodoc
class __$$SiaStorageImplCopyWithImpl<$Res>
    extends _$RemoteStorageCopyWithImpl<$Res, _$SiaStorageImpl>
    implements _$$SiaStorageImplCopyWith<$Res> {
  __$$SiaStorageImplCopyWithImpl(
      _$SiaStorageImpl _value, $Res Function(_$SiaStorageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? username = null,
  }) {
    return _then(_$SiaStorageImpl(
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
class _$SiaStorageImpl extends SiaStorage {
  const _$SiaStorageImpl(
      {required this.url, required this.username, final String? $type})
      : $type = $type ?? 'sia',
        super._();

  factory _$SiaStorageImpl.fromJson(Map<String, dynamic> json) =>
      _$$SiaStorageImplFromJson(json);

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
            other is _$SiaStorageImpl &&
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
  _$$SiaStorageImplCopyWith<_$SiaStorageImpl> get copyWith =>
      __$$SiaStorageImplCopyWithImpl<_$SiaStorageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, String username) calDav,
    required TResult Function(String url, String username) iCal,
    required TResult Function(String url, String username) webDav,
    required TResult Function(String url, String username) sia,
  }) {
    return sia(url, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, String username)? calDav,
    TResult? Function(String url, String username)? iCal,
    TResult? Function(String url, String username)? webDav,
    TResult? Function(String url, String username)? sia,
  }) {
    return sia?.call(url, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, String username)? calDav,
    TResult Function(String url, String username)? iCal,
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
    required TResult Function(ICalStorage value) iCal,
    required TResult Function(WebDavStorage value) webDav,
    required TResult Function(SiaStorage value) sia,
  }) {
    return sia(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CalDavStorage value)? calDav,
    TResult? Function(ICalStorage value)? iCal,
    TResult? Function(WebDavStorage value)? webDav,
    TResult? Function(SiaStorage value)? sia,
  }) {
    return sia?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CalDavStorage value)? calDav,
    TResult Function(ICalStorage value)? iCal,
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
    return _$$SiaStorageImplToJson(
      this,
    );
  }
}

abstract class SiaStorage extends RemoteStorage {
  const factory SiaStorage(
      {required final String url,
      required final String username}) = _$SiaStorageImpl;
  const SiaStorage._() : super._();

  factory SiaStorage.fromJson(Map<String, dynamic> json) =
      _$SiaStorageImpl.fromJson;

  @override
  String get url;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$SiaStorageImplCopyWith<_$SiaStorageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
