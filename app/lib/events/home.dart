import 'package:flow_app/services/api_service.dart';
import 'package:flow_app/services/local_service.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/event.dart';

import 'details.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Event? selected = null;
  late ApiService service;
  late Stream<List<Event>> eventStream;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>();
    eventStream = service.onEvents();
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.events,
        pageTitle: "Events",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                if (isDesktop) ...[
                  Expanded(flex: 2, child: EventPage(isDesktop: isDesktop, id: selected?.id)),
                  VerticalDivider()
                ],
                Expanded(
                    flex: 3,
                    child: Scaffold(
                        floatingActionButton: selected == null
                            ? null
                            : FloatingActionButton.extended(
                                label: Text("Create event"),
                                icon: Icon(PhosphorIcons.plusLight),
                                onPressed: () => isDesktop
                                    ? setState(() => selected = null)
                                    : Modular.to.pushNamed("/events/create")),
                        body: Scrollbar(
                            child: SingleChildScrollView(
                                child: StreamBuilder<List<Event>>(
                                    stream: eventStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) return Text("Error ${snapshot.error}");
                                      if (snapshot.connectionState == ConnectionState.waiting ||
                                          !snapshot.hasData)
                                        return Center(child: CircularProgressIndicator());
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
                                                  : Modular.to.pushNamed(Uri(pathSegments: [
                                                      "",
                                                      "events",
                                                      "details"
                                                    ], queryParameters: {
                                                      "id": event.id.toString()
                                                    }).toString())),
                                        );
                                      }));
                                    })))))
              ]);
        }));
  }
}
