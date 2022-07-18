import 'package:flow/service/account.dart';
import 'package:flow/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/account.dart';

import 'accounts_dialog.dart';

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
          child: SingleChildScrollView(
        child: Column(children: [
          StreamBuilder<List<Account>>(
              stream: GetIt.I.get<AccountService>().accountsStream,
              builder: (context, snapshot) {
                var accounts = snapshot.data;
                return StreamBuilder<Account?>(
                    stream: GetIt.I.get<AccountService>().accountStream,
                    builder: (context, snapshot) {
                      var account = snapshot.data;
                      return PopupMenuButton(
                          itemBuilder: (context) => <PopupMenuEntry>[
                                PopupMenuItem(
                                    child: ListTile(
                                        mouseCursor: MouseCursor.defer,
                                        leading:
                                            const Icon(PhosphorIcons.userFill),
                                        title:
                                            Text(account?.username ?? "Local"),
                                        subtitle: Text(account?.address ?? ""),
                                        selected: true)),
                                if (accounts != null)
                                  ...accounts.map((e) => PopupMenuItem(
                                      child: ListTile(
                                          mouseCursor: MouseCursor.defer,
                                          title: Text(e.username),
                                          subtitle: Text(e.address)))),
                                const PopupMenuDivider(),
                                PopupMenuItem(
                                    onTap: () =>
                                        Modular.to.pushNamed("/connect"),
                                    child: const ListTile(
                                        mouseCursor: MouseCursor.defer,
                                        leading: Icon(PhosphorIcons.plusLight),
                                        title: Text("Connect"))),
                                PopupMenuItem(
                                    onTap: () {
                                      print("TEST");
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AccountsDialog());
                                    },
                                    child: ListTile(
                                        mouseCursor: MouseCursor.defer,
                                        leading: Icon(
                                            page == RoutePages.accounts
                                                ? PhosphorIcons.listFill
                                                : PhosphorIcons.listLight),
                                        title: const Text("Accounts"),
                                        selected: page == RoutePages.accounts)),
                                const PopupMenuDivider(),
                                PopupMenuItem(
                                    onTap: () => Modular.to.pushNamed("/intro"),
                                    child: const ListTile(
                                        mouseCursor: MouseCursor.defer,
                                        leading:
                                            Icon(PhosphorIcons.paperclipLight),
                                        title: Text("Show intro"))),
                                PopupMenuItem(
                                    onTap: () => Modular.to
                                        .pushReplacementNamed(
                                            "/settings/appearance"),
                                    child: ListTile(
                                        mouseCursor: MouseCursor.defer,
                                        leading: Icon(
                                            page == RoutePages.appearance
                                                ? PhosphorIcons.fadersFill
                                                : PhosphorIcons.fadersLight),
                                        title: const Text("Appearance"),
                                        selected:
                                            page == RoutePages.appearance)),
                                PopupMenuItem(
                                    onTap: () => Modular.to
                                        .pushReplacementNamed("/settings"),
                                    child: ListTile(
                                        mouseCursor: MouseCursor.defer,
                                        leading: Icon(
                                            page == RoutePages.information
                                                ? PhosphorIcons.infoFill
                                                : PhosphorIcons.infoLight),
                                        title: const Text("Information"),
                                        selected:
                                            page == RoutePages.information))
                              ],
                          child: ListTile(
                              mouseCursor: MouseCursor.defer,
                              leading: const Icon(PhosphorIcons.userLight),
                              trailing:
                                  const Icon(PhosphorIcons.arrowDownLight),
                              title: Text(account?.username ?? "Local"),
                              subtitle: Text(account?.address ?? "")));
                    });
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
                mouseCursor: MouseCursor.defer,
                leading: Icon(page == RoutePages.home
                    ? PhosphorIcons.houseFill
                    : PhosphorIcons.houseLight),
                title: const Text("Home"),
                onTap: () => Modular.to.pushReplacementNamed("/"),
                selected: page == RoutePages.home),
            ListTile(
                mouseCursor: MouseCursor.defer,
                leading: Icon(page == RoutePages.teams
                    ? PhosphorIcons.flagBannerFill
                    : PhosphorIcons.flagBannerLight),
                title: const Text("Teams"),
                onTap: () => Modular.to.pushReplacementNamed("/teams"),
                selected: page == RoutePages.teams),
            ListTile(
                mouseCursor: MouseCursor.defer,
                leading: Icon(page == RoutePages.tasks
                    ? PhosphorIcons.checkSquareFill
                    : PhosphorIcons.checkSquareLight),
                title: const Text("Tasks"),
                onTap: () => Modular.to.pushReplacementNamed("/tasks"),
                selected: page == RoutePages.tasks),
            ListTile(
                mouseCursor: MouseCursor.defer,
                leading: Icon(page == RoutePages.users
                    ? PhosphorIcons.usersFill
                    : PhosphorIcons.usersLight),
                title: const Text("Users"),
                onTap: () => Modular.to.pushReplacementNamed("/users"),
                selected: page == RoutePages.users),
            ListTile(
                mouseCursor: MouseCursor.defer,
                leading: Icon(page == RoutePages.events
                    ? PhosphorIcons.bookFill
                    : PhosphorIcons.bookLight),
                title: const Text("Events"),
                onTap: () => Modular.to.pushReplacementNamed("/events"),
                selected: page == RoutePages.events),
            ListTile(
                mouseCursor: MouseCursor.defer,
                leading: Icon(page == RoutePages.badges
                    ? PhosphorIcons.circleWavyFill
                    : PhosphorIcons.circleWavyLight),
                title: const Text("Badges"),
                onTap: () => Modular.to.pushReplacementNamed("/badges"),
                selected: page == RoutePages.badges)
          ]),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(children: [
                const Divider(),
                ListTile(
                    mouseCursor: MouseCursor.defer,
                    leading: Icon(page == RoutePages.adminSettings
                        ? PhosphorIcons.gearFill
                        : PhosphorIcons.gearLight),
                    title: const Text("Admin settings"),
                    onTap: () => Modular.to.pushReplacementNamed("/admin"),
                    selected: page == RoutePages.adminSettings),
              ]))
        ]),
      )),
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
