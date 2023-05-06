import 'dart:io';

import 'package:flow/cubits/flow.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow/widgets/window_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:window_manager/window_manager.dart';

import '../main.dart';

const kAppBarHeight = 64.0;

List _getNavigationItems(BuildContext context) => [
      {
        "title": AppLocalizations.of(context).dashboard,
        "icon": PhosphorIconsLight.squaresFour,
        "link": "/"
      },
      {
        "title": AppLocalizations.of(context).calendar,
        "icon": PhosphorIconsLight.calendar,
        "link": "/calendar"
      },
      null,
      {
        "title": AppLocalizations.of(context).events,
        "icon": PhosphorIconsLight.calendarBlank,
        "link": "/events"
      },
      {
        "title": AppLocalizations.of(context).notes,
        "icon": PhosphorIconsLight.listChecks,
        "link": "/notes"
      },
      {
        "title": AppLocalizations.of(context).groups,
        "icon": PhosphorIconsLight.fileText,
        "link": "/groups"
      },
      {
        "title": AppLocalizations.of(context).places,
        "icon": PhosphorIconsLight.mapPin,
        "link": "/places"
      },
      {
        "title": AppLocalizations.of(context).users,
        "icon": PhosphorIconsLight.users,
        "link": "/users"
      },
    ];

List _getSecondaryItems(BuildContext context) => [
      null,
      {
        "title": AppLocalizations.of(context).sources,
        "icon": PhosphorIconsLight.hardDrives,
        "link": "/sources"
      },
      {
        "title": AppLocalizations.of(context).settings,
        "icon": PhosphorIconsLight.gear,
        "link": "/settings"
      }
    ];

const _drawerWidth = 250.0;

class FlowRootNavigation extends StatelessWidget {
  final Widget child;
  const FlowRootNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;
          return Row(textDirection: TextDirection.rtl, children: [
            Expanded(
              child: child,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isMobile ? 0 : _drawerWidth,
              curve: Curves.easeInOut,
              child: const ClipRect(
                  child: OverflowBox(
                      maxWidth: _drawerWidth,
                      minWidth: _drawerWidth,
                      alignment: Alignment.centerRight,
                      child: _FlowDrawer())),
            ),
          ]);
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
  final String title;
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
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = MediaQuery.of(context).size.width < 768;
      final showEndDrawerButton = isMobile && endDrawer != null;
      const drawer = _FlowDrawer();
      PreferredSizeWidget appBar = AppBar(
        bottom: bottom,
        title: Text(title),
        toolbarHeight: kAppBarHeight,
        actions: [
          ...actions,
          if (showEndDrawerButton)
            IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.list),
              onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          if (!kIsWeb &&
              (Platform.isWindows || Platform.isLinux || Platform.isMacOS))
            FlowWindowButtons(
              divider: actions.isNotEmpty || showEndDrawerButton,
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
                    : _NativeWindowArea(child: child)));
      }

      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Scaffold(
                appBar: appBar,
                key: _scaffoldKey,
                drawer: isMobile
                    ? const Drawer(
                        width: _drawerWidth,
                        child: drawer,
                      )
                    : null,
                endDrawer: isMobile && endDrawer != null
                    ? Drawer(child: endDrawer)
                    : null,
                body: Row(
                  children: [
                    Expanded(child: body),
                    if (!isMobile && endDrawer != null)
                      SizedBox(
                        width: 250,
                        child: endDrawer!,
                      )
                  ],
                ),
                floatingActionButton: floatingActionButton,
              ),
            ),
          ].reversed.toList(),
        ),
      );
    });
  }
}

class _FlowDrawer extends StatelessWidget {
  const _FlowDrawer();

  Widget _getItem(BuildContext context, String location, Map? map) {
    var currentSelected = false;
    final link = map?["link"] as String?;
    if (map?["link"] == "/") {
      currentSelected = location == map?["link"];
    } else if (link != null) {
      currentSelected = location.startsWith(link);
    }
    return map == null
        ? const Divider()
        : ListTile(
            style: ListTileStyle.drawer,
            title: Text(map['title']),
            leading: PhosphorIcon(map['icon']),
            onTap: () => GoRouter.of(context).go(map['link']),
            selected: currentSelected,
            selectedColor: Theme.of(context).colorScheme.onBackground,
            selectedTileColor: currentSelected
                ? Theme.of(context).colorScheme.primaryContainer.withAlpha(200)
                : null,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    return Material(
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<SettingsCubit, FlowSettings>(
                    builder: (context, state) {
                  final widget = AppBar(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        isNightly ? "images/nightly.png" : "images/logo.png",
                      ),
                    ),
                    toolbarHeight: kAppBarHeight,
                    leadingWidth: 32,
                    title: const Text(
                      shortApplicationName,
                      textAlign: TextAlign.center,
                    ),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                        tooltip: AppLocalizations.of(context).sources,
                        icon: const PhosphorIcon(PhosphorIconsLight.funnel),
                        onPressed: () => _showSources(context),
                      ),
                    ],
                    titleTextStyle: Theme.of(context).textTheme.titleMedium,
                  );
                  if (!kIsWeb &&
                      (Platform.isWindows ||
                          Platform.isLinux ||
                          Platform.isMacOS) &&
                      !state.nativeTitleBar) {
                    return _NativeWindowArea(child: widget);
                  }
                  return widget;
                }),
                Column(
                  children: _getNavigationItems(context)
                      .map((e) => _getItem(context, location, e))
                      .toList(),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _getSecondaryItems(context)
                      .map((e) => _getItem(context, location, e))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<dynamic> _showSources(BuildContext context) {
    final sources = [''];
    final currents =
        List<String>.from(context.read<FlowCubit>().getCurrentSources());
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
                  onChanged: (value) => setState(() => (value ?? false)
                      ? currents.add("")
                      : currents.remove("")),
                ),
                ...remotes.map(
                  (e) => CheckboxListTile(
                    title: Text(e.uri.host),
                    subtitle: Text(e.username),
                    value: currents.contains(e.identifier),
                    onChanged: (value) => setState(() => (value ?? false)
                        ? currents.add(e.identifier)
                        : currents.remove(e.identifier)),
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
