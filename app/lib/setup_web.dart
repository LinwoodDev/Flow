// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'cubits/settings.dart';
import 'setup.dart' as general_setup;

Future<void> setup(SettingsCubit settingsCubit) async {
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  await general_setup.setup(settingsCubit);
}
