import 'package:freezed_annotation/freezed_annotation.dart';

import '../api/storage/remote/model.dart';

part 'config.g.dart';
part 'config.freezed.dart';

@freezed
class ConfigFile with _$ConfigFile {
  const factory ConfigFile({
    List<RemoteStorage>? remotes,
    @Default({}) Map<String, String> passwords,
  }) = _ConfigFile;

  factory ConfigFile.fromJson(Map<String, dynamic> json) =>
      _$ConfigFileFromJson(json);
}
