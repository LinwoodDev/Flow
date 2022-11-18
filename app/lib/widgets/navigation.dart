import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

List _getNavigationItems(BuildContext context) => [
      {
        "title": AppLocalizations.of(context)!.dashboard,
        "icon": Icons.dashboard_outlined,
        "link": "/"
      },
      {
        "title": AppLocalizations.of(context)!.calendar,
        "icon": Icons.calendar_month_outlined,
        "link": "/calendar"
      },
      null,
      {
        "title": AppLocalizations.of(context)!.todos,
        "icon": Icons.checklist_outlined,
        "link": "/todos"
      },
      {
        "title": AppLocalizations.of(context)!.groups,
        "icon": Icons.folder_outlined,
        "link": "/groups"
      },
      {
        "title": AppLocalizations.of(context)!.places,
        "icon": Icons.location_on_outlined,
        "link": "/places"
      },
      {
        "title": AppLocalizations.of(context)!.users,
        "icon": Icons.people_outlined,
        "link": "/users"
      },
    ];

List _getSecondaryItems(BuildContext context) => [
      null,
      {
        "title": AppLocalizations.of(context)!.sources,
        "icon": Icons.dns_outlined,
        "link": "/sources"
      },
      {
        "title": AppLocalizations.of(context)!.settings,
        "icon": Icons.settings_outlined,
        "link": "/settings"
      }
    ];

class FlowRootNavigation extends StatelessWidget {
  final Widget child;
  const FlowRootNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        if (!isMobile) {
          return Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: child,
              ),
              const SizedBox(
                width: 250,
                child: _FlowDrawer(),
              ),
            ],
          );
        }
        return child;
      },
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
      final isMobile = constraints.maxWidth < 768;
      const drawer = _FlowDrawer();
      return Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                bottom: bottom,
                title: Text(title),
                actions: [if (actions != null) ...actions!],
              ),
              drawer: isMobile ? const Drawer(child: drawer) : null,
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
    var currentSelected =
        (map?["link"] as String?)?.startsWith(location) ?? false;
    if (location == "/") {
      currentSelected = location == map?["link"];
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
      child: Padding(
        padding: const EdgeInsets.only(right: 8, top: 16, bottom: 8),
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Material(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 16, bottom: 64),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  isNightly
                                      ? "images/nightly.png"
                                      : "images/logo.png",
                                  width: 64,
                                  height: 64),
                              const SizedBox(height: 16),
                              Text(
                                  isNightly
                                      ? "Linwood Flow Nightly"
                                      : "Linwood Flow",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 16),
                              OutlinedButton.icon(
                                label:
                                    Text(AppLocalizations.of(context)!.sources),
                                icon: const Icon(Icons.menu_outlined),
                                onPressed: () => _showSources(context),
                              ),
                            ],
                          ),
                        )),
                    Column(
                      children: _getNavigationItems(context)
                          .map((e) => _getItem(context, location, e))
                          .toList(),
                    ),
                  ]),
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
      ),
    );
  }

  Future<dynamic> _showSources(BuildContext context) {
    final sources = [''];
    final currents =
        List<String>.from(context.read<FlowCubit>().getCurrentSources());
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(AppLocalizations.of(context)!.sources),
        content: StatefulBuilder(
          builder: (context, setState) {
            bool? allSources;
            if (currents.length == sources.length) {
              allSources = true;
            } else if (currents.isEmpty) {
              allSources = false;
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context)!.allSources),
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
                  title: Text(AppLocalizations.of(context)!.local),
                  value: currents.contains(""),
                  onChanged: (value) => setState(() => (value ?? false)
                      ? currents.add("")
                      : currents.remove("")),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.save),
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
