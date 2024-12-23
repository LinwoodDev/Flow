import 'package:dart_mappable/dart_mappable.dart';

import '../api/storage/remote/model.dart';

part 'config.mapper.dart';

@MappableClass()
class ConfigFile with ConfigFileMappable {
  final List<RemoteStorage>? remotes;
  final Map<String, String> passwords;

  const ConfigFile({
    this.remotes,
    this.passwords = const {},
  });
}
