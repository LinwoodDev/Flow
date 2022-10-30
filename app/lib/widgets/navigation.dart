import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

List _getNavigationItems(BuildContext context) => [
      {
        "title": AppLocalizations.of(context)!.dashboard,
        "name": "dashboard",
        "icon": Icons.dashboard_outlined,
        "link": "/"
      },
      {
        "title": AppLocalizations.of(context)!.calendar,
        "name": "calendar",
        "icon": Icons.calendar_month_outlined,
        "link": "/calendar"
      },
      null,
      {
        "title": AppLocalizations.of(context)!.groups,
        "name": "groups",
        "icon": Icons.folder_outlined,
        "link": "/groups"
      },
      {
        "title": AppLocalizations.of(context)!.places,
        "name": "places",
        "icon": Icons.location_on_outlined,
        "link": "/places"
      },
      {
        "title": AppLocalizations.of(context)!.users,
        "name": "users",
        "icon": Icons.people_outlined,
        "link": "/users"
      },
    ];

List _getSecondaryItems(BuildContext context) => [
      null,
      {
        "title": AppLocalizations.of(context)!.sources,
        "name": "sources",
        "icon": Icons.dns_outlined,
        "link": "/sources"
      },
      {
        "title": AppLocalizations.of(context)!.settings,
        "name": "settings",
        "icon": Icons.settings_outlined,
        "link": "/settings"
      }
    ];

class FlowNavigation extends StatelessWidget {
  final String title;
  final String selected;
  final Widget body;
  final PreferredSizeWidget? bottom;
  final Widget? endDrawer;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;

  const FlowNavigation({
    super.key,
    required this.title,
    required this.body,
    required this.selected,
    this.bottom,
    this.endDrawer,
    this.actions,
    this.floatingActionButton,
  });

  Widget _getItem(BuildContext context, Map? map) {
    final currentSelected = selected == map?['name'];
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
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 768;
      final drawer = Material(
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
                              ],
                            ),
                          )),
                      Column(
                        children: _getNavigationItems(context)
                            .map((e) => _getItem(context, e))
                            .toList(),
                      ),
                    ]),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _getSecondaryItems(context)
                          .map((e) => _getItem(context, e))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      );
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isMobile)
            SizedBox(
              width: 250,
              child: drawer,
            ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                bottom: bottom,
                title: Text(title),
                actions: [if (actions != null) ...actions!],
              ),
              drawer: isMobile ? Drawer(child: drawer) : null,
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
        ],
      );
    });
  }
}
