import 'dart:convert';

import 'package:flutter/services.dart';

import 'api/storage/sources.dart';
import 'cubits/settings.dart';
import 'models/config.dart';

Future<void> setup(
    SettingsCubit settingsCubit, SourcesService sourcesService) async {
  final data = await rootBundle.loadString('data/config.json');
  final config = ConfigFile.fromJson(json.decode(data));
  if (config.remotes != null) {
    await sourcesService.clearRemotes();
    for (final remote in config.remotes!) {
      await sourcesService.addRemote(
        remote,
        config.passwords[remote.toFilename()] ?? '',
      );
    }
  }
}
