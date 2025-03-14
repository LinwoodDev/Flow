// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class RemoteStorageMapper extends ClassMapperBase<RemoteStorage> {
  RemoteStorageMapper._();

  static RemoteStorageMapper? _instance;
  static RemoteStorageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteStorageMapper._());
      CalDavStorageMapper.ensureInitialized();
      ICalStorageMapper.ensureInitialized();
      WebDavStorageMapper.ensureInitialized();
      SiaStorageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteStorage';

  static String _$url(RemoteStorage v) => v.url;
  static const Field<RemoteStorage, String> _f$url = Field('url', _$url);
  static String _$username(RemoteStorage v) => v.username;
  static const Field<RemoteStorage, String> _f$username =
      Field('username', _$username);

  @override
  final MappableFields<RemoteStorage> fields = const {
    #url: _f$url,
    #username: _f$username,
  };

  static RemoteStorage _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('RemoteStorage');
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteStorage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteStorage>(map);
  }

  static RemoteStorage fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteStorage>(json);
  }
}

mixin RemoteStorageMappable {
  String toJson();
  Map<String, dynamic> toMap();
  RemoteStorageCopyWith<RemoteStorage, RemoteStorage, RemoteStorage>
      get copyWith;
}

abstract class RemoteStorageCopyWith<$R, $In extends RemoteStorage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? url, String? username});
  RemoteStorageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class CalDavStorageMapper extends ClassMapperBase<CalDavStorage> {
  CalDavStorageMapper._();

  static CalDavStorageMapper? _instance;
  static CalDavStorageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CalDavStorageMapper._());
      RemoteStorageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CalDavStorage';

  static String _$url(CalDavStorage v) => v.url;
  static const Field<CalDavStorage, String> _f$url = Field('url', _$url);
  static String _$username(CalDavStorage v) => v.username;
  static const Field<CalDavStorage, String> _f$username =
      Field('username', _$username);

  @override
  final MappableFields<CalDavStorage> fields = const {
    #url: _f$url,
    #username: _f$username,
  };

  static CalDavStorage _instantiate(DecodingData data) {
    return CalDavStorage(
        url: data.dec(_f$url), username: data.dec(_f$username));
  }

  @override
  final Function instantiate = _instantiate;

  static CalDavStorage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CalDavStorage>(map);
  }

  static CalDavStorage fromJson(String json) {
    return ensureInitialized().decodeJson<CalDavStorage>(json);
  }
}

mixin CalDavStorageMappable {
  String toJson() {
    return CalDavStorageMapper.ensureInitialized()
        .encodeJson<CalDavStorage>(this as CalDavStorage);
  }

  Map<String, dynamic> toMap() {
    return CalDavStorageMapper.ensureInitialized()
        .encodeMap<CalDavStorage>(this as CalDavStorage);
  }

  CalDavStorageCopyWith<CalDavStorage, CalDavStorage, CalDavStorage>
      get copyWith => _CalDavStorageCopyWithImpl<CalDavStorage, CalDavStorage>(
          this as CalDavStorage, $identity, $identity);
  @override
  String toString() {
    return CalDavStorageMapper.ensureInitialized()
        .stringifyValue(this as CalDavStorage);
  }

  @override
  bool operator ==(Object other) {
    return CalDavStorageMapper.ensureInitialized()
        .equalsValue(this as CalDavStorage, other);
  }

  @override
  int get hashCode {
    return CalDavStorageMapper.ensureInitialized()
        .hashValue(this as CalDavStorage);
  }
}

extension CalDavStorageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CalDavStorage, $Out> {
  CalDavStorageCopyWith<$R, CalDavStorage, $Out> get $asCalDavStorage =>
      $base.as((v, t, t2) => _CalDavStorageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CalDavStorageCopyWith<$R, $In extends CalDavStorage, $Out>
    implements RemoteStorageCopyWith<$R, $In, $Out> {
  @override
  $R call({String? url, String? username});
  CalDavStorageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CalDavStorageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CalDavStorage, $Out>
    implements CalDavStorageCopyWith<$R, CalDavStorage, $Out> {
  _CalDavStorageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CalDavStorage> $mapper =
      CalDavStorageMapper.ensureInitialized();
  @override
  $R call({String? url, String? username}) => $apply(FieldCopyWithData(
      {if (url != null) #url: url, if (username != null) #username: username}));
  @override
  CalDavStorage $make(CopyWithData data) => CalDavStorage(
      url: data.get(#url, or: $value.url),
      username: data.get(#username, or: $value.username));

  @override
  CalDavStorageCopyWith<$R2, CalDavStorage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CalDavStorageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ICalStorageMapper extends ClassMapperBase<ICalStorage> {
  ICalStorageMapper._();

  static ICalStorageMapper? _instance;
  static ICalStorageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ICalStorageMapper._());
      RemoteStorageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ICalStorage';

  static String _$url(ICalStorage v) => v.url;
  static const Field<ICalStorage, String> _f$url = Field('url', _$url);
  static String _$username(ICalStorage v) => v.username;
  static const Field<ICalStorage, String> _f$username =
      Field('username', _$username);

  @override
  final MappableFields<ICalStorage> fields = const {
    #url: _f$url,
    #username: _f$username,
  };

  static ICalStorage _instantiate(DecodingData data) {
    return ICalStorage(url: data.dec(_f$url), username: data.dec(_f$username));
  }

  @override
  final Function instantiate = _instantiate;

  static ICalStorage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ICalStorage>(map);
  }

  static ICalStorage fromJson(String json) {
    return ensureInitialized().decodeJson<ICalStorage>(json);
  }
}

mixin ICalStorageMappable {
  String toJson() {
    return ICalStorageMapper.ensureInitialized()
        .encodeJson<ICalStorage>(this as ICalStorage);
  }

  Map<String, dynamic> toMap() {
    return ICalStorageMapper.ensureInitialized()
        .encodeMap<ICalStorage>(this as ICalStorage);
  }

  ICalStorageCopyWith<ICalStorage, ICalStorage, ICalStorage> get copyWith =>
      _ICalStorageCopyWithImpl<ICalStorage, ICalStorage>(
          this as ICalStorage, $identity, $identity);
  @override
  String toString() {
    return ICalStorageMapper.ensureInitialized()
        .stringifyValue(this as ICalStorage);
  }

  @override
  bool operator ==(Object other) {
    return ICalStorageMapper.ensureInitialized()
        .equalsValue(this as ICalStorage, other);
  }

  @override
  int get hashCode {
    return ICalStorageMapper.ensureInitialized().hashValue(this as ICalStorage);
  }
}

extension ICalStorageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ICalStorage, $Out> {
  ICalStorageCopyWith<$R, ICalStorage, $Out> get $asICalStorage =>
      $base.as((v, t, t2) => _ICalStorageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ICalStorageCopyWith<$R, $In extends ICalStorage, $Out>
    implements RemoteStorageCopyWith<$R, $In, $Out> {
  @override
  $R call({String? url, String? username});
  ICalStorageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ICalStorageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ICalStorage, $Out>
    implements ICalStorageCopyWith<$R, ICalStorage, $Out> {
  _ICalStorageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ICalStorage> $mapper =
      ICalStorageMapper.ensureInitialized();
  @override
  $R call({String? url, String? username}) => $apply(FieldCopyWithData(
      {if (url != null) #url: url, if (username != null) #username: username}));
  @override
  ICalStorage $make(CopyWithData data) => ICalStorage(
      url: data.get(#url, or: $value.url),
      username: data.get(#username, or: $value.username));

  @override
  ICalStorageCopyWith<$R2, ICalStorage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ICalStorageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebDavStorageMapper extends ClassMapperBase<WebDavStorage> {
  WebDavStorageMapper._();

  static WebDavStorageMapper? _instance;
  static WebDavStorageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebDavStorageMapper._());
      RemoteStorageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebDavStorage';

  static String _$url(WebDavStorage v) => v.url;
  static const Field<WebDavStorage, String> _f$url = Field('url', _$url);
  static String _$username(WebDavStorage v) => v.username;
  static const Field<WebDavStorage, String> _f$username =
      Field('username', _$username);

  @override
  final MappableFields<WebDavStorage> fields = const {
    #url: _f$url,
    #username: _f$username,
  };

  static WebDavStorage _instantiate(DecodingData data) {
    return WebDavStorage(
        url: data.dec(_f$url), username: data.dec(_f$username));
  }

  @override
  final Function instantiate = _instantiate;

  static WebDavStorage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebDavStorage>(map);
  }

  static WebDavStorage fromJson(String json) {
    return ensureInitialized().decodeJson<WebDavStorage>(json);
  }
}

mixin WebDavStorageMappable {
  String toJson() {
    return WebDavStorageMapper.ensureInitialized()
        .encodeJson<WebDavStorage>(this as WebDavStorage);
  }

  Map<String, dynamic> toMap() {
    return WebDavStorageMapper.ensureInitialized()
        .encodeMap<WebDavStorage>(this as WebDavStorage);
  }

  WebDavStorageCopyWith<WebDavStorage, WebDavStorage, WebDavStorage>
      get copyWith => _WebDavStorageCopyWithImpl<WebDavStorage, WebDavStorage>(
          this as WebDavStorage, $identity, $identity);
  @override
  String toString() {
    return WebDavStorageMapper.ensureInitialized()
        .stringifyValue(this as WebDavStorage);
  }

  @override
  bool operator ==(Object other) {
    return WebDavStorageMapper.ensureInitialized()
        .equalsValue(this as WebDavStorage, other);
  }

  @override
  int get hashCode {
    return WebDavStorageMapper.ensureInitialized()
        .hashValue(this as WebDavStorage);
  }
}

extension WebDavStorageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebDavStorage, $Out> {
  WebDavStorageCopyWith<$R, WebDavStorage, $Out> get $asWebDavStorage =>
      $base.as((v, t, t2) => _WebDavStorageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebDavStorageCopyWith<$R, $In extends WebDavStorage, $Out>
    implements RemoteStorageCopyWith<$R, $In, $Out> {
  @override
  $R call({String? url, String? username});
  WebDavStorageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebDavStorageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebDavStorage, $Out>
    implements WebDavStorageCopyWith<$R, WebDavStorage, $Out> {
  _WebDavStorageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebDavStorage> $mapper =
      WebDavStorageMapper.ensureInitialized();
  @override
  $R call({String? url, String? username}) => $apply(FieldCopyWithData(
      {if (url != null) #url: url, if (username != null) #username: username}));
  @override
  WebDavStorage $make(CopyWithData data) => WebDavStorage(
      url: data.get(#url, or: $value.url),
      username: data.get(#username, or: $value.username));

  @override
  WebDavStorageCopyWith<$R2, WebDavStorage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WebDavStorageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SiaStorageMapper extends ClassMapperBase<SiaStorage> {
  SiaStorageMapper._();

  static SiaStorageMapper? _instance;
  static SiaStorageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SiaStorageMapper._());
      RemoteStorageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SiaStorage';

  static String _$url(SiaStorage v) => v.url;
  static const Field<SiaStorage, String> _f$url = Field('url', _$url);
  static String _$username(SiaStorage v) => v.username;
  static const Field<SiaStorage, String> _f$username =
      Field('username', _$username);

  @override
  final MappableFields<SiaStorage> fields = const {
    #url: _f$url,
    #username: _f$username,
  };

  static SiaStorage _instantiate(DecodingData data) {
    return SiaStorage(url: data.dec(_f$url), username: data.dec(_f$username));
  }

  @override
  final Function instantiate = _instantiate;

  static SiaStorage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SiaStorage>(map);
  }

  static SiaStorage fromJson(String json) {
    return ensureInitialized().decodeJson<SiaStorage>(json);
  }
}

mixin SiaStorageMappable {
  String toJson() {
    return SiaStorageMapper.ensureInitialized()
        .encodeJson<SiaStorage>(this as SiaStorage);
  }

  Map<String, dynamic> toMap() {
    return SiaStorageMapper.ensureInitialized()
        .encodeMap<SiaStorage>(this as SiaStorage);
  }

  SiaStorageCopyWith<SiaStorage, SiaStorage, SiaStorage> get copyWith =>
      _SiaStorageCopyWithImpl<SiaStorage, SiaStorage>(
          this as SiaStorage, $identity, $identity);
  @override
  String toString() {
    return SiaStorageMapper.ensureInitialized()
        .stringifyValue(this as SiaStorage);
  }

  @override
  bool operator ==(Object other) {
    return SiaStorageMapper.ensureInitialized()
        .equalsValue(this as SiaStorage, other);
  }

  @override
  int get hashCode {
    return SiaStorageMapper.ensureInitialized().hashValue(this as SiaStorage);
  }
}

extension SiaStorageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SiaStorage, $Out> {
  SiaStorageCopyWith<$R, SiaStorage, $Out> get $asSiaStorage =>
      $base.as((v, t, t2) => _SiaStorageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SiaStorageCopyWith<$R, $In extends SiaStorage, $Out>
    implements RemoteStorageCopyWith<$R, $In, $Out> {
  @override
  $R call({String? url, String? username});
  SiaStorageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SiaStorageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SiaStorage, $Out>
    implements SiaStorageCopyWith<$R, SiaStorage, $Out> {
  _SiaStorageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SiaStorage> $mapper =
      SiaStorageMapper.ensureInitialized();
  @override
  $R call({String? url, String? username}) => $apply(FieldCopyWithData(
      {if (url != null) #url: url, if (username != null) #username: username}));
  @override
  SiaStorage $make(CopyWithData data) => SiaStorage(
      url: data.get(#url, or: $value.url),
      username: data.get(#username, or: $value.username));

  @override
  SiaStorageCopyWith<$R2, SiaStorage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SiaStorageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
