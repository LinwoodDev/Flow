import 'package:flow_app/events/details.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/event.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int? selected = null;
  final List<Event> events = [Event("Event 1"), Event("Event 2"), Event("Event 3")];

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.events,
        pageTitle: "Events",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 3,
              child: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                    label: Text("Create event"),
                    icon: Icon(PhosphorIcons.plusLight),
                    onPressed: () => Modular.to.pushNamed("/events/create")),
                body: Scrollbar(
                    child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                events.length,
                                (index) => ListTile(
                                    title: Text(events[index].name),
                                    selected: selected == index,
                                    onTap: () => isDesktop
                                        ? setState(() => selected = index)
                                        : Modular.to.pushNamed(Uri(
                                                pathSegments: ["", "events", "details"],
                                                queryParameters: {"id": index.toString()})
                                            .toString())))))),
              ),
            ),
            if (isDesktop) ...[
              VerticalDivider(),
              Expanded(
                  flex: 2,
                  child: selected == null
                      ? Center(child: Text("Nothing selected"))
                      : EventPage(event: events[selected!], isDesktop: isDesktop, id: selected!))
            ]
          ]);
        }));
  }
}
