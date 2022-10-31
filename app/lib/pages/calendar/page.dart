import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/calendar/create.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/event/model.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

enum _CalendarView { list, day, week, month }

extension _CalendarViewExtension on _CalendarView {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case _CalendarView.list:
        return AppLocalizations.of(context)!.list;
      case _CalendarView.day:
        return AppLocalizations.of(context)!.day;
      case _CalendarView.week:
        return AppLocalizations.of(context)!.week;
      case _CalendarView.month:
        return AppLocalizations.of(context)!.month;
    }
  }

  IconData getIcon() {
    switch (this) {
      case _CalendarView.list:
        return Icons.list;
      case _CalendarView.day:
        return Icons.calendar_today;
      case _CalendarView.week:
        return Icons.calendar_view_week;
      case _CalendarView.month:
        return Icons.calendar_view_month;
    }
  }
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  _CalendarView _calendarView = _CalendarView.list;

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context)!.calendar,
      selected: "calendar",
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () {},
        ),
        PopupMenuButton<_CalendarView>(
          icon: Icon(_calendarView.getIcon()),
          initialValue: _calendarView,
          onSelected: (value) {
            setState(() {
              _calendarView = value;
            });
          },
          itemBuilder: (context) => _CalendarView.values
              .map((e) => PopupMenuItem(
                  value: e,
                  child: Row(
                    children: [
                      Icon(e.getIcon()),
                      const SizedBox(width: 8),
                      Text(e.getLocalizedName(context)),
                    ],
                  )))
              .toList(),
        ),
      ],
      body: BlocBuilder<FlowCubit, FlowState>(
          builder: (context, state) => FutureBuilder<List<Event>>(
                future: Future.wait(context
                        .read<FlowCubit>()
                        .getCurrentServices()
                        .map((e) async => await e.event.getEvents()))
                    .then(
                        (value) => value.expand((element) => element).toList()),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].description),
                    ),
                  );
                },
              )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
            context: context, builder: (context) => CreateEventDialog()),
        label: Text(AppLocalizations.of(context)!.create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}
