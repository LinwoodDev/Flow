import 'dart:io';

import 'package:flow/api/settings.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:window_manager/window_manager.dart';

import '../main.dart';

typedef _NavigationItem = ({
  String title,
  IconGetter icon,
  String link,
  VoidCallback? onTap,
});

List<_NavigationItem?> _getNavigationItems(BuildContext context) => [
  (
    title: AppLocalizations.of(context).dashboard,
    icon: PhosphorIcons.squaresFour,
    link: "/",
    onTap: null,
  ),
  (
    title: AppLocalizations.of(context).calendar,
    icon: PhosphorIcons.calendar,
    link: "/calendar",
    onTap: null,
  ),
  (
    title: AppLocalizations.of(context).alarm,
    icon: PhosphorIcons.alarm,
    link: "/alarm",
    onTap: null,
  ),
  null,
  (
    title: AppLocalizations.of(context).events,
    icon: PhosphorIcons.calendarBlank,
    link: "/events",
    onTap: null,
  ),
  (
    title: AppLocalizations.of(context).notes,
    icon: PhosphorIcons.listChecks,
    link: "/notes",
    onTap: null,
  ),
  (
    title: AppLocalizations.of(context).resources,
    icon: PhosphorIcons.cube,
    link: "/resources",
    onTap: null,
  ),
  (
    title: AppLocalizations.of(context).groups,
    icon: PhosphorIcons.usersThree,
    link: "/groups",
    onTap: null,
  ),
  (
    title: AppLocalizations.of(context).users,
    icon: PhosphorIcons.users,
    link: "/users",
    onTap: null,
  ),
];

List<_NavigationItem?> _getSecondaryItems(BuildContext context) => [
  null,
  (
    title: AppLocalizations.of(context).sources,
    icon: PhosphorIcons.hardDrives,
    link: "/sources",
    onTap: null,
  ),
  (
    title: AppLocalizations.of(context).settings,
    icon: PhosphorIcons.gear,
    link: "/settings",
    onTap: () => openSettings(context),
  ),
];

const _drawerWidth = 280.0;
const _navigationBreakpoint = 840.0;

class FlowRootNavigation extends StatelessWidget {
  final Widget child;
  const FlowRootNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < _navigationBreakpoint;
          final reduceMotion = MediaQuery.disableAnimationsOf(context);
          return Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(child: child),
              AnimatedContainer(
                duration: reduceMotion
                    ? Duration.zero
                    : const Duration(milliseconds: 250),
                width: isMobile ? 0 : _drawerWidth,
                curve: Curves.easeInOut,
                child: const ClipRect(
                  child: OverflowBox(
                    maxWidth: _drawerWidth,
                    minWidth: _drawerWidth,
                    alignment: Alignment.centerRight,
                    child: _FlowDrawer(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NativeWindowArea extends StatelessWidget {
  final Widget child;

  const _NativeWindowArea({required this.child});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: GestureDetector(
        onSecondaryTap: () => windowManager.popUpWindowMenu(),
        child: child,
      ),
    );
  }
}

class FlowNavigation extends StatelessWidget {
  final String? title;
  final Widget body;
  final PreferredSizeWidget? bottom;
  final Widget? endDrawer;
  final List<Widget> actions;
  final FloatingActionButton? floatingActionButton;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  FlowNavigation({
    super.key,
    required this.title,
    required this.body,
    this.bottom,
    this.endDrawer,
    this.actions = const [],
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < _navigationBreakpoint;
        final showEndDrawerButton = isMobile && endDrawer != null;
        const drawer = _FlowDrawer();
        PreferredSizeWidget appBar =
            WindowTitleBar<SettingsCubit, FlowSettings>(
              bottom: bottom,
              title: title == null ? null : Text(title!),
              actions: [
                ...actions,
                if (showEndDrawerButton)
                  IconButton(
                    tooltip: AppLocalizations.of(context).filter,
                    icon: const PhosphorIcon(PhosphorIconsLight.list),
                    onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                  ),
              ],
            );

        if (!kIsWeb &&
            (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
          final child = appBar;
          appBar = PreferredSize(
            preferredSize: appBar.preferredSize,
            child: BlocBuilder<SettingsCubit, FlowSettings>(
              buildWhen: (previous, current) =>
                  previous.nativeTitleBar != current.nativeTitleBar,
              builder: (context, state) => state.nativeTitleBar
                  ? child
                  : _NativeWindowArea(child: child),
            ),
          );
        }

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Scaffold(
                  appBar: title == null ? null : appBar,
                  key: _scaffoldKey,
                  drawer: isMobile
                      ? const SafeArea(
                          child: Drawer(width: _drawerWidth, child: drawer),
                        )
                      : null,
                  endDrawer: isMobile && endDrawer != null
                      ? SafeArea(child: Drawer(child: endDrawer))
                      : null,
                  body: Row(
                    children: [
                      Expanded(child: body),
                      if (!isMobile && endDrawer != null)
                        SizedBox(width: 275, child: endDrawer!),
                    ],
                  ),
                  floatingActionButton: floatingActionButton,
                ),
              ),
            ].reversed.toList(),
          ),
        );
      },
    );
  }
}

class _FlowDrawer extends StatelessWidget {
  const _FlowDrawer();

  Widget _getItem(
    BuildContext context,
    String location,
    _NavigationItem? item,
  ) {
    var currentSelected = false;
    final link = item?.link;
    if (link == "/") {
      currentSelected = location == link;
    } else if (link != null) {
      currentSelected = location.startsWith(link);
    }
    return item == null
        ? const Divider(indent: 16, endIndent: 16)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: ListTile(
              style: ListTileStyle.drawer,
              title: Text(
                item.title,
                style: TextStyle(
                  fontWeight: currentSelected
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
              leading: Icon(
                item.icon(
                  currentSelected
                      ? PhosphorIconsStyle.fill
                      : PhosphorIconsStyle.light,
                ),
              ),
              onTap: item.onTap ?? () => GoRouter.of(context).go(item.link),
              selected: currentSelected,
              selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
              selectedTileColor: currentSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceContainerLow,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: colorScheme.outlineVariant.withAlpha(120),
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<SettingsCubit, FlowSettings>(
                        builder: (context, state) {
                          final widget = AppBar(
                            backgroundColor: Colors.transparent,
                            leading: Padding(
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "images/logo.png",
                                  height: 36,
                                  width: 36,
                                ),
                              ),
                            ),
                            leadingWidth: 52,
                            title: const Text(
                              applicationName,
                              textAlign: TextAlign.center,
                            ),
                            centerTitle: true,
                            automaticallyImplyLeading: false,
                            actions: [
                              IconButton(
                                tooltip: AppLocalizations.of(context).sources,
                                icon: const PhosphorIcon(
                                  PhosphorIconsLight.funnel,
                                ),
                                onPressed: () => _showSources(context),
                              ),
                            ],
                            titleTextStyle: Theme.of(
                              context,
                            ).textTheme.titleMedium,
                          );
                          if (!kIsWeb &&
                              (Platform.isWindows ||
                                  Platform.isLinux ||
                                  Platform.isMacOS) &&
                              !state.nativeTitleBar) {
                            return _NativeWindowArea(child: widget);
                          }
                          return widget;
                        },
                      ),
                      Column(
                        children: _getNavigationItems(
                          context,
                        ).map((e) => _getItem(context, location, e)).toList(),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _getSecondaryItems(
                          context,
                        ).map((e) => _getItem(context, location, e)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> _showSources(BuildContext context) {
    final cubit = context.read<FlowCubit>();
    final sources = cubit.getSources();
    final currents = List<String>.from(cubit.getCurrentSources());
    final remotes = context.read<SettingsCubit>().state.remotes;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(AppLocalizations.of(context).sources),
        content: StatefulBuilder(
          builder: (context, setState) {
            bool? allSources;
            if (currents.length >= sources.length) {
              allSources = true;
            } else if (currents.isEmpty) {
              allSources = false;
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context).allSources),
                  value: allSources,
                  tristate: true,
                  onChanged: (value) => setState(() {
                    if (value ?? false) {
                      currents.clear();
                      currents.addAll(sources);
                    } else {
                      currents.clear();
                    }
                  }),
                ),
                const Divider(),
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context).local),
                  value: currents.contains(""),
                  onChanged: (value) => setState(
                    () => (value ?? false)
                        ? currents.add("")
                        : currents.remove(""),
                  ),
                ),
                ...remotes.map(
                  (e) => CheckboxListTile(
                    title: Text(e.uri.host),
                    subtitle: Text(e.username),
                    value: currents.contains(e.identifier),
                    onChanged: (value) => setState(
                      () => (value ?? false)
                          ? currents.add(e.identifier)
                          : currents.remove(e.identifier),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context).cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text(AppLocalizations.of(context).save),
            onPressed: () {
              context.read<FlowCubit>().setSources(currents);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
