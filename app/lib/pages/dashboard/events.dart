import 'package:flow/pages/calendar/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/markdown_field.dart';
import '../../widgets/paging/error.dart';

class DashboardEventsView extends StatefulWidget {
  const DashboardEventsView({super.key});

  @override
  State<DashboardEventsView> createState() => _DashboardEventsViewState();
}

class _DashboardEventsViewState extends State<DashboardEventsView> {
  late Future<List<SourcedConnectedModel<CalendarItem, Event?>>>
  _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _appointmentsFuture = _getAppointments();
  }

  Future<List<SourcedConnectedModel<CalendarItem, Event?>>>
  _getAppointments() async {
    final sources = context.read<FlowCubit>().getCurrentServicesMap();
    final appointments = <SourcedConnectedModel<CalendarItem, Event?>>[];
    for (final source in sources.entries) {
      appointments.addAll(
        (await source.value.calendarItem?.getCalendarItems(
                  date: DateTime.now(),
                ) ??
                [])
            .map((e) => SourcedModel(source.key, e)),
      );
    }
    appointments.sort((a, b) {
      final aStart = a.main.start;
      final bStart = b.main.start;
      if (aStart == null && bStart != null) return 1;
      if (aStart != null && bStart == null) return -1;
      final startComparison = aStart?.compareTo(bStart!) ?? 0;
      if (startComparison != 0) return startComparison;
      return a.main.name.compareTo(b.main.name);
    });
    return appointments;
  }

  void _refresh() {
    if (!mounted) return;
    setState(() => _appointmentsFuture = _getAppointments());
  }

  @override
  void didUpdateWidget(covariant DashboardEventsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _appointmentsFuture = _getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              tooltip: AppLocalizations.of(context).refresh,
              icon: const PhosphorIcon(PhosphorIconsLight.arrowClockwise),
              onPressed: _refresh,
            ),
            IconButton(
              tooltip: AppLocalizations.of(context).calendar,
              icon: const PhosphorIcon(PhosphorIconsLight.arrowSquareOut),
              onPressed: () => GoRouter.of(context).go('/calendar'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child:
              FutureBuilder<List<SourcedConnectedModel<CalendarItem, Event?>>>(
                future: _appointmentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return ErrorIndicatorDisplay(onTryAgain: _refresh);
                  }
                  final appointments =
                      snapshot.data ??
                      <SourcedConnectedModel<CalendarItem, Event?>>[];
                  if (appointments.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).indicatorEmpty,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                  return ListView(
                    children: appointments
                        .map(
                          (e) => ListTile(
                            title: Text(e.main.name),
                            subtitle: MarkdownText(e.main.description),
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) => CalendarItemDialog(
                                event: e.sub,
                                item: e.main,
                                source: e.source,
                              ),
                            ).then((value) => _refresh()),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
        ),
      ],
    );
  }
}
