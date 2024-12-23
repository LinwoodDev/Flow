// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class PlaceMapper extends ClassMapperBase<Place> {
  PlaceMapper._();

  static PlaceMapper? _instance;
  static PlaceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlaceMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Place';

  static Uint8List? _$id(Place v) => v.id;
  static const Field<Place, Uint8List> _f$id = Field('id', _$id, opt: true);
  static String _$name(Place v) => v.name;
  static const Field<Place, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(Place v) => v.description;
  static const Field<Place, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static String _$address(Place v) => v.address;
  static const Field<Place, String> _f$address =
      Field('address', _$address, opt: true, def: '');

  @override
  final MappableFields<Place> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #address: _f$address,
  };

  static Place _instantiate(DecodingData data) {
    return Place(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        address: data.dec(_f$address));
  }

  @override
  final Function instantiate = _instantiate;

  static Place fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Place>(map);
  }

  static Place fromJson(String json) {
    return ensureInitialized().decodeJson<Place>(json);
  }
}

mixin PlaceMappable {
  String toJson() {
    return PlaceMapper.ensureInitialized().encodeJson<Place>(this as Place);
  }

  Map<String, dynamic> toMap() {
    return PlaceMapper.ensureInitialized().encodeMap<Place>(this as Place);
  }

  PlaceCopyWith<Place, Place, Place> get copyWith =>
      _PlaceCopyWithImpl(this as Place, $identity, $identity);
  @override
  String toString() {
    return PlaceMapper.ensureInitialized().stringifyValue(this as Place);
  }

  @override
  bool operator ==(Object other) {
    return PlaceMapper.ensureInitialized().equalsValue(this as Place, other);
  }

  @override
  int get hashCode {
    return PlaceMapper.ensureInitialized().hashValue(this as Place);
  }
}

extension PlaceValueCopy<$R, $Out> on ObjectCopyWith<$R, Place, $Out> {
  PlaceCopyWith<$R, Place, $Out> get $asPlace =>
      $base.as((v, t, t2) => _PlaceCopyWithImpl(v, t, t2));
}

abstract class PlaceCopyWith<$R, $In extends Place, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Uint8List? id, String? name, String? description, String? address});
  PlaceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlaceCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Place, $Out>
    implements PlaceCopyWith<$R, Place, $Out> {
  _PlaceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Place> $mapper = PlaceMapper.ensureInitialized();
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
  Place $make(CopyWithData data) => Place(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      address: data.get(#address, or: $value.address));

  @override
  PlaceCopyWith<$R2, Place, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PlaceCopyWithImpl($value, $cast, t);
}
