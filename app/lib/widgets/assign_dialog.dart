import 'package:flow_app/services/api_service.dart';
import 'package:flow_app/services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/assign.dart';
import 'package:shared/event.dart';
import 'package:shared/team.dart';
import 'package:shared/user.dart';

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
            constraints: BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: Scaffold(
                appBar: AppBar(
                    title: Text("Assign"),
                    leading: Icon(PhosphorIcons.compassLight),
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(icon: Icon(PhosphorIcons.usersLight), text: "Users"),
                        Tab(icon: Icon(PhosphorIcons.flagLight), text: "Teams"),
                        Tab(icon: Icon(PhosphorIcons.bookLight), text: "Events")
                      ],
                    )),
                body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  _AssignedObjectField(
                      title: "Everyone",
                      initialFlag: assigned.everyone,
                      onChanged: (value) => assigned = assigned.copyWith(everyone: value)),
                  Divider(),
                  Expanded(
                      child: Container(
                          child: TabBarView(controller: _tabController, children: [
                    Builder(
                      builder: (context) => StreamBuilder<List<User>>(
                          stream: service.onUsers(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                            if (snapshot.connectionState == ConnectionState.waiting ||
                                !snapshot.hasData)
                              return Center(child: CircularProgressIndicator());
                            var users = snapshot.data!;
                            return SingleChildScrollView(
                              child: Column(children: [
                                OutlinedButton.icon(
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                            title: Text("Add user"),
                                            children: users
                                                .where(
                                                    (a) => !assigned.users.any((b) => b.id == a.id))
                                                .map((e) => SimpleDialogOption(
                                                    child: Text(e.name),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      setState(() => assigned = assigned.copyWith(
                                                          users: List.from(assigned.users)
                                                            ..add(AssignedObject(
                                                                flag: AssignFlag.allow,
                                                                id: e.id))));
                                                    }))
                                                .toList())),
                                    icon: Icon(PhosphorIcons.plusLight),
                                    label: Text("ADD USER")),
                                ...assigned.users
                                    .asMap()
                                    .entries
                                    .map((e) => _AssignedObjectField(
                                          initialFlag: e.value.flag,
                                          onDelete: () => setState(() => assigned =
                                              assigned.copyWith(
                                                  users: List.from(assigned.users)
                                                    ..removeAt(e.key))),
                                          title: users
                                              .firstWhere((element) => element.id == e.value.id)
                                              .name,
                                          onChanged: (value) => assigned = assigned.copyWith(
                                              users: List.from(assigned.users)
                                                ..[e.key] =
                                                    AssignedObject(flag: value, id: e.value.id)),
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
                            if (snapshot.connectionState == ConnectionState.waiting ||
                                !snapshot.hasData)
                              return Center(child: CircularProgressIndicator());
                            var teams = snapshot.data!;
                            return SingleChildScrollView(
                              child: Column(children: [
                                OutlinedButton.icon(
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                            title: Text("Add team"),
                                            children: teams
                                                .where(
                                                    (a) => !assigned.teams.any((b) => b.id == a.id))
                                                .map((e) => SimpleDialogOption(
                                                    child: Text(e.name),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      setState(() => assigned = assigned.copyWith(
                                                          teams: List.from(assigned.teams)
                                                            ..add(AssignedObject(
                                                                flag: AssignFlag.allow,
                                                                id: e.id))));
                                                    }))
                                                .toList())),
                                    icon: Icon(PhosphorIcons.plusLight),
                                    label: Text("ADD TEAM")),
                                ...assigned.teams
                                    .asMap()
                                    .entries
                                    .map((e) => _AssignedObjectField(
                                          initialFlag: e.value.flag,
                                          onDelete: () => setState(() => assigned =
                                              assigned.copyWith(
                                                  teams: List.from(assigned.teams)
                                                    ..removeAt(e.key))),
                                          title: teams
                                              .firstWhere((element) => element.id == e.value.id)
                                              .name,
                                          onChanged: (value) => assigned = assigned.copyWith(
                                              teams: List.from(assigned.teams)
                                                ..[e.key] =
                                                    AssignedObject(flag: value, id: e.value.id)),
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
                            if (snapshot.connectionState == ConnectionState.waiting ||
                                !snapshot.hasData)
                              return Center(child: CircularProgressIndicator());
                            var events = snapshot.data!;
                            return SingleChildScrollView(
                              child: Column(children: [
                                OutlinedButton.icon(
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                            title: Text("Add event"),
                                            children: events
                                                .where((a) =>
                                                    !assigned.events.any((b) => b.id == a.id))
                                                .map((e) => SimpleDialogOption(
                                                    child: Text(e.name),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      setState(() => assigned = assigned.copyWith(
                                                          events: List.from(assigned.events)
                                                            ..add(AssignedObject(
                                                                flag: AssignFlag.allow,
                                                                id: e.id))));
                                                    }))
                                                .toList())),
                                    icon: Icon(PhosphorIcons.plusLight),
                                    label: Text("ADD EVENT")),
                                ...assigned.events
                                    .asMap()
                                    .entries
                                    .map((e) => _AssignedObjectField(
                                          initialFlag: e.value.flag,
                                          onDelete: () => setState(() => assigned =
                                              assigned.copyWith(
                                                  events: List.from(assigned.events)
                                                    ..removeAt(e.key))),
                                          title: events
                                              .firstWhere((element) => element.id == e.value.id)
                                              .name,
                                          onChanged: (value) => assigned = assigned.copyWith(
                                              events: List.from(assigned.events)
                                                ..[e.key] =
                                                    AssignedObject(flag: value, id: e.value.id)),
                                        ))
                                    .toList()
                              ]),
                            );
                          }),
                    )
                  ]))),
                  Divider(),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("CANCEL")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"))
                      ]))
                ]))));
  }
}

typedef _AssignObjectCallback = void Function(AssignFlag value);

class _AssignedObjectField extends StatefulWidget {
  final String title;
  final AssignFlag initialFlag;
  final VoidCallback? onDelete;
  final _AssignObjectCallback onChanged;

  const _AssignedObjectField(
      {Key? key,
      required this.title,
      required this.initialFlag,
      required this.onChanged,
      this.onDelete})
      : super(key: key);

  @override
  __AssignedObjectFieldState createState() => __AssignedObjectFieldState();
}

class __AssignedObjectFieldState extends State<_AssignedObjectField> {
  late AssignFlag flag;
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
            onDismissed: (direction) => widget.onDelete,
            background: Container(color: Colors.red))
        : _buildMenu();
  }

  Widget _buildMenu() => PopupMenuButton<AssignFlag>(
      tooltip: "Change flag",
      itemBuilder: (BuildContext context) =>
          AssignFlag.values.map((e) => PopupMenuItem(child: Text(e.toString()), value: e)).toList(),
      onSelected: (value) {
        widget.onChanged(value);
        setState(() => flag = value);
      },
      child: ListTile(title: Text(widget.title), subtitle: Text(flag.toString())));
}
