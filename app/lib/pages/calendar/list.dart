import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/calendar/filter.dart';
import 'package:flow/pages/calendar/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/helpers/date_time.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'tile.dart';

class CalendarListView extends StatefulWidget {
  final CalendarFilter filter;
  final String search;
  final ValueChanged<CalendarFilter> onFilterChanged;

  const CalendarListView({
    super.key,
    required this.onFilterChanged,
    required this.filter,
    required this.search,
  });

  @override
  State<CalendarListView> createState() => _CalendarListViewState();
}

class _CalendarListViewState extends State<CalendarListView> {
  late FlowCubit _cubit;
  final PagingController<int, List<MapEntry<String, Event>>> _controller =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _controller.addPageRequestListener(_requestPage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _requestPage(int key) async {
    final events = await _fetchEvents(key);
    if (mounted) _controller.appendPage([events], key + 1);
  }

  Future<List<MapEntry<String, Event>>> _fetchEvents(int day) async {
    if (!mounted) return [];
    var date = DateTime.now().onlyDate();
    if (widget.filter.past) {
      date = date.subtract(Duration(days: day));
    } else {
      date = date.add(Duration(days: day));
    }

    if (!mounted) return [];

    var sources = _cubit.getCurrentServicesMap();
    if (widget.filter.source != null) {
      sources = {
        widget.filter.source!: _cubit.getSource(widget.filter.source!)
      };
    }
    final events = <MapEntry<String, Event>>[];
    for (final source in sources.entries) {
      final fetched = await source.value.event.getEvents(
        date: date,
        status: EventStatus.values
            .where((element) => !widget.filter.hiddenStatuses.contains(element))
            .toList(),
        search: widget.search,
        groupId:
            source.key == widget.filter.source ? widget.filter.group : null,
        placeId:
            source.key == widget.filter.source ? widget.filter.place : null,
      );
      events.addAll(fetched.map((event) => MapEntry(source.key, event)));
    }
    return events;
  }

  @override
  void didUpdateWidget(covariant CalendarListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filter != widget.filter) {
      _controller.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final dateFormatter = DateFormat.yMMMMd(locale);
    return CreateEventScaffold(
      onCreated: (p0) => _controller.refresh(),
      child: Column(
        children: [
          CalendarFilterView(
            initialFilter: widget.filter,
            onChanged: (value) => widget.onFilterChanged(value),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => PagedListView(
                pagingController: _controller,
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
                                color: Theme.of(context).colorScheme.secondary,
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
                          return CalendarListTile(
                            key: ValueKey('${event.key}@${event.value.id}'),
                            event: event.value,
                            source: event.key,
                            date: date,
                            onRefresh: _controller.refresh,
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
      ),
    );
  }
}
