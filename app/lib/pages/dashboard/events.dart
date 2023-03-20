import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/models/event/model.dart';

import '../../cubits/flow.dart';

class DashboardEventsCard extends StatelessWidget {
  const DashboardEventsCard({Key? key}) : super(key: key);

  Future<List<Appointment>> _getAppointment(BuildContext context) async {
    final sources = context.read<FlowCubit>().getCurrentServices();
    final appointments = <Appointment>[];
    for (final source in sources) {
      appointments.addAll(
          await source.appointment?.getAppointments(date: DateTime.now()) ??
              []);
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
        FutureBuilder<List<Appointment>>(
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
                          title: Text(e.name),
                          subtitle: Text(e.description),
                        ))
                    .toList(),
              );
            })
      ],
    );
  }
}
