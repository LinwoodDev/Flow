import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ThemeModeHelper on ThemeMode {
  IconData get icon {
    switch (this) {
      case ThemeMode.light:
        return Icons.light_mode_outlined;
      case ThemeMode.dark:
        return Icons.dark_mode_outlined;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  String getDisplayString(BuildContext context) {
    switch (this) {
      case ThemeMode.light:
        return AppLocalizations.of(context).light;
      case ThemeMode.dark:
        return AppLocalizations.of(context).dark;
      case ThemeMode.system:
        return AppLocalizations.of(context).systemDefault;
    }
  }
}
