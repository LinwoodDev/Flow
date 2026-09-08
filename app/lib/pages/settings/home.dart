import 'package:flow/cubits/settings.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:settings_leap/settings_leap.dart';

import 'general.dart';
import 'data.dart';
import 'personalization.dart';

final settingsTree = SettingsLeapTree<FlowSettings>({
  'general': generalSettingsPage,
  'data': dataSettingsPage,
  'personalization': personalizationSettingsPage,
});

class SettingsPage extends StatelessWidget {
  final bool isDialog;
  const SettingsPage({super.key, this.isDialog = false});

  @override
  Widget build(BuildContext context) {
    final child = BlocBuilder<SettingsCubit, FlowSettings>(
      builder: (context, state) => SettingsLeapView<FlowSettings>(
        tree: settingsTree,
        state: state,
        title: (context) => AppLocalizations.of(context).settings,
        searchHint: (context) => AppLocalizations.of(context).search,
        isDialog: isDialog,
        cardMargin: settingsCardMargin,
        cardPadding: settingsCardPadding,
        sectionTitlePadding: settingsCardTitlePadding,
        compactWidth: isDialog ? 800 : LeapBreakpoints.compact,
        onOpenPage: isDialog
            ? null
            : (context, id, page, focusedId) {
                context.go(
                  '/settings/${id.replaceAll('.', '/')}',
                  extra: focusedId,
                );
              },
        closeButton: IconButton.outlined(
          icon: const PhosphorIcon(PhosphorIconsLight.x),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
        ),
      ),
    );

    if (isDialog) return child;

    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, FlowSettings>(
        title: Text(AppLocalizations.of(context).settings),
        inView: isDialog,
      ),
      body: child,
    );
  }
}

class SettingsDetailsPage extends StatelessWidget {
  final String id;
  final String? focusedId;
  final bool inView;

  const SettingsDetailsPage({
    super.key,
    required this.id,
    this.focusedId,
    this.inView = false,
  });

  @override
  Widget build(BuildContext context) {
    final page = settingsTree.pageById(id);
    if (page == null) {
      return Scaffold(
        appBar: WindowTitleBar<SettingsCubit, FlowSettings>(
          title: Text(AppLocalizations.of(context).settings),
          inView: inView,
        ),
        body: Center(child: Text(AppLocalizations.of(context).error)),
      );
    }
    return BlocBuilder<SettingsCubit, FlowSettings>(
      builder: (context, state) => SettingsLeapGeneratedPage<FlowSettings>(
        page: page,
        pageId: id,
        focusedId: focusedId,
        state: state,
        inView: inView,
        cardMargin: settingsCardMargin,
        cardPadding: settingsCardPadding,
        sectionTitlePadding: settingsCardTitlePadding,
      ),
    );
  }
}

PreferredSizeWidget flowSettingsAppBar(
  BuildContext context,
  FlowSettings state,
  bool inView,
  Widget title,
  List<Widget>? actions,
) => WindowTitleBar<SettingsCubit, FlowSettings>(
  title: title,
  backgroundColor: inView ? Colors.transparent : null,
  inView: inView,
  actions: actions ?? const [],
);
