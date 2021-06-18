import 'package:flow_app/services/api_service.dart';
import 'package:flow_app/services/local_service.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/task.dart';

import 'details.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  Task? selected = null;
  late ApiService service;
  late Stream<List<Task>> taskStream;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>();
    taskStream = service.onTasks();
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.tasks,
        pageTitle: "Tasks",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 3,
              child: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                    label: Text("Create task"),
                    icon: Icon(PhosphorIcons.plusLight),
                    onPressed: () => isDesktop
                        ? setState(() => selected = null)
                        : Modular.to.pushNamed("/tasks/create")),
                body: Scrollbar(
                    child: SingleChildScrollView(
                        child: StreamBuilder<List<Task>>(
                            stream: taskStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) return Text("Error ${snapshot.error}");
                              if (snapshot.connectionState == ConnectionState.waiting ||
                                  !snapshot.hasData)
                                return Center(child: CircularProgressIndicator());
                              var tasks = snapshot.data!;
                              return Column(
                                  children: List.generate(tasks.length, (index) {
                                var task = tasks[index];
                                return Dismissible(
                                  key: Key(task.id!.toString()),
                                  onDismissed: (direction) {
                                    service.deleteTask(task.id!);
                                  },
                                  background: Container(color: Colors.red),
                                  child: ListTile(
                                      title: Text(task.name),
                                      selected: selected?.id == task.id,
                                      onTap: () => isDesktop
                                          ? setState(() => selected = task)
                                          : Modular.to.pushNamed(Uri(
                                                  pathSegments: ["", "tasks", "details"],
                                                  queryParameters: {"id": task.id.toString()})
                                              .toString())),
                                );
                              }));
                            }))),
              ),
            ),
            if (isDesktop) ...[
              VerticalDivider(),
              Expanded(flex: 2, child: TaskPage(isDesktop: isDesktop, id: selected?.id))
            ]
          ]);
        }));
  }
}
