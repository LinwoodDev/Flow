// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'request.dart';

class APIRequestMapper extends ClassMapperBase<APIRequest> {
  APIRequestMapper._();

  static APIRequestMapper? _instance;
  static APIRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = APIRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'APIRequest';

  static int _$id(APIRequest v) => v.id;
  static const Field<APIRequest, int> _f$id =
      Field('id', _$id, opt: true, def: -1);
  static String _$method(APIRequest v) => v.method;
  static const Field<APIRequest, String> _f$method = Field('method', _$method);
  static String _$authority(APIRequest v) => v.authority;
  static const Field<APIRequest, String> _f$authority =
      Field('authority', _$authority);
  static String _$path(APIRequest v) => v.path;
  static const Field<APIRequest, String> _f$path = Field('path', _$path);
  static Map<String, String> _$headers(APIRequest v) => v.headers;
  static const Field<APIRequest, Map<String, String>> _f$headers =
      Field('headers', _$headers, opt: true, def: const {});
  static String _$body(APIRequest v) => v.body;
  static const Field<APIRequest, String> _f$body =
      Field('body', _$body, opt: true, def: '');

  @override
  final MappableFields<APIRequest> fields = const {
    #id: _f$id,
    #method: _f$method,
    #authority: _f$authority,
    #path: _f$path,
    #headers: _f$headers,
    #body: _f$body,
  };

  static APIRequest _instantiate(DecodingData data) {
    return APIRequest(
        id: data.dec(_f$id),
        method: data.dec(_f$method),
        authority: data.dec(_f$authority),
        path: data.dec(_f$path),
        headers: data.dec(_f$headers),
        body: data.dec(_f$body));
  }

  @override
  final Function instantiate = _instantiate;

  static APIRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<APIRequest>(map);
  }

  static APIRequest fromJson(String json) {
    return ensureInitialized().decodeJson<APIRequest>(json);
  }
}

mixin APIRequestMappable {
  String toJson() {
    return APIRequestMapper.ensureInitialized()
        .encodeJson<APIRequest>(this as APIRequest);
  }

  Map<String, dynamic> toMap() {
    return APIRequestMapper.ensureInitialized()
        .encodeMap<APIRequest>(this as APIRequest);
  }

  APIRequestCopyWith<APIRequest, APIRequest, APIRequest> get copyWith =>
      _APIRequestCopyWithImpl<APIRequest, APIRequest>(
          this as APIRequest, $identity, $identity);
  @override
  String toString() {
    return APIRequestMapper.ensureInitialized()
        .stringifyValue(this as APIRequest);
  }

  @override
  bool operator ==(Object other) {
    return APIRequestMapper.ensureInitialized()
        .equalsValue(this as APIRequest, other);
  }

  @override
  int get hashCode {
    return APIRequestMapper.ensureInitialized().hashValue(this as APIRequest);
  }
}

extension APIRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, APIRequest, $Out> {
  APIRequestCopyWith<$R, APIRequest, $Out> get $asAPIRequest =>
      $base.as((v, t, t2) => _APIRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class APIRequestCopyWith<$R, $In extends APIRequest, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get headers;
  $R call(
      {int? id,
      String? method,
      String? authority,
      String? path,
      Map<String, String>? headers,
      String? body});
  APIRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _APIRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, APIRequest, $Out>
    implements APIRequestCopyWith<$R, APIRequest, $Out> {
  _APIRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<APIRequest> $mapper =
      APIRequestMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get headers => MapCopyWith($value.headers,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(headers: v));
  @override
  $R call(
          {int? id,
          String? method,
          String? authority,
          String? path,
          Map<String, String>? headers,
          String? body}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (method != null) #method: method,
        if (authority != null) #authority: authority,
        if (path != null) #path: path,
        if (headers != null) #headers: headers,
        if (body != null) #body: body
      }));
  @override
  APIRequest $make(CopyWithData data) => APIRequest(
      id: data.get(#id, or: $value.id),
      method: data.get(#method, or: $value.method),
      authority: data.get(#authority, or: $value.authority),
      path: data.get(#path, or: $value.path),
      headers: data.get(#headers, or: $value.headers),
      body: data.get(#body, or: $value.body));

  @override
  APIRequestCopyWith<$R2, APIRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _APIRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
