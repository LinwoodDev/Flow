import 'package:flow_app/services/api_service.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'services/local_service.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late ApiService service;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: FlowScaffold(
            bottom: TabBar(tabs: [
              Tab(icon: Icon(PhosphorIcons.squareLight), text: "Opened"),
              Tab(icon: Icon(PhosphorIcons.calendarLight), text: "Planned"),
              Tab(icon: Icon(PhosphorIcons.checkSquareLight), text: "Done")
            ]),
            actions: [
              IconButton(icon: Icon(PhosphorIcons.funnelLight), tooltip: "Filter", onPressed: () {})
            ],
            pageTitle: "Overview",
            page: RoutePages.overview,
            body: TabBarView(children: [
              Container(),
              Container(
                  child: ListView(children: [
                Card(
                    child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("Now", style: Theme.of(context).textTheme.headline5)),
                          ListTile(
                              title: Text("School"),
                              subtitle: Text("Ends at 18:00"),
                              leading: Icon(PhosphorIcons.calendar),
                              onTap: () {})
                        ]))),
                Card(
                    child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("Today", style: Theme.of(context).textTheme.headline5)),
                          ListTile(
                              title: Text("Eating"),
                              leading: Icon(PhosphorIcons.calendarLight),
                              subtitle: Text("13:00-14:00"),
                              onTap: () {}),
                          ListTile(
                              title: Text("Home work"),
                              subtitle: Text("18:00-19:00"),
                              leading: Icon(PhosphorIcons.checkSquareLight),
                              onTap: () {})
                        ]))),
                Card(
                    child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:
                                  Text("Tomorrow", style: Theme.of(context).textTheme.headline5)),
                          ListTile(
                              title: Text("Eating"),
                              leading: Icon(PhosphorIcons.calendarLight),
                              subtitle: Text("13:00-14:00"),
                              onTap: () {}),
                          ListTile(
                              title: Text("Home work"),
                              subtitle: Text("18:00-19:00"),
                              leading: Icon(PhosphorIcons.checkSquareLight),
                              onTap: () {})
                        ]))),
                Card(
                    child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:
                                  Text("This week", style: Theme.of(context).textTheme.headline5)),
                          ListTile(
                              title: Text("Eating"),
                              leading: Icon(PhosphorIcons.calendarLight),
                              subtitle: Text("13:00-14:00"),
                              onTap: () {}),
                          ListTile(
                              title: Text("Home work"),
                              subtitle: Text("18:00-19:00"),
                              leading: Icon(PhosphorIcons.checkSquareLight),
                              onTap: () {})
                        ])))
              ])),
              Container()
            ])));
  }
}
