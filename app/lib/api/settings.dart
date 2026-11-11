import 'package:flow/pages/settings/home.dart';
import 'package:material_ui/material_ui.dart';
import 'package:settings_leap/settings_leap.dart';

Future<void> openSettings(BuildContext context) => showSettingsLeapDialog<void>(
  context: context,
  child: const SettingsPage(isDialog: true),
);
