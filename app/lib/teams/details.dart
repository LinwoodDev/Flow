import 'package:flow_app/widgets/assign_dialog.dart';
import 'package:flow_app/widgets/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/account.dart';
import 'package:shared/models/team.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/services/local/service.dart';

class TeamPage extends StatefulWidget {
  final int? id;
  final bool isDesktop;

  const TeamPage({Key? key, this.id, this.isDesktop = false}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  final ScrollController _scrollController = ScrollController();
  late TeamsApiService service;
  late UsersApiService usersService;
  Color color = Colors.white;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    service = GetIt.I.get<LocalService>().teams;
    usersService = GetIt.I.get<LocalService>().users;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Account? account;

  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? _buildView(null)
        : StreamBuilder<Team?>(
            stream: service.onTeam(widget.id!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return _buildView(snapshot.data);
            });
  }

  Widget _buildView(Team? team) {
    var create = team == null;
    _nameController.text = team != null ? team.name : "";
    _descriptionController.text = team != null ? team.description : "";
    color = team?.color != null ? Color(team!.color!) : Colors.white;
    return DefaultTabController(
        length: team != null ? 3 : 2,
        child: Scaffold(
            appBar: AppBar(
                title: Text(create ? "Create team" : team!.name),
                actions: [
                  if (widget.isDesktop)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                          onPressed: () => Modular.to.pushNamed(
                              widget.id == null
                                  ? "/teams/create"
                                  : Uri(pathSegments: [
                                      "",
                                      "teams",
                                      "details"
                                    ], queryParameters: {
                                      "id": widget.id.toString()
                                    }).toString()),
                          icon: const Icon(PhosphorIcons.arrowSquareOutLight)),
                    ),
                ],
                bottom: TabBar(tabs: [
                  const Tab(
                      text: "General", icon: Icon(PhosphorIcons.wrenchLight)),
                  const Tab(
                      text: "Color", icon: Icon(PhosphorIcons.eyedropperLight)),
                  if (team != null)
                    const Tab(
                        text: "Permissions",
                        icon: Icon(PhosphorIcons.flagLight))
                ])),
            floatingActionButton: FloatingActionButton(
                heroTag: "team-check",
                child: const Icon(PhosphorIcons.checkLight),
                onPressed: () {
                  if (create) {
                    service.createTeam(Team(_nameController.text,
                        description: _descriptionController.text,
                        color: color.value));
                    if (widget.isDesktop) {
                      _nameController.clear();
                      _descriptionController.clear();
                      setState(() => color = Colors.white);
                    }
                  } else {
                    service.updateTeam(team!.copyWith(
                        name: _nameController.text,
                        color: color.value,
                        description: _descriptionController.text));
                  }
                  if (Modular.to.canPop() && !widget.isDesktop) {
                    Modular.to.pop();
                  }
                }),
            body: TabBarView(children: [
              SingleChildScrollView(
                  controller: _scrollController,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          child: Column(children: [
                            const SizedBox(height: 50),
                            Builder(builder: (context) {
                              return StreamBuilder<List<User>>(
                                  stream: usersService.onUsers(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    }
                                    if (!snapshot.hasData ||
                                        snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    var users = snapshot.data!;
                                    return DropdownButtonFormField<Account>(
                                        value: account,
                                        decoration: const InputDecoration(
                                            labelText: "Account",
                                            border: OutlineInputBorder()),
                                        onChanged: (value) => account = value,
                                        items: [
                                          ...Hive.box('accounts').values.map(
                                              (e) => DropdownMenuItem(
                                                  child: Text(e), value: e)),
                                          ...users
                                              .map((e) =>
                                                  Account.fromLocalUser(e))
                                              .map((e) => DropdownMenuItem(
                                                  child: Text(e.toString()),
                                                  value: e))
                                        ]);
                                  });
                            }),
                            const SizedBox(height: 50),
                            TextField(
                                decoration: const InputDecoration(
                                    labelText: "Name",
                                    filled: true,
                                    icon: Icon(PhosphorIcons.userLight)),
                                controller: _nameController),
                            const SizedBox(height: 20),
                            TextField(
                                decoration: const InputDecoration(
                                    labelText: "Description",
                                    border: OutlineInputBorder(),
                                    icon: Icon(PhosphorIcons.chatTextLight)),
                                maxLines: null,
                                controller: _descriptionController,
                                minLines: 3)
                          ])))),
              Align(
                  alignment: Alignment.topCenter,
                  child: ColorPicker(
                      initialColor: color, onClick: (value) => color = value)),
              if (team != null)
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: ListView(children: [
                        ListTile(
                          title: const Text("Team Admin"),
                          onTap: () async {
                            var assigned = await showDialog(
                                context: context,
                                builder: (context) =>
                                    AssignDialog(assigned: team.teamAdmin));
                            if (assigned != null) {
                              service.updateTeam(
                                  team.copyWith(teamAdmin: assigned));
                            }
                          },
                        ),
                        ListTile(
                          title: const Text("Sub Admin"),
                          onTap: () async {
                            var assigned = await showDialog(
                                context: context,
                                builder: (context) =>
                                    AssignDialog(assigned: team.subAdmin));
                            if (assigned != null) {
                              service.updateTeam(
                                  team.copyWith(subAdmin: assigned));
                            }
                          },
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text("Admin"),
                          onTap: () async {
                            var assigned = await showDialog(
                                context: context,
                                builder: (context) =>
                                    AssignDialog(assigned: team.admin));
                            if (assigned != null) {
                              service
                                  .updateTeam(team.copyWith(admin: assigned));
                            }
                          },
                        ),
                        ListTile(
                          title: const Text("Teams Admin"),
                          onTap: () async {
                            var assigned = await showDialog(
                                context: context,
                                builder: (context) =>
                                    AssignDialog(assigned: team.teamsAdmin));
                            if (assigned != null) {
                              service.updateTeam(
                                  team.copyWith(teamsAdmin: assigned));
                            }
                          },
                        ),
                        ListTile(
                          title: const Text("Users Admin"),
                          onTap: () async {
                            var assigned = await showDialog(
                                context: context,
                                builder: (context) =>
                                    AssignDialog(assigned: team.usersAdmin));
                            if (assigned != null) {
                              service.updateTeam(
                                  team.copyWith(usersAdmin: assigned));
                            }
                          },
                        ),
                        ListTile(
                            title: const Text("Events Admin"),
                            onTap: () async {
                              var assigned = await showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AssignDialog(assigned: team.eventsAdmin));
                              if (assigned != null) {
                                service.updateTeam(
                                    team.copyWith(eventsAdmin: assigned));
                              }
                            }),
                      ]),
                    ))
            ])));
  }
}
