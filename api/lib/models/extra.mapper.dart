// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'extra.dart';

class ExtraPropertiesMapper extends ClassMapperBase<ExtraProperties> {
  ExtraPropertiesMapper._();

  static ExtraPropertiesMapper? _instance;
  static ExtraPropertiesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExtraPropertiesMapper._());
      CalDavExtraPropertiesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExtraProperties';

  @override
  final MappableFields<ExtraProperties> fields = const {};

  static ExtraProperties _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('ExtraProperties');
  }

  @override
  final Function instantiate = _instantiate;

  static ExtraProperties fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExtraProperties>(map);
  }

  static ExtraProperties fromJson(String json) {
    return ensureInitialized().decodeJson<ExtraProperties>(json);
  }
}

mixin ExtraPropertiesMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ExtraPropertiesCopyWith<ExtraProperties, ExtraProperties, ExtraProperties>
      get copyWith;
}

abstract class ExtraPropertiesCopyWith<$R, $In extends ExtraProperties, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  ExtraPropertiesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class CalDavExtraPropertiesMapper
    extends ClassMapperBase<CalDavExtraProperties> {
  CalDavExtraPropertiesMapper._();

  static CalDavExtraPropertiesMapper? _instance;
  static CalDavExtraPropertiesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CalDavExtraPropertiesMapper._());
      ExtraPropertiesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CalDavExtraProperties';

  static String _$etag(CalDavExtraProperties v) => v.etag;
  static const Field<CalDavExtraProperties, String> _f$etag =
      Field('etag', _$etag);
  static String _$path(CalDavExtraProperties v) => v.path;
  static const Field<CalDavExtraProperties, String> _f$path =
      Field('path', _$path);

  @override
  final MappableFields<CalDavExtraProperties> fields = const {
    #etag: _f$etag,
    #path: _f$path,
  };

  static CalDavExtraProperties _instantiate(DecodingData data) {
    return CalDavExtraProperties(
        etag: data.dec(_f$etag), path: data.dec(_f$path));
  }

  @override
  final Function instantiate = _instantiate;

  static CalDavExtraProperties fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CalDavExtraProperties>(map);
  }

  static CalDavExtraProperties fromJson(String json) {
    return ensureInitialized().decodeJson<CalDavExtraProperties>(json);
  }
}

mixin CalDavExtraPropertiesMappable {
  String toJson() {
    return CalDavExtraPropertiesMapper.ensureInitialized()
        .encodeJson<CalDavExtraProperties>(this as CalDavExtraProperties);
  }

  Map<String, dynamic> toMap() {
    return CalDavExtraPropertiesMapper.ensureInitialized()
        .encodeMap<CalDavExtraProperties>(this as CalDavExtraProperties);
  }

  CalDavExtraPropertiesCopyWith<CalDavExtraProperties, CalDavExtraProperties,
      CalDavExtraProperties> get copyWith => _CalDavExtraPropertiesCopyWithImpl<
          CalDavExtraProperties, CalDavExtraProperties>(
      this as CalDavExtraProperties, $identity, $identity);
  @override
  String toString() {
    return CalDavExtraPropertiesMapper.ensureInitialized()
        .stringifyValue(this as CalDavExtraProperties);
  }

  @override
  bool operator ==(Object other) {
    return CalDavExtraPropertiesMapper.ensureInitialized()
        .equalsValue(this as CalDavExtraProperties, other);
  }

  @override
  int get hashCode {
    return CalDavExtraPropertiesMapper.ensureInitialized()
        .hashValue(this as CalDavExtraProperties);
  }
}

extension CalDavExtraPropertiesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CalDavExtraProperties, $Out> {
  CalDavExtraPropertiesCopyWith<$R, CalDavExtraProperties, $Out>
      get $asCalDavExtraProperties => $base.as(
          (v, t, t2) => _CalDavExtraPropertiesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CalDavExtraPropertiesCopyWith<
    $R,
    $In extends CalDavExtraProperties,
    $Out> implements ExtraPropertiesCopyWith<$R, $In, $Out> {
  @override
  $R call({String? etag, String? path});
  CalDavExtraPropertiesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CalDavExtraPropertiesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CalDavExtraProperties, $Out>
    implements CalDavExtraPropertiesCopyWith<$R, CalDavExtraProperties, $Out> {
  _CalDavExtraPropertiesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CalDavExtraProperties> $mapper =
      CalDavExtraPropertiesMapper.ensureInitialized();
  @override
  $R call({String? etag, String? path}) => $apply(FieldCopyWithData(
      {if (etag != null) #etag: etag, if (path != null) #path: path}));
  @override
  CalDavExtraProperties $make(CopyWithData data) => CalDavExtraProperties(
      etag: data.get(#etag, or: $value.etag),
      path: data.get(#path, or: $value.path));

  @override
  CalDavExtraPropertiesCopyWith<$R2, CalDavExtraProperties, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CalDavExtraPropertiesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
