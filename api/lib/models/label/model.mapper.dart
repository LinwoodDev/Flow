// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class LabelMapper extends ClassMapperBase<Label> {
  LabelMapper._();

  static LabelMapper? _instance;
  static LabelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LabelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Label';

  static Uint8List? _$id(Label v) => v.id;
  static const Field<Label, Uint8List> _f$id = Field('id', _$id, opt: true);
  static String _$name(Label v) => v.name;
  static const Field<Label, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(Label v) => v.description;
  static const Field<Label, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static SRGBColor _$color(Label v) => v.color;
  static const Field<Label, SRGBColor> _f$color =
      Field('color', _$color, opt: true, def: SRGBColor.black);

  @override
  final MappableFields<Label> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #color: _f$color,
  };

  static Label _instantiate(DecodingData data) {
    return Label(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        color: data.dec(_f$color));
  }

  @override
  final Function instantiate = _instantiate;

  static Label fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Label>(map);
  }

  static Label fromJson(String json) {
    return ensureInitialized().decodeJson<Label>(json);
  }
}

mixin LabelMappable {
  String toJson() {
    return LabelMapper.ensureInitialized().encodeJson<Label>(this as Label);
  }

  Map<String, dynamic> toMap() {
    return LabelMapper.ensureInitialized().encodeMap<Label>(this as Label);
  }

  LabelCopyWith<Label, Label, Label> get copyWith =>
      _LabelCopyWithImpl<Label, Label>(this as Label, $identity, $identity);
  @override
  String toString() {
    return LabelMapper.ensureInitialized().stringifyValue(this as Label);
  }

  @override
  bool operator ==(Object other) {
    return LabelMapper.ensureInitialized().equalsValue(this as Label, other);
  }

  @override
  int get hashCode {
    return LabelMapper.ensureInitialized().hashValue(this as Label);
  }
}

extension LabelValueCopy<$R, $Out> on ObjectCopyWith<$R, Label, $Out> {
  LabelCopyWith<$R, Label, $Out> get $asLabel =>
      $base.as((v, t, t2) => _LabelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LabelCopyWith<$R, $In extends Label, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Uint8List? id, String? name, String? description, SRGBColor? color});
  LabelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LabelCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Label, $Out>
    implements LabelCopyWith<$R, Label, $Out> {
  _LabelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Label> $mapper = LabelMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? name,
          String? description,
          SRGBColor? color}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (color != null) #color: color
      }));
  @override
  Label $make(CopyWithData data) => Label(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      color: data.get(#color, or: $value.color));

  @override
  LabelCopyWith<$R2, Label, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LabelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
