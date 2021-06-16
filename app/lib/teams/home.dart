import 'package:flow_app/services/local_service.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/team.dart';

import 'details.dart';

class TeamsPage extends StatefulWidget {
  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  int? selected = null;
  final List<Team> teams = [];
  @override
  void initState() {
    super.initState();

    initData();
  }

  Future<void> initData() {
    return GetIt.I.get<LocalService>().fetchTeams().then((value) {
      teams.addAll(value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.teams,
        pageTitle: "Teams",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 3,
              child: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                    label: Text("Create team"),
                    icon: Icon(PhosphorIcons.plusLight),
                    onPressed: () => Modular.to.pushNamed("/teams/create")),
                body: Scrollbar(
                    child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                teams.length,
                                (index) => ListTile(
                                    title: Text(teams[index].name),
                                    selected: selected == index,
                                    onTap: () => isDesktop
                                        ? setState(() => selected = index)
                                        : Modular.to.pushNamed(Uri(
                                                pathSegments: ["", "events", "details"],
                                                queryParameters: {"id": index.toString()})
                                            .toString())))))),
              ),
            ),
            if (isDesktop) ...[
              VerticalDivider(),
              Expanded(
                  flex: 2,
                  child: selected == null
                      ? Center(child: Text("Nothing selected"))
                      : TeamPage(team: teams[selected!], isDesktop: isDesktop, id: selected!))
            ]
          ]);
        }));
  }
}
