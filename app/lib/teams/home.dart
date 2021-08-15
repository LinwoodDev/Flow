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

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>().teams;
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
        body: StreamBuilder<List<Team>>(
            stream: service.onTeams(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              var teams = snapshot.data!;
              return LayoutBuilder(builder: (context, constraints) {
                var isDesktop = MediaQuery.of(context).size.width > 1000;
                return StatefulBuilder(
                    builder: (context, setState) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: [
                              if (isDesktop) ...[
                                Expanded(
                                    flex: 2,
                                    child: TeamPage(
                                        isDesktop: isDesktop,
                                        id: selected?.id,
                                        team: selected)),
                                const VerticalDivider()
                              ],
                              Expanded(
                                  flex: 3,
                                  child: Scaffold(
                                      floatingActionButton: selected == null &&
                                              isDesktop
                                          ? null
                                          : FloatingActionButton.extended(
                                              label: const Text("Create team"),
                                              icon: const Icon(
                                                  PhosphorIcons.plusLight),
                                              onPressed: () => isDesktop
                                                  ? setState(
                                                      () => selected = null)
                                                  : Modular.to.pushNamed(
                                                      "/teams/create")),
                                      body: ListView.builder(
                                          itemCount: teams.length,
                                          itemBuilder: (context, index) {
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
                                                  selected:
                                                      selected?.id == team.id,
                                                  onTap: () => isDesktop
                                                      ? setState(
                                                          () => selected = team)
                                                      : Modular.to.pushNamed(
                                                          Uri(pathSegments: [
                                                          "",
                                                          "teams",
                                                          "details"
                                                        ], queryParameters: {
                                                          "id":
                                                              team.id.toString()
                                                        }).toString())),
                                            );
                                          })))
                            ]));
              });
            }));
  }
}
