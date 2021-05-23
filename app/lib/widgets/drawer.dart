import 'package:flow_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum RoutePages { home, teams, events, admin, general, servers, appearance }

class FlowDrawer extends StatelessWidget {
  final RoutePages? page;
  final bool admin;
  final bool permanentlyDisplay;

  const FlowDrawer({Key? key, this.page, this.admin = false, this.permanentlyDisplay = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 16,
        child: SingleChildScrollView(
            child: Row(children: [
          Expanded(
              child: Column(children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "images/logo.png",
                      height: 128,
                    ),
                  ),
                  Text("Linwood Flow", style: Theme.of(context).textTheme.headline5),
                ])),
            Divider(),
            SizedBox(height: 10),
            Column(children: [
              ListTile(
                  leading: const Icon(PhosphorIcons.houseLight),
                  title: const Text("Home"),
                  onTap: () => Modular.to.pushReplacementNamed("/"),
                  selected: page == RoutePages.home),
              ListTile(
                  leading: const Icon(PhosphorIcons.usersLight),
                  title: const Text("Teams"),
                  onTap: () => Modular.to.pushReplacementNamed("/teams"),
                  selected: page == RoutePages.teams),
              ListTile(
                  leading: const Icon(PhosphorIcons.calendarBlankLight),
                  title: const Text("Events"),
                  onTap: () => Modular.to.pushReplacementNamed("/events"),
                  selected: page == RoutePages.events),
              ListTile(
                  leading: const Icon(PhosphorIcons.squaresFourLight),
                  title: const Text("Admin Dashboard"),
                  onTap: () => Modular.to.pushReplacementNamed("/admin"),
                  selected: page == RoutePages.admin),
              ExpansionTile(title: Text('Settings'), initiallyExpanded: true, children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                          ListTile(
                              leading: const Icon(PhosphorIcons.wrenchLight),
                              title: const Text("General"),
                              onTap: () => Modular.to.pushReplacementNamed("/settings"),
                              selected: page == RoutePages.general),
                          ListTile(
                              leading: const Icon(PhosphorIcons.listLight),
                              title: const Text("Servers"),
                              onTap: () => Modular.to.pushReplacementNamed("/settings/servers"),
                              selected: page == RoutePages.servers),
                          ListTile(
                              leading: const Icon(PhosphorIcons.fadersLight),
                              title: const Text("Appearance"),
                              onTap: () => Modular.to.pushReplacementNamed("/settings/appearance"),
                              selected: page == RoutePages.appearance)
                        ])))
              ])
            ])
          ])),
          if (permanentlyDisplay) const VerticalDivider(width: 5, thickness: 0.5)
        ])));
  }
}

class FlowScaffold extends ResponsiveScaffold {
  FlowScaffold(
      {List<Widget> actions = const [],
      required Widget body,
      RoutePages? page,
      FloatingActionButton? floatingActionButton,
      PreferredSizeWidget? bottom,
      String pageTitle = '',
      Key? key})
      : super(
            actions: actions,
            pageTitle: pageTitle,
            bottom: bottom,
            body: body,
            drawer: FlowDrawer(page: page, permanentlyDisplay: false),
            desktopDrawer:
                Hero(tag: "drawer", child: FlowDrawer(page: page, permanentlyDisplay: true)),
            floatingActionButton: floatingActionButton,
            key: key);
}
