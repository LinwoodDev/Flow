import 'dart:io';

import 'package:flow/cubits/flow.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow/widgets/window_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';

import '../main.dart';

List _getNavigationItems(BuildContext context) => [
      {
        "title": AppLocalizations.of(context).dashboard,
        "icon": Icons.dashboard_outlined,
        "link": "/"
      },
      {
        "title": AppLocalizations.of(context).calendar,
        "icon": Icons.calendar_month_outlined,
        "link": "/calendar"
      },
      null,
      {
        "title": AppLocalizations.of(context).notes,
        "icon": Icons.checklist_outlined,
        "link": "/notes"
      },
      {
        "title": AppLocalizations.of(context).groups,
        "icon": Icons.folder_outlined,
        "link": "/groups"
      },
      {
        "title": AppLocalizations.of(context).places,
        "icon": Icons.location_on_outlined,
        "link": "/places"
      },
      {
        "title": AppLocalizations.of(context).users,
        "icon": Icons.people_outlined,
        "link": "/users"
      },
    ];

List _getSecondaryItems(BuildContext context) => [
      null,
      {
        "title": AppLocalizations.of(context).sources,
        "icon": Icons.dns_outlined,
        "link": "/sources"
      },
      {
        "title": AppLocalizations.of(context).settings,
        "icon": Icons.settings_outlined,
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
                      child: _FlowDrawer())),
            ),
          ]);
        },
      ),
    );
  }
}

class FlowNavigation extends StatelessWidget {
  final String title;
  final Widget body;
  final PreferredSizeWidget? bottom;
  final Widget? endDrawer;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;

  const FlowNavigation({
    super.key,
    required this.title,
    required this.body,
    this.bottom,
    this.endDrawer,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = MediaQuery.of(context).size.width < 768;
      const drawer = _FlowDrawer();
      PreferredSizeWidget appBar = AppBar(
        bottom: bottom,
        title: Text(title),
        actions: [
          if (actions != null) ...actions!,
          if (!kIsWeb &&
              (Platform.isWindows || Platform.isLinux || Platform.isMacOS))
            const FlowWindowButtons()
        ],
      );

      if (!kIsWeb &&
          (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
        appBar = PreferredSize(
            preferredSize: appBar.preferredSize,
            child: DragToMoveArea(child: appBar));
      }

      return Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Scaffold(
              appBar: appBar,
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
            leading: Icon(map['icon']),
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
                Builder(builder: (context) {
                  final widget = AppBar(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        isNightly ? "images/nightly.png" : "images/logo.png",
                      ),
                    ),
                    leadingWidth: 32,
                    title: const Text(
                      isNightly ? "Flow Nightly" : "Flow",
                      textAlign: TextAlign.center,
                    ),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                        tooltip: AppLocalizations.of(context).sources,
                        icon: const Icon(Icons.filter_alt_outlined),
                        onPressed: () => _showSources(context),
                      ),
                    ],
                    titleTextStyle: Theme.of(context).textTheme.titleMedium,
                  );
                  if (!kIsWeb &&
                      (Platform.isWindows ||
                          Platform.isLinux ||
                          Platform.isMacOS)) {
                    return DragToMoveArea(child: widget);
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
                    title: Text(e.displayName),
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
