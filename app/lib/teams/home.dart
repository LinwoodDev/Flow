import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/team.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/services/local/service.dart';

import 'details.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  Team? selected;
  late TeamsApiService service;
  late Stream<List<Team>> teamStream;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>().teams;
    teamStream = service.onTeams();
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.teams,
        pageTitle: "Teams",
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(PhosphorIcons.funnelLight))
        ],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                if (isDesktop) ...[
                  Expanded(
                      flex: 2,
                      child: TeamPage(isDesktop: isDesktop, id: selected?.id)),
                  const VerticalDivider()
                ],
                Expanded(
                    flex: 3,
                    child: Scaffold(
                        floatingActionButton: selected == null && isDesktop
                            ? null
                            : FloatingActionButton.extended(
                                label: const Text("Create team"),
                                icon: const Icon(PhosphorIcons.plusLight),
                                onPressed: () => isDesktop
                                    ? setState(() => selected = null)
                                    : Modular.to.pushNamed("/teams/create")),
                        body: Scrollbar(
                            child: SingleChildScrollView(
                                child: StreamBuilder<List<Team>>(
                                    stream: teamStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text("Error: ${snapshot.error}");
                                      }
                                      if (snapshot.connectionState ==
                                              ConnectionState.waiting ||
                                          !snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      var teams = snapshot.data!;
                                      return Column(
                                          children: List.generate(teams.length,
                                              (index) {
                                        var team = teams[index];
                                        return Dismissible(
                                          key: Key(team.id!.toString()),
                                          onDismissed: (direction) {
                                            service.deleteTeam(team.id!);
                                          },
                                          background:
                                              Container(color: Colors.red),
                                          child: ListTile(
                                              title: Text(team.name),
                                              selected: selected?.id == team.id,
                                              onTap: () => isDesktop
                                                  ? setState(
                                                      () => selected = team)
                                                  : Modular.to.pushNamed(
                                                      Uri(pathSegments: [
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
