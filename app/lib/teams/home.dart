import 'package:flow_app/services/api_service.dart';
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
  Team? selected = null;
  late ApiService service;
  late Stream<List<Team>> teamStream;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>();
    teamStream = service.onTeams();
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.teams,
        pageTitle: "Teams",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                if (isDesktop) ...[
                  Expanded(flex: 2, child: TeamPage(isDesktop: isDesktop, id: selected?.id)),
                  VerticalDivider()
                ],
                Expanded(
                    flex: 3,
                    child: Scaffold(
                        floatingActionButton: FloatingActionButton.extended(
                            label: Text("Create team"),
                            icon: Icon(PhosphorIcons.plusLight),
                            onPressed: () => isDesktop
                                ? setState(() => selected = null)
                                : Modular.to.pushNamed("/teams/create")),
                        body: Scrollbar(
                            child: SingleChildScrollView(
                                child: StreamBuilder<List<Team>>(
                                    stream: teamStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) return Text("Error ${snapshot.error}");
                                      if (snapshot.connectionState == ConnectionState.waiting ||
                                          !snapshot.hasData)
                                        return Center(child: CircularProgressIndicator());
                                      var teams = snapshot.data!;
                                      return Column(
                                          children: List.generate(teams.length, (index) {
                                        var team = teams[index];
                                        return Dismissible(
                                          key: Key(team.id!.toString()),
                                          onDismissed: (direction) {
                                            service.deleteTeam(team.id!);
                                          },
                                          background: Container(color: Colors.red),
                                          child: ListTile(
                                              title: Text(team.name),
                                              selected: selected?.id == team.id,
                                              onTap: () => isDesktop
                                                  ? setState(() => selected = team)
                                                  : Modular.to.pushNamed(Uri(pathSegments: [
                                                      "",
                                                      "teams",
                                                      "details"
                                                    ], queryParameters: {
                                                      "id": team.id.toString()
                                                    }).toString())),
                                        );
                                      }));
                                    })))))
              ]);
        }));
  }
}
