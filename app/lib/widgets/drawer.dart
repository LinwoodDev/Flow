import 'package:flow_app/service/account.dart';
import 'package:flow_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/account.dart';

enum RoutePages {
// Popup Menu
  accounts,
  appearance,
  information,
// Collections
  home,
  teams,
  users,
  events,
  badges,
  tasks,
// Settings
  adminSettings
}

class FlowDrawer extends StatelessWidget {
  final RoutePages? page;
  final bool admin;
  final bool permanentlyDisplay;

  const FlowDrawer(
      {Key? key,
      this.page,
      this.admin = false,
      this.permanentlyDisplay = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
          child: ListView(children: [
        StreamBuilder<Account?>(
            stream: GetIt.I.get<AccountService>().accountStream,
            builder: (context, snapshot) {
              var account = snapshot.data;
              return PopupMenuButton(
                  itemBuilder: (context) => <PopupMenuEntry>[
                        PopupMenuItem(
                            child: ListTile(
                                leading: const Icon(PhosphorIcons.userFill),
                                title: Text(account?.username ?? "Local"),
                                subtitle: Text(account?.address ?? ""),
                                selected: true)),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                            child: ListTile(
                                onTap: () => Modular.to.pushNamed("/connect"),
                                leading: const Icon(PhosphorIcons.plusLight),
                                title: const Text("Connect"))),
                        PopupMenuItem(
                            child: ListTile(
                                leading: Icon(page == RoutePages.accounts
                                    ? PhosphorIcons.listFill
                                    : PhosphorIcons.listLight),
                                title: const Text("Accounts"),
                                onTap: () => Modular.to
                                    .pushReplacementNamed("/settings/accounts"),
                                selected: page == RoutePages.accounts)),
                        PopupMenuItem(
                            child: ListTile(
                                onTap: () => Modular.to.pushNamed("/intro"),
                                leading:
                                    const Icon(PhosphorIcons.paperclipLight),
                                title: const Text("Show intro"))),
                        PopupMenuItem(
                            child: ListTile(
                                leading: Icon(page == RoutePages.appearance
                                    ? PhosphorIcons.fadersFill
                                    : PhosphorIcons.fadersLight),
                                title: const Text("Appearance"),
                                onTap: () => Modular.to.pushReplacementNamed(
                                    "/settings/appearance"),
                                selected: page == RoutePages.appearance)),
                        PopupMenuItem(
                            child: ListTile(
                                leading: Icon(page == RoutePages.information
                                    ? PhosphorIcons.infoFill
                                    : PhosphorIcons.infoLight),
                                title: const Text("Information"),
                                onTap: () => Modular.to.pushReplacementNamed(
                                    "/settings/appearance"),
                                selected: page == RoutePages.information))
                      ],
                  child: const ListTile(
                      leading: Icon(PhosphorIcons.userLight),
                      trailing: Icon(PhosphorIcons.arrowDownLight),
                      title: Text("Username"),
                      subtitle: Text("example.com")));
            }),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "images/logo.png",
                  height: 128,
                ),
              ),
              const SizedBox(height: 20),
              Text("Linwood Flow",
                  style: Theme.of(context).textTheme.headline5),
            ])),
        const Divider(),
        const SizedBox(height: 10),
        Column(children: [
          ListTile(
              leading: Icon(page == RoutePages.home
                  ? PhosphorIcons.houseFill
                  : PhosphorIcons.houseLight),
              title: const Text("Home"),
              onTap: () => Modular.to.pushReplacementNamed("/"),
              selected: page == RoutePages.home),
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
              leading: Icon(page == RoutePages.events
                  ? PhosphorIcons.bookFill
                  : PhosphorIcons.bookLight),
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
        const Divider(),
        ListTile(
            leading: Icon(page == RoutePages.adminSettings
                ? PhosphorIcons.wrenchFill
                : PhosphorIcons.wrenchLight),
            title: const Text("Admin settings"),
            onTap: () => Modular.to.pushReplacementNamed("/settings"),
            selected: page == RoutePages.adminSettings),
      ])),
      if (permanentlyDisplay) const VerticalDivider(width: 5, thickness: 0.5)
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
            desktopDrawer: Hero(
                tag: "drawer",
                child: FlowDrawer(page: page, permanentlyDisplay: true)),
            floatingActionButton: floatingActionButton,
            key: key);
}
