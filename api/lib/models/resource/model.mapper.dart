// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class ResourceMapper extends ClassMapperBase<Resource> {
  ResourceMapper._();

  static ResourceMapper? _instance;
  static ResourceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ResourceMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Resource';

  static Uint8List? _$id(Resource v) => v.id;
  static const Field<Resource, Uint8List> _f$id = Field('id', _$id, opt: true);
  static String _$name(Resource v) => v.name;
  static const Field<Resource, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(Resource v) => v.description;
  static const Field<Resource, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static String _$address(Resource v) => v.address;
  static const Field<Resource, String> _f$address =
      Field('address', _$address, opt: true, def: '');

  @override
  final MappableFields<Resource> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #address: _f$address,
  };

  static Resource _instantiate(DecodingData data) {
    return Resource(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        address: data.dec(_f$address));
  }

  @override
  final Function instantiate = _instantiate;

  static Resource fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Resource>(map);
  }

  static Resource fromJson(String json) {
    return ensureInitialized().decodeJson<Resource>(json);
  }
}

mixin ResourceMappable {
  String toJson() {
    return ResourceMapper.ensureInitialized()
        .encodeJson<Resource>(this as Resource);
  }

  Map<String, dynamic> toMap() {
    return ResourceMapper.ensureInitialized()
        .encodeMap<Resource>(this as Resource);
  }

  ResourceCopyWith<Resource, Resource, Resource> get copyWith =>
      _ResourceCopyWithImpl<Resource, Resource>(
          this as Resource, $identity, $identity);
  @override
  String toString() {
    return ResourceMapper.ensureInitialized().stringifyValue(this as Resource);
  }

  @override
  bool operator ==(Object other) {
    return ResourceMapper.ensureInitialized()
        .equalsValue(this as Resource, other);
  }

  @override
  int get hashCode {
    return ResourceMapper.ensureInitialized().hashValue(this as Resource);
  }
}

extension ResourceValueCopy<$R, $Out> on ObjectCopyWith<$R, Resource, $Out> {
  ResourceCopyWith<$R, Resource, $Out> get $asResource =>
      $base.as((v, t, t2) => _ResourceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ResourceCopyWith<$R, $In extends Resource, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Uint8List? id, String? name, String? description, String? address});
  ResourceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ResourceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Resource, $Out>
    implements ResourceCopyWith<$R, Resource, $Out> {
  _ResourceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Resource> $mapper =
      ResourceMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? name,
          String? description,
          String? address}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (address != null) #address: address
      }));
  @override
  Resource $make(CopyWithData data) => Resource(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      address: data.get(#address, or: $value.address));

  @override
  ResourceCopyWith<$R2, Resource, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ResourceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
