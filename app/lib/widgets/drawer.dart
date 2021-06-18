import 'package:flow_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum RoutePages {
  home,
  calendar,
  list,
// Admin
  teams,
  users,
  events,
  seasons,
  badges,
  tasks,
// Settings
  general,
  servers,
  appearance
}

class FlowDrawer extends StatelessWidget {
  final RoutePages? page;
  final bool admin;
  final bool permanentlyDisplay;

  const FlowDrawer({Key? key, this.page, this.admin = false, this.permanentlyDisplay = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
          child: SingleChildScrollView(
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
                leading: Icon(
                    page == RoutePages.home ? PhosphorIcons.houseFill : PhosphorIcons.houseLight),
                title: const Text("Home"),
                onTap: () => Modular.to.pushReplacementNamed("/"),
                selected: page == RoutePages.home),
            ListTile(
                leading: Icon(page == RoutePages.calendar
                    ? PhosphorIcons.calendarFill
                    : PhosphorIcons.calendarLight),
                title: const Text("Calendar"),
                onTap: () => Modular.to.pushReplacementNamed("/calendar"),
                selected: page == RoutePages.calendar),
            ListTile(
                leading: Icon(
                    page == RoutePages.list ? PhosphorIcons.listFill : PhosphorIcons.listLight),
                title: const Text("List"),
                onTap: () => Modular.to.pushReplacementNamed("/list"),
                selected: page == RoutePages.list),
            ExpansionTile(title: Text("Admin"), initiallyExpanded: true, children: [
              ListTile(
                  leading: Icon(page == RoutePages.teams
                      ? PhosphorIcons.flagBannerFill
                      : PhosphorIcons.flagBannerLight),
                  title: const Text("Teams"),
                  onTap: () => Modular.to.pushReplacementNamed("/teams"),
                  selected: page == RoutePages.teams),
              ListTile(
                  leading: Icon(page == RoutePages.tasks
                      ? PhosphorIcons.checkSquareFill
                      : PhosphorIcons.checkSquareLight),
                  title: const Text("Tasks"),
                  onTap: () => Modular.to.pushReplacementNamed("/tasks"),
                  selected: page == RoutePages.tasks),
              ListTile(
                  leading: Icon(page == RoutePages.users
                      ? PhosphorIcons.usersFill
                      : PhosphorIcons.usersLight),
                  title: const Text("Users"),
                  onTap: () => Modular.to.pushReplacementNamed("/users"),
                  selected: page == RoutePages.users),
              ListTile(
                  leading: Icon(page == RoutePages.seasons
                      ? PhosphorIcons.bookBookmarkFill
                      : PhosphorIcons.bookBookmarkLight),
                  title: const Text("Seasons"),
                  onTap: () => Modular.to.pushReplacementNamed("/seasons"),
                  selected: page == RoutePages.seasons),
              ListTile(
                  leading: Icon(
                      page == RoutePages.events ? PhosphorIcons.bookFill : PhosphorIcons.bookLight),
                  title: const Text("Events"),
                  onTap: () => Modular.to.pushReplacementNamed("/events"),
                  selected: page == RoutePages.events),
              ListTile(
                  leading: Icon(page == RoutePages.badges
                      ? PhosphorIcons.circleWavyFill
                      : PhosphorIcons.circleWavyLight),
                  title: const Text("Badges"),
                  onTap: () => Modular.to.pushReplacementNamed("/badges"),
                  selected: page == RoutePages.badges)
            ]),
            ExpansionTile(title: Text('Settings'), initiallyExpanded: true, children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        ListTile(
                            leading: Icon(page == RoutePages.general
                                ? PhosphorIcons.wrenchFill
                                : PhosphorIcons.wrenchLight),
                            title: const Text("General"),
                            onTap: () => Modular.to.pushReplacementNamed("/settings"),
                            selected: page == RoutePages.general),
                        ListTile(
                            leading: Icon(page == RoutePages.servers
                                ? PhosphorIcons.listFill
                                : PhosphorIcons.listLight),
                            title: const Text("Servers"),
                            onTap: () => Modular.to.pushReplacementNamed("/settings/servers"),
                            selected: page == RoutePages.servers),
                        ListTile(
                            leading: Icon(page == RoutePages.appearance
                                ? PhosphorIcons.fadersFill
                                : PhosphorIcons.fadersLight),
                            title: const Text("Appearance"),
                            onTap: () => Modular.to.pushReplacementNamed("/settings/appearance"),
                            selected: page == RoutePages.appearance)
                      ])))
            ])
          ])
        ]),
      )),
      if (permanentlyDisplay) VerticalDivider(width: 5, thickness: 0.5)
    ]));
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
