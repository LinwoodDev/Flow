import 'package:flow/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/task.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/services/local/service.dart';

import 'details.dart';

enum TaskView { list, overview }

extension TaskViewExtension on TaskView {
  IconData get icon {
    switch (this) {
      case TaskView.list:
        return PhosphorIcons.listLight;
      case TaskView.overview:
        return PhosphorIcons.squaresFourLight;
    }
  }

  String get name {
    return toString();
  }
}

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  Task? selected;
  late TasksApiService service;
  late Stream<List<Task>> taskStream;
  TaskView view = TaskView.list;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>().tasks;
    taskStream = service.onTasks();
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.tasks,
        pageTitle: "Tasks",
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(PhosphorIcons.funnelLight)),
          PopupMenuButton<TaskView>(
              initialValue: view,
              onSelected: (value) => setState(() => view = value),
              itemBuilder: (context) => TaskView.values
                  .map((e) => PopupMenuItem(
                      value: e,
                      child: ListTile(
                          title: Text(e.name),
                          leading: Icon(e.icon),
                          selected: e == view)))
                  .toList())
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
                      child: TaskPage(isDesktop: isDesktop, id: selected?.id)),
                  const VerticalDivider()
                ],
                Expanded(
                    flex: 3,
                    child: Scaffold(
                        floatingActionButton: selected == null && isDesktop
                            ? null
                            : FloatingActionButton.extended(
                                label: const Text("Create task"),
                                icon: const Icon(PhosphorIcons.plusLight),
                                onPressed: () => isDesktop
                                    ? setState(() => selected = null)
                                    : Modular.to.pushNamed("/tasks/create")),
                        body: Scrollbar(
                            child: SingleChildScrollView(
                                child: StreamBuilder<List<Task>>(
                                    stream: taskStream,
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
                                      var tasks = snapshot.data!;
                                      return Column(
                                          children: List.generate(tasks.length,
                                              (index) {
                                        var task = tasks[index];
                                        return Dismissible(
                                          key: Key(task.id!.toString()),
                                          onDismissed: (direction) {
                                            service.deleteTask(task.id!);
                                          },
                                          background:
                                              Container(color: Colors.red),
                                          child: ListTile(
                                              title: Text(task.name),
                                              selected: selected?.id == task.id,
                                              onTap: () => isDesktop
                                                  ? setState(
                                                      () => selected = task)
                                                  : Modular.to.pushNamed(
                                                      Uri(pathSegments: [
                                                      "",
                                                      "tasks",
                                                      "details"
                                                    ], queryParameters: {
                                                      "id": task.id.toString()
                                                    }).toString())),
                                        );
                                      }));
                                    })))))
              ]);
        }));
  }
}
