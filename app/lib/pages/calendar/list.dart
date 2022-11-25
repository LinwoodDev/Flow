import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/event.dart';
import 'package:flow/pages/calendar/event.dart';
import 'package:flow/pages/calendar/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/helpers/date_time.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalendarListView extends StatefulWidget {
  final CalendarFilter filter;
  final String search;
  final PagingController<int, List<MapEntry<String, Event>>> controller;
  final ValueChanged<CalendarFilter> onFilterChanged;

  const CalendarListView({
    super.key,
    required this.controller,
    required this.onFilterChanged,
    required this.filter,
    required this.search,
  });

  @override
  State<CalendarListView> createState() => _CalendarListViewState();
}

class _CalendarListViewState extends State<CalendarListView> {
  @override
  void initState() {
    super.initState();
    widget.controller.addPageRequestListener(_requestPage);
  }

  @override
  void dispose() {
    widget.controller.removePageRequestListener(_requestPage);
    super.dispose();
  }

  Future<void> _requestPage(int key) async {
    final events = await _fetchEvents(key);
    if (mounted) widget.controller.appendPage([events], key + 1);
  }

  Future<List<MapEntry<String, Event>>> _fetchEvents(int day) async {
    if (!mounted) return [];
    var date = DateTime.now().onlyDate();
    if (widget.filter.past) {
      date = date.subtract(Duration(days: day));
    } else {
      date = date.add(Duration(days: day));
    }

    final cubit = context.read<FlowCubit>();
    var sources = cubit.getCurrentServicesMap();
    if (widget.filter.source != null) {
      sources = {widget.filter.source!: cubit.getSource(widget.filter.source!)};
    }
    final events = <MapEntry<String, Event>>[];
    for (final source in sources.entries) {
      final fetched = await source.value.event.getEvents(
        date: date,
        status: EventStatus.values
            .where((element) => !widget.filter.hiddenStatuses.contains(element))
            .toList(),
        search: widget.search,
        groupId: widget.filter.group,
      );
      events.addAll(fetched.map((event) => MapEntry(source.key, event)));
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final dateFormatter = DateFormat.yMMMMd(locale);
    return Column(
      children: [
        CalendarFilterView(
          initialFilter: widget.filter,
          onChanged: widget.onFilterChanged,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => PagedListView(
              pagingController: widget.controller,
              builderDelegate:
                  PagedChildBuilderDelegate<List<MapEntry<String, Event>>>(
                itemBuilder: (context, item, index) {
                  var date = DateTime.now().onlyDate();
                  if (widget.filter.past) {
                    date = date.subtract(Duration(days: index));
                  } else {
                    date = date.add(Duration(days: index));
                  }
                  final header = Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 64,
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        if (index == 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Icon(
                              Icons.today_outlined,
                              color: Theme.of(context).primaryColor,
                              size: 64,
                            ),
                          ),
                        Text(
                          dateFormatter.format(date),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  );
                  final list = Column(
                    children: [
                      if (item.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            AppLocalizations.of(context)!.noEvents,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ...item.map((event) {
                        return _CalendarListTile(
                          key: ValueKey(event.key + event.value.id.toString()),
                          event: event.value,
                          source: event.key,
                          date: date,
                          onRefresh: widget.controller.refresh,
                        );
                      }),
                    ],
                  );
                  final isMobile = constraints.maxWidth < 800;
                  return Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: isMobile
                            ? Column(
                                children: [
                                  header,
                                  list,
                                ],
                              )
                            : Row(
                                children: [
                                  header,
                                  const SizedBox(width: 16),
                                  Expanded(child: list),
                                ],
                              )),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CalendarListTile extends StatelessWidget {
  final Event event;
  final String source;
  final DateTime date;
  final VoidCallback onRefresh;

  const _CalendarListTile({
    super.key,
    required this.event,
    required this.source,
    required this.date,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final timeFormatter = DateFormat.Hm(locale);
    final start = event.start?.onlyDate() == date && event.start != null
        ? timeFormatter.format(event.start!)
        : '';
    final end = event.end?.onlyDate() == date && event.end != null
        ? timeFormatter.format(event.end!)
        : '';
    String range;
    if (start == '' && end == '') {
      range = '';
    } else if (start == '') {
      range = ' - $end';
    } else if (end == '') {
      range = '$start -';
    } else {
      range = '$start - $end';
    }
    return ListTile(
      title: Text(event.name),
      subtitle: Text(range),
      leading: Icon(event.status.getIcon(), color: event.status.getColor()),
      onTap: () => showDialog(
              context: context,
              builder: (context) => EventDialog(event: event, source: source))
          .then((_) => onRefresh()),
      trailing: FutureBuilder<bool?>(
        future: Future.value(context
            .read<FlowCubit>()
            .getSource(source)
            .todo
            .todosDone(event.id)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Icon(
              snapshot.data!
                  ? Icons.check_circle_outline_outlined
                  : Icons.circle_outlined,
              color: snapshot.data ?? false
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
