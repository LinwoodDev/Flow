import 'package:flutter/services.dart';

import 'api/storage/sources.dart';
import 'cubits/settings.dart';
import 'setup.dart' as general_setup;

Future<void> setup(
    SettingsCubit settingsCubit, SourcesService sourcesService) async {
  await BrowserContextMenu.disableContextMenu();
  await general_setup.setup(settingsCubit, sourcesService);
}
