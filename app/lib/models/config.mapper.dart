// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'config.dart';

class ConfigFileMapper extends ClassMapperBase<ConfigFile> {
  ConfigFileMapper._();

  static ConfigFileMapper? _instance;
  static ConfigFileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigFileMapper._());
      RemoteStorageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ConfigFile';

  static List<RemoteStorage>? _$remotes(ConfigFile v) => v.remotes;
  static const Field<ConfigFile, List<RemoteStorage>> _f$remotes =
      Field('remotes', _$remotes, opt: true);
  static Map<String, String> _$passwords(ConfigFile v) => v.passwords;
  static const Field<ConfigFile, Map<String, String>> _f$passwords =
      Field('passwords', _$passwords, opt: true, def: const {});

  @override
  final MappableFields<ConfigFile> fields = const {
    #remotes: _f$remotes,
    #passwords: _f$passwords,
  };

  static ConfigFile _instantiate(DecodingData data) {
    return ConfigFile(
        remotes: data.dec(_f$remotes), passwords: data.dec(_f$passwords));
  }

  @override
  final Function instantiate = _instantiate;

  static ConfigFile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConfigFile>(map);
  }

  static ConfigFile fromJson(String json) {
    return ensureInitialized().decodeJson<ConfigFile>(json);
  }
}

mixin ConfigFileMappable {
  String toJson() {
    return ConfigFileMapper.ensureInitialized()
        .encodeJson<ConfigFile>(this as ConfigFile);
  }

  Map<String, dynamic> toMap() {
    return ConfigFileMapper.ensureInitialized()
        .encodeMap<ConfigFile>(this as ConfigFile);
  }

  ConfigFileCopyWith<ConfigFile, ConfigFile, ConfigFile> get copyWith =>
      _ConfigFileCopyWithImpl<ConfigFile, ConfigFile>(
          this as ConfigFile, $identity, $identity);
  @override
  String toString() {
    return ConfigFileMapper.ensureInitialized()
        .stringifyValue(this as ConfigFile);
  }

  @override
  bool operator ==(Object other) {
    return ConfigFileMapper.ensureInitialized()
        .equalsValue(this as ConfigFile, other);
  }

  @override
  int get hashCode {
    return ConfigFileMapper.ensureInitialized().hashValue(this as ConfigFile);
  }
}

extension ConfigFileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ConfigFile, $Out> {
  ConfigFileCopyWith<$R, ConfigFile, $Out> get $asConfigFile =>
      $base.as((v, t, t2) => _ConfigFileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ConfigFileCopyWith<$R, $In extends ConfigFile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, RemoteStorage,
      ObjectCopyWith<$R, RemoteStorage, RemoteStorage>>? get remotes;
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get passwords;
  $R call({List<RemoteStorage>? remotes, Map<String, String>? passwords});
  ConfigFileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ConfigFileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ConfigFile, $Out>
    implements ConfigFileCopyWith<$R, ConfigFile, $Out> {
  _ConfigFileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConfigFile> $mapper =
      ConfigFileMapper.ensureInitialized();
  @override
  ListCopyWith<$R, RemoteStorage,
          ObjectCopyWith<$R, RemoteStorage, RemoteStorage>>?
      get remotes => $value.remotes != null
          ? ListCopyWith(
              $value.remotes!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(remotes: v))
          : null;
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get passwords => MapCopyWith($value.passwords,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(passwords: v));
  @override
  $R call({Object? remotes = $none, Map<String, String>? passwords}) =>
      $apply(FieldCopyWithData({
        if (remotes != $none) #remotes: remotes,
        if (passwords != null) #passwords: passwords
      }));
  @override
  ConfigFile $make(CopyWithData data) => ConfigFile(
      remotes: data.get(#remotes, or: $value.remotes),
      passwords: data.get(#passwords, or: $value.passwords));

  @override
  ConfigFileCopyWith<$R2, ConfigFile, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ConfigFileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
