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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';

class PersonalizationSettingsView extends StatelessWidget {
  const PersonalizationSettingsView({super.key});

  String _getLocalizedName(BuildContext context, String name) {
    return LocaleNames.of(context)?.nameOf(name) ??
        AppLocalizations.of(context).systemDefault;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final weekDayFormatter = DateFormat.EEEE(locale);
    final startOfWeek = DateTime.now().nextStartOfWeek;
    String getWeekDay(int day) {
      return weekDayFormatter.format(startOfWeek.add(Duration(days: day)));
    }

    return BlocBuilder<SettingsCubit, FlowSettings>(
        builder: (context, state) => Column(
              children: [
                Text(AppLocalizations.of(context).personalization,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 32),
                ListTile(
                  title: Text(AppLocalizations.of(context).design),
                  leading: const PhosphorIcon(PhosphorIconsLight.palette),
                  subtitle: Text(state.design.isEmpty
                      ? AppLocalizations.of(context).classic
                      : state.design.toDisplayString()),
                  onTap: () async {
                    final cubit = context.read<SettingsCubit>();
                    final design = await showLeapBottomSheet<String>(
                        context: context,
                        title: AppLocalizations.of(context).design,
                        childrenBuilder: (context) => [
                              ListTile(
                                title:
                                    Text(AppLocalizations.of(context).classic),
                                leading:
                                    _ThemeBox(theme: getThemeData('', false)),
                                onTap: () => Navigator.pop(context, ''),
                                selected: state.design.isEmpty,
                              ),
                              ...getThemes().map(
                                (e) {
                                  final theme = getThemeData(e, false);
                                  return ListTile(
                                      title: Text(e.toDisplayString()),
                                      selected: e == state.design,
                                      onTap: () async {
                                        Navigator.of(context).pop(e);
                                      },
                                      leading: _ThemeBox(
                                        theme: theme,
                                      ));
                                },
                              )
                            ]);
                    if (design != null) cubit.setDesign(design);
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).theme),
                  leading: PhosphorIcon(state.themeMode.icon),
                  subtitle: Text(state.themeMode.getDisplayString(context)),
                  onTap: () async {
                    final cubit = context.read<SettingsCubit>();

                    final theme = await showLeapBottomSheet<ThemeMode>(
                        context: context,
                        title: AppLocalizations.of(context).theme,
                        childrenBuilder: (context) => ThemeMode.values
                            .map((e) => ListTile(
                                  title: Text(e.getDisplayString(context)),
                                  selected: state.themeMode == e,
                                  leading: PhosphorIcon(e.icon),
                                  onTap: () {
                                    Navigator.of(context).pop(e);
                                  },
                                ))
                            .toList());
                    if (theme != null) cubit.setThemeMode(theme);
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).language),
                  leading: const PhosphorIcon(PhosphorIconsLight.translate),
                  subtitle: Text(_getLocalizedName(context, state.locale)),
                  onTap: () async {
                    final cubit = context.read<SettingsCubit>();

                    final locale = await showLeapBottomSheet<String>(
                      context: context,
                      title: AppLocalizations.of(context).language,
                      childrenBuilder: (context) => [
                        ListTile(
                          title: Text(_getLocalizedName(context, '')),
                          selected: state.locale.isEmpty,
                          onTap: () {
                            Navigator.of(context).pop('');
                          },
                        ),
                        ...AppLocalizations.supportedLocales
                            .map((e) => e.toString())
                            .map((e) => ListTile(
                                  title: Text(_getLocalizedName(context, e)),
                                  selected: state.locale == e,
                                  onTap: () {
                                    Navigator.of(context).pop(e);
                                  },
                                )),
                      ],
                    );
                    if (locale != null) cubit.setLocale(locale);
                  },
                ),
                if (!kIsWeb &&
                    (Platform.isWindows ||
                        Platform.isLinux ||
                        Platform.isMacOS))
                  BlocBuilder<SettingsCubit, FlowSettings>(
                      buildWhen: (previous, current) =>
                          previous.nativeTitleBar != current.nativeTitleBar,
                      builder: (context, state) {
                        return SwitchListTile(
                          title:
                              Text(AppLocalizations.of(context).nativeTitleBar),
                          value: state.nativeTitleBar,
                          secondary:
                              const PhosphorIcon(PhosphorIconsLight.textT),
                          onChanged: (value) {
                            context
                                .read<SettingsCubit>()
                                .setNativeTitleBar(value);
                            windowManager.setTitleBarStyle(value
                                ? TitleBarStyle.normal
                                : TitleBarStyle.hidden);
                          },
                        );
                      }),
                const VerticalDivider(),
                ListTile(
                  title: Text(AppLocalizations.of(context).startOfWeek),
                  leading: const PhosphorIcon(PhosphorIconsLight.calendar),
                  subtitle: Text(getWeekDay(state.startOfWeek)),
                  onTap: () => showLeapBottomSheet(
                    context: context,
                    title: AppLocalizations.of(context).startOfWeek,
                    childrenBuilder: (context) => List.generate(
                      7,
                      (index) => ListTile(
                        title: Text(getWeekDay(index)),
                        selected: state.startOfWeek == index,
                        onTap: () {
                          context.read<SettingsCubit>().setStartOfWeek(index);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }
}

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
        Row(mainAxisSize: MainAxisSize.min, children: [
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
        ]),
        Row(mainAxisSize: MainAxisSize.min, children: [
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
        ]),
      ],
    );
  }
}
