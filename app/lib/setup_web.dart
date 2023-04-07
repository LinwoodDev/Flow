// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'api/storage/sources.dart';
import 'cubits/settings.dart';
import 'setup.dart' as general_setup;

Future<void> setup(
    SettingsCubit settingsCubit, SourcesService sourcesService) async {
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  await general_setup.setup(settingsCubit, sourcesService);
}
