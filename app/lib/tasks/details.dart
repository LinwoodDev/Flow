import 'package:flow_app/widgets/assign_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/account.dart';
import 'package:shared/models/task.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/services/local_service.dart';

class TaskPage extends StatefulWidget {
  final int? id;
  final bool isDesktop;

  const TaskPage({Key? key, this.id, this.isDesktop = false}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late ApiService service;

  @override
  void initState() {
    super.initState();
    service = GetIt.I.get<LocalService>();
  }

  @override
  void didUpdateWidget(TaskPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    service = GetIt.I.get<LocalService>();
  }

  Account? account;

  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? _buildView(null)
        : StreamBuilder<Task?>(
            stream: service.onTask(widget.id!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return _buildView(snapshot.data);
            });
  }

  Widget _buildView(Task? task) {
    var create = task == null;
    _nameController.text = task?.name ?? "";
    _descriptionController.text = task?.description ?? "";
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: Text(create ? "Create task" : task!.name),
                actions: [
                  if (widget.isDesktop)
                    IconButton(
                        onPressed: () => Modular.to.pushNamed(widget.id == null
                            ? "/tasks/create"
                            : Uri(pathSegments: ["", "tasks", "details"], queryParameters: {"id": widget.id.toString()})
                                .toString()),
                        icon: const Icon(PhosphorIcons.arrowSquareOutLight))
                ],
                bottom: const TabBar(tabs: [
                  Tab(icon: Icon(PhosphorIcons.wrenchLight), text: "General"),
                  Tab(icon: Icon(PhosphorIcons.foldersLight), text: "Submission")
                ])),
            floatingActionButton: FloatingActionButton(
                heroTag: "task-check",
                child: const Icon(PhosphorIcons.checkLight),
                onPressed: () {
                  if (create) {
                    service.createTask(Task(_nameController.text, description: _descriptionController.text));
                    if (widget.isDesktop) {
                      _nameController.clear();
                      _descriptionController.clear();
                    }
                  } else {
                    service.updateTask(
                        task!.copyWith(name: _nameController.text, description: _descriptionController.text));
                  }
                  if (Modular.to.canPop() && !widget.isDesktop) Modular.to.pop();
                }),
            body: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(children: [
                      const SizedBox(height: 50),
                      Builder(builder: (context) {
                        return StreamBuilder<List<User>>(
                            stream: service.onUsers(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              }
                              if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              var users = snapshot.data!;
                              return DropdownButtonFormField<Account>(
                                  value: account,
                                  decoration: const InputDecoration(labelText: "Account", border: OutlineInputBorder()),
                                  onChanged: (value) => setState(() => account = value),
                                  items: [
                                    ...Hive.box('accounts')
                                        .values
                                        .map((e) => DropdownMenuItem(child: Text(e), value: e)),
                                    ...users
                                        .map((e) => Account.fromLocalUser(e))
                                        .map((e) => DropdownMenuItem(child: Text(e.toString()), value: e))
                                  ]);
                            });
                      }),
                      const SizedBox(height: 50),
                      Expanded(
                        child: TabBarView(children: [
                          SingleChildScrollView(
                              child: Column(children: [
                            TextField(
                                decoration: const InputDecoration(
                                    filled: true, labelText: "Name", icon: Icon(PhosphorIcons.calendarLight)),
                                controller: _nameController),
                            const SizedBox(height: 20),
                            TextField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Description",
                                    icon: Icon(PhosphorIcons.articleLight)),
                                maxLines: null,
                                controller: _descriptionController,
                                minLines: 3),
                            if (task != null) ...[
                              const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
                              ElevatedButton.icon(
                                  icon: const Icon(PhosphorIcons.compassLight),
                                  label: const Text("ASSIGN"),
                                  onPressed: () async {
                                    var assigned = await showDialog(
                                        context: context, builder: (context) => AssignDialog(assigned: task.assigned));
                                    if (assigned != null) {
                                      service.updateTask(task.copyWith(assigned: assigned));
                                    }
                                  })
                            ]
                          ])),
                          ListView(children: [
                            ExpansionTile(
                                title: const Text("Admin"),
                                leading: const Icon(PhosphorIcons.gearLight),
                                children: [
                                  ListTile(
                                      title: const Text("Submission type"),
                                      subtitle: const Text("None"),
                                      onTap: () {},
                                      leading: const Icon(PhosphorIcons.fileLight)),
                                  ListTile(
                                      title: const Text("Show submissions"),
                                      onTap: () {},
                                      leading: const Icon(PhosphorIcons.listLight))
                                ]),
                            if (task != null && account != null)
                              Builder(builder: (context) {
                                return StreamBuilder<Submission?>(
                                    stream: service.onSubmission(task.id!, 0),
                                    builder: (context, snapshot) {
                                      return ExpansionTile(
                                          title: const Text("Your submission"),
                                          leading: const Icon(PhosphorIcons.folderLight),
                                          initiallyExpanded: true,
                                          children: [
                                            Row(children: [
                                              if (snapshot.hasData)
                                                Expanded(
                                                    child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextButton.icon(
                                                      onPressed: () {},
                                                      icon: const Icon(PhosphorIcons.xLight),
                                                      label: const Text("REMOVE")),
                                                )),
                                              Expanded(
                                                  child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ElevatedButton.icon(
                                                    onPressed: () {},
                                                    icon: const Icon(PhosphorIcons.paperPlaneRightLight),
                                                    label: const Text("SUBMIT")),
                                              ))
                                            ])
                                          ]);
                                    });
                              })
                          ])
                        ]),
                      ),
                    ])))));
  }
}
