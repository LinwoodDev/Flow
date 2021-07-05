import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/models/assign.dart';
import 'package:shared/models/event.dart';
import 'package:shared/models/team.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/local_service.dart';

class AssignDialog extends StatefulWidget {
  final Assigned assigned;

  const AssignDialog({Key? key, required this.assigned}) : super(key: key);

  @override
  _AssignDialogState createState() => _AssignDialogState();
}

class _AssignDialogState extends State<AssignDialog> with TickerProviderStateMixin {
  late Assigned assigned;
  late final ApiService service;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    assigned = widget.assigned;
    service = GetIt.I.get<LocalService>();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: Scaffold(
                appBar: AppBar(
                    title: const Text("Assign"),
                    leading: const Icon(PhosphorIcons.compassLight),
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(icon: Icon(PhosphorIcons.usersLight), text: "Users"),
                        Tab(icon: Icon(PhosphorIcons.flagLight), text: "Teams"),
                        Tab(icon: Icon(PhosphorIcons.bookLight), text: "Events")
                      ],
                    )),
                body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  _AssignedObjectField(
                      title: "Everyone",
                      initialFlag: assigned.everyone,
                      onChanged: (value) =>
                          assigned = assigned.copyWith(everyone: value, removeEveryone: value == null)),
                  const Divider(),
                  Expanded(
                      child: TabBarView(controller: _tabController, children: [
                    Builder(
                      builder: (context) => StreamBuilder<List<User>>(
                          stream: service.onUsers(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                            if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            var users = snapshot.data!;
                            return SingleChildScrollView(
                              child: Column(children: [
                                if (users.any((a) => !assigned.users.any((b) => b.id == a.id)))
                                  OutlinedButton.icon(
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (context) => SimpleDialog(
                                              title: const Text("Add user"),
                                              children: users
                                                  .where((a) => !assigned.users.any((b) => b.id == a.id))
                                                  .map((e) => SimpleDialogOption(
                                                      child: Text(e.name),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                        setState(() => assigned = assigned.copyWith(
                                                            users: List.from(assigned.users)
                                                              ..add(AssignedObject(flag: true, id: e.id))));
                                                      }))
                                                  .toList())),
                                      icon: const Icon(PhosphorIcons.plusLight),
                                      label: const Text("ADD USER")),
                                ...assigned.users
                                    .asMap()
                                    .entries
                                    .map((e) => _AssignedObjectField(
                                          initialFlag: e.value.flag,
                                          onDelete: () => assigned = assigned.copyWith(
                                              users: List.from(assigned.users)..removeWhere((v) => v.id == e.value.id)),
                                          title: users.firstWhere((element) => element.id == e.value.id).name,
                                          onChanged: (value) => assigned = assigned.copyWith(
                                              users: List.from(assigned.users)
                                                ..[e.key] = AssignedObject(flag: value, id: e.value.id)),
                                        ))
                                    .toList()
                              ]),
                            );
                          }),
                    ),
                    Builder(
                      builder: (context) => StreamBuilder<List<Team>>(
                          stream: service.onTeams(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                            if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            var teams = snapshot.data!;
                            return SingleChildScrollView(
                              child: Column(children: [
                                if (teams.any((a) => !assigned.teams.any((b) => b.id == a.id)))
                                  OutlinedButton.icon(
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (context) => SimpleDialog(
                                              title: const Text("Add team"),
                                              children: teams
                                                  .where((a) => !assigned.teams.any((b) => b.id == a.id))
                                                  .map((e) => SimpleDialogOption(
                                                      child: Text(e.name),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                        setState(() => assigned = assigned.copyWith(
                                                            teams: List.from(assigned.teams)
                                                              ..add(AssignedObject(flag: true, id: e.id))));
                                                      }))
                                                  .toList())),
                                      icon: const Icon(PhosphorIcons.plusLight),
                                      label: const Text("ADD TEAM")),
                                ...assigned.teams
                                    .asMap()
                                    .entries
                                    .map((e) => _AssignedObjectField(
                                          initialFlag: e.value.flag,
                                          onDelete: () => assigned = assigned.copyWith(
                                              teams: List.from(assigned.teams)..removeWhere((v) => v.id == e.value.id)),
                                          title: teams.firstWhere((element) => element.id == e.value.id).name,
                                          onChanged: (value) => assigned = assigned.copyWith(
                                              teams: List.from(assigned.teams)
                                                ..[e.key] = AssignedObject(flag: value, id: e.value.id)),
                                        ))
                                    .toList()
                              ]),
                            );
                          }),
                    ),
                    Builder(
                        builder: (context) => StreamBuilder<List<Event>>(
                            stream: service.onEvents(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                              if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              var events = snapshot.data!;
                              return SingleChildScrollView(
                                  child: Column(children: [
                                if (events.any((a) => !assigned.events.any((b) => b.id == a.id)))
                                  OutlinedButton.icon(
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (context) => SimpleDialog(
                                              title: const Text("Add event"),
                                              children: events
                                                  .where((a) => !assigned.events.any((b) => b.id == a.id))
                                                  .map((e) => SimpleDialogOption(
                                                      child: Text(e.name),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                        setState(() => assigned = assigned.copyWith(
                                                            events: List.from(assigned.events)
                                                              ..add(AssignedObject(flag: true, id: e.id))));
                                                      }))
                                                  .toList())),
                                      icon: const Icon(PhosphorIcons.plusLight),
                                      label: const Text("ADD EVENT")),
                                ...assigned.events
                                    .asMap()
                                    .entries
                                    .map((e) => _AssignedObjectField(
                                          initialFlag: e.value.flag,
                                          onDelete: () => assigned = assigned.copyWith(
                                              events: List.from(assigned.events)
                                                ..removeWhere((v) => v.id == e.value.id)),
                                          title: events.firstWhere((element) => element.id == e.value.id).name,
                                          onChanged: (value) => assigned = assigned.copyWith(
                                              events: List.from(assigned.events)
                                                ..[e.key] = AssignedObject(flag: value, id: e.value.id)),
                                        ))
                                    .toList()
                              ]));
                            }))
                  ])),
                  const Divider(),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("CANCEL")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(assigned);
                            },
                            child: const Text("OK"))
                      ]))
                ]))));
  }
}

typedef _AssignObjectCallback = void Function(bool? value);

class _AssignedObjectField extends StatefulWidget {
  final String title;
  final bool? initialFlag;
  final VoidCallback? onDelete;
  final _AssignObjectCallback onChanged;

  const _AssignedObjectField(
      {Key? key, required this.title, required this.initialFlag, required this.onChanged, this.onDelete})
      : super(key: key);

  @override
  __AssignedObjectFieldState createState() => __AssignedObjectFieldState();
}

class __AssignedObjectFieldState extends State<_AssignedObjectField> {
  late bool? flag;
  final GlobalKey _dismissibleKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    flag = widget.initialFlag;
  }

  @override
  Widget build(BuildContext context) {
    return widget.onDelete != null
        ? Dismissible(
            key: _dismissibleKey,
            child: _buildMenu(),
            onDismissed: (direction) => widget.onDelete!(),
            background: Container(color: Colors.red))
        : _buildMenu();
  }

  Widget _buildMenu() => CheckboxListTile(
      title: Text(widget.title),
      subtitle: Text(flag.toString()),
      onChanged: (bool? value) {
        widget.onChanged(value);
        setState(() => flag = value);
      },
      controlAffinity: ListTileControlAffinity.leading,
      value: flag,
      tristate: true);
}
