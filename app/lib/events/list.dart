import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/event.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/services/local_service.dart';

import 'details.dart';

class EventsListView extends StatefulWidget {
  const EventsListView({Key? key}) : super(key: key);

  @override
  _EventsListViewState createState() => _EventsListViewState();
}

class _EventsListViewState extends State<EventsListView> {
  late ApiService service;
  Event? selected;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var isDesktop = MediaQuery.of(context).size.width > 1000;
      return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            if (isDesktop) ...[
              Expanded(
                  flex: 2,
                  child: EventPage(isDesktop: isDesktop, id: selected?.id)),
              const VerticalDivider()
            ],
            Expanded(
                flex: 3,
                child: Scaffold(
                    floatingActionButton: selected == null && isDesktop
                        ? null
                        : FloatingActionButton.extended(
                            label: const Text("Create event"),
                            icon: const Icon(PhosphorIcons.plusLight),
                            onPressed: () => isDesktop
                                ? setState(() => selected = null)
                                : Modular.to.pushNamed("/events/create")),
                    body: Scrollbar(
                        child: SingleChildScrollView(
                            child: Builder(
                      builder: (context) => StreamBuilder<List<Event>>(
                          stream: service.onEvents(),
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
                            var events = snapshot.data!;
                            return Column(
                                children: List.generate(events.length, (index) {
                              var event = events[index];
                              return Dismissible(
                                key: Key(event.id!.toString()),
                                onDismissed: (direction) {
                                  service.deleteEvent(event.id!);
                                },
                                background: Container(color: Colors.red),
                                child: ListTile(
                                    title: Text(event.name),
                                    selected: selected?.id == event.id,
                                    onTap: () => isDesktop
                                        ? setState(() => selected = event)
                                        : Modular.to.pushNamed(Uri(
                                            pathSegments: [
                                                "",
                                                "events",
                                                "details"
                                              ],
                                            queryParameters: {
                                                "id": event.id.toString()
                                              }).toString())),
                              );
                            }));
                          }),
                    )))))
          ]);
    });
  }
}
