import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ThemeModeHelper on ThemeMode {
  PhosphorIconData get icon {
    switch (this) {
      case ThemeMode.light:
        return PhosphorIconsLight.sun;
      case ThemeMode.dark:
        return PhosphorIconsLight.moon;
      case ThemeMode.system:
        return PhosphorIconsLight.power;
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
