import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum RoutePages { home, teams, events, general, servers, personalization }

class FlowDrawer extends StatelessWidget {
  final RoutePages? page;
  final bool admin;

  const FlowDrawer({Key? key, this.page, this.admin = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
            child: Column(children: [
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
            Text("Linwood Flow", style: Theme.of(context).textTheme.headline5),
          ])),
      Divider(),
      ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text("Home"),
          onTap: () => Modular.to.navigate("/"),
          selected: page == RoutePages.home),
      ListTile(
          leading: const Icon(Icons.people_outline_outlined),
          title: const Text("Teams"),
          onTap: () => Modular.to.navigate("/teams"),
          selected: page == RoutePages.teams),
      ListTile(
          leading: const Icon(Icons.event_outlined),
          title: const Text("Events"),
          onTap: () => Modular.to.navigate("/events"),
          selected: page == RoutePages.events),
      ExpansionTile(title: Text('Settings'), initiallyExpanded: true, children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.build_outlined),
                      title: const Text("General"),
                      onTap: () => Modular.to.navigate("/settings"),
                      selected: page == RoutePages.general),
                  ListTile(
                    leading: const Icon(Icons.format_list_bulleted_outlined),
                    title: const Text("Servers"),
                    onTap: () => Modular.to.navigate("/settings/servers"),
                    selected: page == RoutePages.servers,
                  ),
                  ListTile(
                      leading: const Icon(Icons.tune_outlined),
                      title: const Text("Personalization"),
                      onTap: () => Modular.to.navigate("/settings/personalization"),
                      selected: page == RoutePages.personalization)
                ])))
      ])
    ])));
  }
}
