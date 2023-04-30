import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/models/event/item/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';

class DashboardEventsCard extends StatelessWidget {
  const DashboardEventsCard({super.key});

  Future<List<SourcedConnectedModel<CalendarItem, Event?>>> _getAppointment(
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
              icon: const Icon(Icons.open_in_new_outlined),
              onPressed: () => GoRouter.of(context).go('/calendar'),
            )
          ],
        ),
        const SizedBox(height: 20),
        FutureBuilder<List<SourcedConnectedModel<CalendarItem, Event?>>>(
            future: _getAppointment(context),
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
                          subtitle: Text(e.main.description),
                        ))
                    .toList(),
              );
            })
      ],
    );
  }
}
