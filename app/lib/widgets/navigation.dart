import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _navigationItems = [
  {
    "title": "Dashboard",
    "name": "dashboard",
    "icon": Icons.dashboard_outlined,
    "link": "/"
  },
  {
    "title": "Calendar",
    "name": "calendar",
    "icon": Icons.calendar_month_outlined,
    "link": "/calendar"
  },
  null,
  {
    "title": "Places",
    "name": "places",
    "icon": Icons.location_on_outlined,
    "link": "/places"
  },
  {
    "title": "Users",
    "name": "users",
    "icon": Icons.people_outlined,
    "link": "/users"
  },
  {
    "title": "Settings",
    "name": "settings",
    "icon": Icons.settings_outlined,
    "link": "/settings"
  },
];

class FlowNavigation extends StatelessWidget {
  final String title;
  final String selected;
  final Widget body;

  const FlowNavigation({
    super.key,
    required this.title,
    required this.body,
    required this.selected,
  });

  Widget _getItem(BuildContext context, Map? map) {
    final currentSelected = selected == map?['name'];
    return map == null
        ? const Divider()
        : ListTile(
            style: ListTileStyle.drawer,
            title: Text(map['title']),
            leading: Icon(map['icon']),
            onTap: () => GoRouter.of(context).push(map['link']),
            selected: currentSelected,
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
      final isMobile = constraints.maxWidth < 600;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isMobile)
            SizedBox(
              width: 250,
              child: Material(
                child: Column(
                  children: [
                    Material(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Lorem ipsum",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 16),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.settings),
                                        onPressed: () {}),
                                    IconButton(
                                        icon: const Icon(Icons.logout),
                                        onPressed: () {}),
                                  ])
                            ],
                          ),
                        )),
                    Flexible(
                      child: ListView(
                        children: _navigationItems
                            .map((e) => _getItem(context, e))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: body,
            ),
          )
        ],
      );
    });
  }
}
