import 'package:flutter/material.dart';

enum RoutePages { guild, notification, teams, settings, admin, adminSettings }

class FlowDrawer extends StatelessWidget {
  final RoutePages? page;
  final bool admin;

  const FlowDrawer({Key? key, this.page, this.admin = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        right: false,
        child: Drawer(
            child: Row(children: [
          Expanded(
              child: ListView(padding: EdgeInsets.zero, children: [
            Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                height: 250,
                child: DrawerHeader(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "images/icon.png",
                    height: 128,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("GuildTitle", style: Theme.of(context).textTheme.headline5),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        TextSpan(text: 'Plan: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Community'),
                      ],
                    ),
                  )
                ]))),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text('User'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                            leading: const Icon(Icons.home_outlined),
                            title: const Text("Home"),
                            onTap: () async {},
                            selected: page == RoutePages.guild),
                        ListTile(
                            leading: const Icon(Icons.people_outline_outlined),
                            title: const Text("Teams"),
                            onTap: () async {},
                            selected: page == RoutePages.teams),
                        ListTile(
                            leading: const Icon(Icons.tune_outlined),
                            title: const Text("Settings"),
                            onTap: () async {},
                            selected: page == RoutePages.settings),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            IgnorePointer(
                ignoring: !admin,
                child: Opacity(
                    opacity: admin ? 1 : 0.3,
                    child: ExpansionTile(
                        title: Text('Admin'),
                        initiallyExpanded: admin,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.dashboard_customize_outlined),
                                      title: const Text("Dashboard"),
                                      onTap: () async {},
                                      selected: page == RoutePages.admin,
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.settings_outlined),
                                      title: const Text("Settings"),
                                      onTap: () async {},
                                      selected: page == RoutePages.adminSettings,
                                    )
                                  ])))
                        ])))
          ]))
        ])));
  }
}
