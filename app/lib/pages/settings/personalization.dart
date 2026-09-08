import 'dart:io';

import 'package:flow/cubits/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:intl/intl.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow/helpers/theme_mode.dart';
import 'package:flow/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';

import 'package:settings_leap/settings_leap.dart';

import 'home.dart';

String _getLocaleName(BuildContext context, String locale) => locale.isNotEmpty
    ? LocaleNames.of(context)?.nameOf(locale.replaceAll('-', '_')) ?? locale
    : AppLocalizations.of(context).systemLocale;

String _getDensityName(BuildContext context, ThemeDensity density) =>
    switch (density) {
      ThemeDensity.system => AppLocalizations.of(context).systemTheme,
      ThemeDensity.maximize => LeapLocalizations.of(context).maximize,
      ThemeDensity.desktop => AppLocalizations.of(context).desktop,
      ThemeDensity.compact => AppLocalizations.of(context).compact,
      ThemeDensity.standard => AppLocalizations.of(context).standard,
      ThemeDensity.comfortable => AppLocalizations.of(context).comfortable,
    };

final personalizationSettingsPage = SettingsLeapPage<FlowSettings>(
  displayName: (context) => AppLocalizations.of(context).personalization,
  icon: PhosphorIconsLight.monitor,
  appBarBuilder: flowSettingsAppBar,
  sections: {
    'appearance': SettingsLeapSection(
      settings: [
        SettingsLeapEnumSetting<FlowSettings, String>(
          id: 'design',
          displayName: (context) => AppLocalizations.of(context).design,
          icon: PhosphorIconsLight.palette,
          values: ['', ...getThemes()],
          read: (state) => state.design,
          write: (context, value) =>
              context.read<SettingsCubit>().changeDesign(value),
          valueLabel: (context, value) => value.isEmpty
              ? AppLocalizations.of(context).systemDefault
              : value.toDisplayString(),
          valueLeadingBuilder: (context, value) =>
              _ThemeBox(theme: getThemeData(value, false)),
        ),
        SettingsLeapEnumSetting<FlowSettings, ThemeMode>(
          id: 'themeMode',
          displayName: (context) => AppLocalizations.of(context).theme,
          icon: PhosphorIconsLight.eye,
          values: ThemeMode.values,
          read: (state) => state.themeMode,
          write: (context, value) =>
              context.read<SettingsCubit>().changeThemeMode(value),
          valueLabel: (context, value) => value.getDisplayString(context),
          valueLeadingBuilder: (context, value) => PhosphorIcon(value.icon),
        ),
        SettingsLeapEnumSetting<FlowSettings, String>(
          id: 'locale',
          displayName: (context) => AppLocalizations.of(context).language,
          icon: PhosphorIconsLight.translate,
          values: [
            '',
            ...AppLocalizations.supportedLocales.map((e) => e.toString()),
          ],
          read: (state) => state.locale,
          write: (context, value) =>
              context.read<SettingsCubit>().changeLocale(value),
          valueLabel: (context, value) => _getLocaleName(context, value),
        ),
        SettingsLeapEnumSetting<FlowSettings, ThemeDensity>(
          id: 'density',
          displayName: (context) => AppLocalizations.of(context).density,
          icon: PhosphorIconsLight.gridNine,
          values: ThemeDensity.values,
          read: (state) => state.density,
          write: (context, value) =>
              context.read<SettingsCubit>().changeDensity(value),
          valueLabel: (context, value) => _getDensityName(context, value),
        ),
        SettingsLeapEnumSetting<FlowSettings, int>(
          id: 'startOfWeek',
          displayName: (context) => AppLocalizations.of(context).startOfWeek,
          icon: PhosphorIconsLight.calendar,
          values: List.generate(7, (index) => index),
          read: (state) => state.startOfWeek,
          write: (context, value) =>
              context.read<SettingsCubit>().changeStartOfWeek(value),
          valueLabel: (context, value) => DateFormat.EEEE(
            Localizations.localeOf(context).languageCode,
          ).format(DateTime.now().startOfWeek.add(Duration(days: value))),
        ),
        SettingsLeapBoolSetting(
          id: 'nativeTitleBar',
          displayName: (context) => AppLocalizations.of(context).nativeTitleBar,
          icon: PhosphorIconsLight.textT,
          enabled: (context, state) =>
              !kIsWeb &&
              (Platform.isWindows || Platform.isLinux || Platform.isMacOS),
          read: (state) => state.nativeTitleBar,
          write: (context, value) {
            context.read<SettingsCubit>().changeNativeTitleBar(value);
            windowManager.setTitleBarStyle(
              value ? TitleBarStyle.normal : TitleBarStyle.hidden,
            );
          },
        ),
        SettingsLeapBoolSetting(
          id: 'highContrast',
          displayName: (context) => AppLocalizations.of(context).highContrast,
          icon: PhosphorIconsLight.circleHalf,
          read: (state) => state.highContrast,
          write: (context, value) =>
              context.read<SettingsCubit>().changeHighContrast(value),
        ),
      ],
    ),
  },
);

class _ThemeBox extends StatelessWidget {
  final ThemeData theme;
  static const double size = 12;
  const _ThemeBox({required this.theme});

  @override
  Widget build(BuildContext context) {
    // 2x2 grid of colors
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(size),
                ),
              ),
            ),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(size),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(size),
                ),
              ),
            ),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(size),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
