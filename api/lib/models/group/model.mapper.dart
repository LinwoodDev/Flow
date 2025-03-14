// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class GroupMapper extends ClassMapperBase<Group> {
  GroupMapper._();

  static GroupMapper? _instance;
  static GroupMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GroupMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Group';

  static Uint8List? _$id(Group v) => v.id;
  static const Field<Group, Uint8List> _f$id = Field('id', _$id, opt: true);
  static String _$name(Group v) => v.name;
  static const Field<Group, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(Group v) => v.description;
  static const Field<Group, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static Uint8List? _$parentId(Group v) => v.parentId;
  static const Field<Group, Uint8List> _f$parentId =
      Field('parentId', _$parentId, opt: true);

  @override
  final MappableFields<Group> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #parentId: _f$parentId,
  };

  static Group _instantiate(DecodingData data) {
    return Group(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        parentId: data.dec(_f$parentId));
  }

  @override
  final Function instantiate = _instantiate;

  static Group fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Group>(map);
  }

  static Group fromJson(String json) {
    return ensureInitialized().decodeJson<Group>(json);
  }
}

mixin GroupMappable {
  String toJson() {
    return GroupMapper.ensureInitialized().encodeJson<Group>(this as Group);
  }

  Map<String, dynamic> toMap() {
    return GroupMapper.ensureInitialized().encodeMap<Group>(this as Group);
  }

  GroupCopyWith<Group, Group, Group> get copyWith =>
      _GroupCopyWithImpl<Group, Group>(this as Group, $identity, $identity);
  @override
  String toString() {
    return GroupMapper.ensureInitialized().stringifyValue(this as Group);
  }

  @override
  bool operator ==(Object other) {
    return GroupMapper.ensureInitialized().equalsValue(this as Group, other);
  }

  @override
  int get hashCode {
    return GroupMapper.ensureInitialized().hashValue(this as Group);
  }
}

extension GroupValueCopy<$R, $Out> on ObjectCopyWith<$R, Group, $Out> {
  GroupCopyWith<$R, Group, $Out> get $asGroup =>
      $base.as((v, t, t2) => _GroupCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GroupCopyWith<$R, $In extends Group, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {Uint8List? id, String? name, String? description, Uint8List? parentId});
  GroupCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GroupCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Group, $Out>
    implements GroupCopyWith<$R, Group, $Out> {
  _GroupCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Group> $mapper = GroupMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? name,
          String? description,
          Object? parentId = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (parentId != $none) #parentId: parentId
      }));
  @override
  Group $make(CopyWithData data) => Group(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      parentId: data.get(#parentId, or: $value.parentId));

  @override
  GroupCopyWith<$R2, Group, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GroupCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
