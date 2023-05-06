import 'package:flow/pages/calendar/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/event/item/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/markdown_field.dart';

class DashboardEventsCard extends StatefulWidget {
  const DashboardEventsCard({super.key});

  @override
  State<DashboardEventsCard> createState() => _DashboardEventsCardState();
}

class _DashboardEventsCardState extends State<DashboardEventsCard> {
  Future<List<SourcedConnectedModel<CalendarItem, Event?>>> _getAppointments(
      BuildContext context) async {
    final sources = context.read<FlowCubit>().getCurrentServicesMap();
    final appointments = <SourcedConnectedModel<CalendarItem, Event?>>[];
    for (final source in sources.entries) {
      appointments.addAll((await source.value.calendarItem
                  ?.getCalendarItems(date: DateTime.now()) ??
              [])
          .map((e) => SourcedModel(source.key, e)));
    }
    return appointments;
  }

  @override
  void didUpdateWidget(covariant DashboardEventsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context).events,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.arrowSquareOut),
              onPressed: () => GoRouter.of(context).go('/calendar'),
            )
          ],
        ),
        const SizedBox(height: 20),
        FutureBuilder<List<SourcedConnectedModel<CalendarItem, Event?>>>(
            future: _getAppointments(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              final appointments = snapshot.data!;
              return Column(
                children: appointments
                    .map((e) => ListTile(
                          title: Text(e.main.name),
                          subtitle: MarkdownText(e.main.description),
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) => CalendarItemDialog(
                                    event: e.sub,
                                    item: e.main,
                                    source: e.source,
                                  )).then((value) => setState(() {})),
                        ))
                    .toList(),
              );
            })
      ],
    );
  }
}
