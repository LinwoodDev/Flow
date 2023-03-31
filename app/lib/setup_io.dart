import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'cubits/settings.dart';
import 'setup.dart' as general_setup;

Future<void> setup(SettingsCubit settingsCubit) async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    final windowOptions = WindowOptions(
      size: const Size(800, 600),
      minimumSize: const Size(410, 300),
      titleBarStyle: settingsCubit.state.nativeTitleBar
          ? TitleBarStyle.normal
          : TitleBarStyle.hidden,
      title: 'Flow',
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    await general_setup.setup(settingsCubit);
  }
}
