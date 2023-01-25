import 'dart:io';

import 'package:flow/cubits/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:shared/helpers/string.dart';
import 'package:flow/helpers/theme_mode.dart';
import 'package:flow/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';

class PersonalizationSettingsView extends StatelessWidget {
  const PersonalizationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, FlowSettings>(
        builder: (context, state) => Column(
              children: [
                Text(AppLocalizations.of(context).personalization,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 32),
                ListTile(
                  title: Text(AppLocalizations.of(context).design),
                  leading: const Icon(Icons.palette_outlined),
                  subtitle: Text(state.design.isEmpty
                      ? AppLocalizations.of(context).classic
                      : state.design.toDisplayString()),
                  onTap: () async {
                    final cubit = context.read<SettingsCubit>();
                    final design = await showModalBottomSheet<String>(
                        context: context,
                        builder: (context) => Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Text(
                                    AppLocalizations.of(context).design,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                      AppLocalizations.of(context).classic),
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
                                ),
                              ],
                            )));
                    if (design != null) cubit.setDesign(design);
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).theme),
                  leading: Icon(state.themeMode.icon),
                  subtitle: Text(state.themeMode.getDisplayString(context)),
                  onTap: () async {
                    final cubit = context.read<SettingsCubit>();

                    final theme = await showModalBottomSheet<ThemeMode>(
                        context: context,
                        builder: (context) => Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Text(
                                    AppLocalizations.of(context).theme,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ...ThemeMode.values.map((e) => ListTile(
                                      title: Text(e.getDisplayString(context)),
                                      selected: state.themeMode == e,
                                      leading: Icon(e.icon),
                                      onTap: () {
                                        Navigator.of(context).pop(e);
                                      },
                                    )),
                              ],
                            )));
                    if (theme != null) cubit.setThemeMode(theme);
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).language),
                  leading: const Icon(Icons.translate_outlined),
                  onTap: () {},
                ),
                if (!kIsWeb &&
                    (Platform.isWindows ||
                        Platform.isLinux ||
                        Platform.isMacOS))
                  BlocBuilder<SettingsCubit, FlowSettings>(
                      buildWhen: (previous, current) =>
                          previous.nativeTitleBar != current.nativeTitleBar,
                      builder: (context, state) {
                        return CheckboxListTile(
                          title:
                              Text(AppLocalizations.of(context).nativeTitleBar),
                          value: state.nativeTitleBar,
                          onChanged: (value) {
                            context
                                .read<SettingsCubit>()
                                .setNativeTitleBar(value ?? false);
                            windowManager.setTitleBarStyle(value ?? false
                                ? TitleBarStyle.normal
                                : TitleBarStyle.hidden);
                          },
                        );
                      }),
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
