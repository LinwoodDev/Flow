import 'package:flow_app/widgets/assign_dialog.dart';
import 'package:flow_app/widgets/date.dart';
import 'package:flow_app/widgets/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/account.dart';
import 'package:shared/models/event.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/services/local/service.dart';

class EventPage extends StatefulWidget {
  final int? id;
  final bool isDesktop, isDialog;

  const EventPage(
      {Key? key, this.id, this.isDesktop = false, this.isDialog = false})
      : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late TabController _tabController;

  late EventsApiService service;
  late UsersApiService usersService;
  int? id;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    service = GetIt.I.get<LocalService>().events;
    usersService = GetIt.I.get<LocalService>().users;
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didUpdateWidget(EventPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    service = GetIt.I.get<LocalService>().events;
    usersService = GetIt.I.get<LocalService>().users;
    if (oldWidget.id != widget.id) setState(() => id = widget.id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Account? account;

  @override
  Widget build(BuildContext context) {
    return id == null
        ? _buildView(null)
        : StreamBuilder<Event?>(
            stream: service.onEvent(id!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return _buildView(snapshot.data);
            });
  }

  Widget _buildView(Event? event) {
    var create = event == null;
    bool isCanceled = event?.isCanceled ?? false;
    DateTime? startDateTime = event?.startDateTime,
        endDateTime = event?.endDateTime;
    _nameController.text = event?.name ?? "";
    _descriptionController.text = event?.description ?? "";
    return Scaffold(
        appBar: AppBar(
            leading: widget.isDialog
                ? IconButton(
                    icon: const Icon(PhosphorIcons.xLight),
                    onPressed: () => Navigator.of(context).pop())
                : null,
            title: Text(create ? "Create event" : event!.name),
            actions: [
              if (widget.isDesktop)
                IconButton(
                    onPressed: () {
                      if (widget.isDialog) Modular.to.pop();
                      Modular.to.pushNamed(id == null
                          ? "/events/create"
                          : Uri(
                                  pathSegments: ["", "events", "details"],
                                  queryParameters: {"id": id.toString()})
                              .toString());
                    },
                    icon: const Icon(PhosphorIcons.arrowSquareOutLight))
            ],
            bottom: TabBar(controller: _tabController, tabs: const [
              Tab(icon: Icon(PhosphorIcons.wrenchLight), text: "General"),
              Tab(
                  icon: Icon(PhosphorIcons.calendarLight),
                  text: "Date and time")
            ])),
        floatingActionButton: FloatingActionButton(
            heroTag: "event-check",
            child: const Icon(PhosphorIcons.checkLight),
            onPressed: () async {
              if (create) {
                var event = await service.createEvent(Event(
                    _nameController.text,
                    description: _descriptionController.text,
                    isCanceled: isCanceled,
                    startDateTime: startDateTime,
                    endDateTime: endDateTime));
                if (widget.isDesktop) {
                  _nameController.clear();
                  _descriptionController.clear();
                }
                setState(() => id = event.id);
              } else {
                service.updateEvent(event!.copyWith(
                    name: _nameController.text,
                    description: _descriptionController.text,
                    isCanceled: isCanceled,
                    startDateTime: startDateTime,
                    endDateTime: endDateTime,
                    removeStartDateTime: startDateTime == null,
                    removeEndDateTime: endDateTime == null));
              }
              if (Modular.to.canPop() && !widget.isDesktop) Modular.to.pop();
            }),
        body: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              constraints: const BoxConstraints(maxWidth: 800),
              child: TabBarView(controller: _tabController, children: [
                Column(children: [
                  Expanded(
                      child: SingleChildScrollView(
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
                                onChanged: (value) =>
                                    setState(() => account = value),
                                items: [
                                  ...Hive.box('accounts').values.map((e) =>
                                      DropdownMenuItem(
                                          child: Text(e), value: e)),
                                  ...users
                                      .map((e) => Account.fromLocalUser(e))
                                      .map((e) => DropdownMenuItem(
                                          child: Text(e.toString()), value: e))
                                ]);
                          });
                    }),
                    const SizedBox(height: 50),
                    TextField(
                        decoration: const InputDecoration(
                            filled: true,
                            labelText: "Name",
                            icon: Icon(PhosphorIcons.calendarLight)),
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
                    if (event != null) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      ),
                      ListTile(
                          leading: const Icon(PhosphorIcons.compassLight),
                          title: const Text("Assign"),
                          onTap: () async {
                            var assigned = await showDialog(
                                context: context,
                                builder: (context) =>
                                    AssignDialog(assigned: event.assigned));
                            if (assigned != null) {
                              service.updateEvent(
                                  event.copyWith(assigned: assigned));
                            }
                          })
                    ]
                  ])))
                ]),
                Column(children: [
                  const SizedBox(height: 20),
                  Row(children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DateInputField(
                          label: "Start date",
                          initialDate: startDateTime,
                          onChanged: (dateTime) => startDateTime = dateTime),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TimeInputField(
                          label: "Start time",
                          initialTime: startDateTime != null
                              ? TimeOfDay.fromDateTime(startDateTime!)
                              : null,
                          onChanged: (time) {
                            var oldDate = startDateTime ?? DateTime.now();
                            startDateTime = DateTime(
                                oldDate.year,
                                oldDate.month,
                                oldDate.day,
                                time?.hour ?? 0,
                                time?.minute ?? 0);
                          }),
                    ))
                  ]),
                  const SizedBox(height: 20),
                  Row(children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DateInputField(
                          label: "End date",
                          initialDate: endDateTime,
                          onChanged: (dateTime) => endDateTime = dateTime),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TimeInputField(
                          label: "End time",
                          initialTime: endDateTime != null
                              ? TimeOfDay.fromDateTime(endDateTime!)
                              : null,
                          onChanged: (time) {
                            var oldDate = endDateTime ?? DateTime.now();
                            endDateTime = DateTime(
                                oldDate.year,
                                oldDate.month,
                                oldDate.day,
                                time?.hour ?? 0,
                                time?.minute ?? 0);
                          }),
                    ))
                  ]),
                  if (event != null) ...[
                    const SizedBox(height: 20),
                    StatefulBuilder(builder: (context, setState) {
                      return CheckboxListTile(
                          value: isCanceled,
                          onChanged: (value) =>
                              setState(() => isCanceled = value ?? isCanceled),
                          title: const Text("Canceled"),
                          subtitle:
                              const Text("Check if the event is canceled"),
                          controlAffinity: ListTileControlAffinity.leading);
                    })
                  ]
                ])
              ]),
            )));
  }
}
