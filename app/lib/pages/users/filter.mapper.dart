// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'filter.dart';

class UserFilterMapper extends ClassMapperBase<UserFilter> {
  UserFilterMapper._();

  static UserFilterMapper? _instance;
  static UserFilterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserFilterMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserFilter';

  static String? _$source(UserFilter v) => v.source;
  static const Field<UserFilter, String> _f$source =
      Field('source', _$source, opt: true);
  static Uint8List? _$group(UserFilter v) => v.group;
  static const Field<UserFilter, Uint8List> _f$group =
      Field('group', _$group, opt: true);

  @override
  final MappableFields<UserFilter> fields = const {
    #source: _f$source,
    #group: _f$group,
  };

  static UserFilter _instantiate(DecodingData data) {
    return UserFilter(source: data.dec(_f$source), group: data.dec(_f$group));
  }

  @override
  final Function instantiate = _instantiate;

  static UserFilter fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserFilter>(map);
  }

  static UserFilter fromJson(String json) {
    return ensureInitialized().decodeJson<UserFilter>(json);
  }
}

mixin UserFilterMappable {
  String toJson() {
    return UserFilterMapper.ensureInitialized()
        .encodeJson<UserFilter>(this as UserFilter);
  }

  Map<String, dynamic> toMap() {
    return UserFilterMapper.ensureInitialized()
        .encodeMap<UserFilter>(this as UserFilter);
  }

  UserFilterCopyWith<UserFilter, UserFilter, UserFilter> get copyWith =>
      _UserFilterCopyWithImpl<UserFilter, UserFilter>(
          this as UserFilter, $identity, $identity);
  @override
  String toString() {
    return UserFilterMapper.ensureInitialized()
        .stringifyValue(this as UserFilter);
  }

  @override
  bool operator ==(Object other) {
    return UserFilterMapper.ensureInitialized()
        .equalsValue(this as UserFilter, other);
  }

  @override
  int get hashCode {
    return UserFilterMapper.ensureInitialized().hashValue(this as UserFilter);
  }
}

extension UserFilterValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserFilter, $Out> {
  UserFilterCopyWith<$R, UserFilter, $Out> get $asUserFilter =>
      $base.as((v, t, t2) => _UserFilterCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserFilterCopyWith<$R, $In extends UserFilter, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? source, Uint8List? group});
  UserFilterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserFilterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserFilter, $Out>
    implements UserFilterCopyWith<$R, UserFilter, $Out> {
  _UserFilterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserFilter> $mapper =
      UserFilterMapper.ensureInitialized();
  @override
  $R call({Object? source = $none, Object? group = $none}) =>
      $apply(FieldCopyWithData({
        if (source != $none) #source: source,
        if (group != $none) #group: group
      }));
  @override
  UserFilter $make(CopyWithData data) => UserFilter(
      source: data.get(#source, or: $value.source),
      group: data.get(#group, or: $value.group));

  @override
  UserFilterCopyWith<$R2, UserFilter, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserFilterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
