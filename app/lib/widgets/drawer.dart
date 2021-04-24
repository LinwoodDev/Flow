import 'package:flutter/material.dart';

enum RoutePages { guild, notification, teams, settings, admin, adminSettings }

class FlowDrawer extends StatelessWidget {
  final RoutePages? page;
  final bool admin;

  const FlowDrawer({Key? key, this.page, this.admin = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).backgroundColor.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ]),
          child: IconTheme(
              data: Theme.of(context).iconTheme,
              child: ExpansionTile(
                  title: Row(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: CircleAvatar(child: Text("test")),
                    ),
                    Text('Color')
                  ]),
                  children: [
                    Wrap(direction: Axis.horizontal, children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.person_outline_outlined)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.info_outlined)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.supervisor_account_outlined)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.logout_outlined))
                    ])
                  ]))),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "images/icon.png",
                height: 128,
              ),
            ),
            Text("GuildTitle", style: Theme.of(context).textTheme.headline5),
            Text("URL", style: Theme.of(context).textTheme.bodyText2),
          ])),
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
              child:
                  ExpansionTile(title: Text('Admin'), initiallyExpanded: admin, children: <Widget>[
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
    ]));
  }
}
