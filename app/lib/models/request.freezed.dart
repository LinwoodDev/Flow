// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

APIRequest _$APIRequestFromJson(Map<String, dynamic> json) {
  return _APIRequest.fromJson(json);
}

/// @nodoc
mixin _$APIRequest {
  int get id => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get authority => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  Map<String, String> get headers => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $APIRequestCopyWith<APIRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $APIRequestCopyWith<$Res> {
  factory $APIRequestCopyWith(
          APIRequest value, $Res Function(APIRequest) then) =
      _$APIRequestCopyWithImpl<$Res, APIRequest>;
  @useResult
  $Res call(
      {int id,
      String method,
      String authority,
      String path,
      Map<String, String> headers,
      String body});
}

/// @nodoc
class _$APIRequestCopyWithImpl<$Res, $Val extends APIRequest>
    implements $APIRequestCopyWith<$Res> {
  _$APIRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? method = null,
    Object? authority = null,
    Object? path = null,
    Object? headers = null,
    Object? body = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      authority: null == authority
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      headers: null == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$APIRequestImplCopyWith<$Res>
    implements $APIRequestCopyWith<$Res> {
  factory _$$APIRequestImplCopyWith(
          _$APIRequestImpl value, $Res Function(_$APIRequestImpl) then) =
      __$$APIRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String method,
      String authority,
      String path,
      Map<String, String> headers,
      String body});
}

/// @nodoc
class __$$APIRequestImplCopyWithImpl<$Res>
    extends _$APIRequestCopyWithImpl<$Res, _$APIRequestImpl>
    implements _$$APIRequestImplCopyWith<$Res> {
  __$$APIRequestImplCopyWithImpl(
      _$APIRequestImpl _value, $Res Function(_$APIRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? method = null,
    Object? authority = null,
    Object? path = null,
    Object? headers = null,
    Object? body = null,
  }) {
    return _then(_$APIRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      authority: null == authority
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$APIRequestImpl extends _APIRequest {
  const _$APIRequestImpl(
      {this.id = -1,
      required this.method,
      required this.authority,
      required this.path,
      final Map<String, String> headers = const {},
      this.body = ''})
      : _headers = headers,
        super._();

  factory _$APIRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$APIRequestImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final String method;
  @override
  final String authority;
  @override
  final String path;
  final Map<String, String> _headers;
  @override
  @JsonKey()
  Map<String, String> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
  }

  @override
  @JsonKey()
  final String body;

  @override
  String toString() {
    return 'APIRequest(id: $id, method: $method, authority: $authority, path: $path, headers: $headers, body: $body)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$APIRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.authority, authority) ||
                other.authority == authority) &&
            (identical(other.path, path) || other.path == path) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, method, authority, path,
      const DeepCollectionEquality().hash(_headers), body);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$APIRequestImplCopyWith<_$APIRequestImpl> get copyWith =>
      __$$APIRequestImplCopyWithImpl<_$APIRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$APIRequestImplToJson(
      this,
    );
  }
}

abstract class _APIRequest extends APIRequest {
  const factory _APIRequest(
      {final int id,
      required final String method,
      required final String authority,
      required final String path,
      final Map<String, String> headers,
      final String body}) = _$APIRequestImpl;
  const _APIRequest._() : super._();

  factory _APIRequest.fromJson(Map<String, dynamic> json) =
      _$APIRequestImpl.fromJson;

  @override
  int get id;
  @override
  String get method;
  @override
  String get authority;
  @override
  String get path;
  @override
  Map<String, String> get headers;
  @override
  String get body;
  @override
  @JsonKey(ignore: true)
  _$$APIRequestImplCopyWith<_$APIRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
