import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flow_api/services/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow_api/models/model.dart';

import 'filter.dart';
import 'page.dart';
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
  late final SourcedPagingBloc<ConnectedModel<CalendarItem, Event?>> _bloc;
  static const _pageSize = 50;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _bloc = SourcedPagingBloc.dated(
      cubit: _cubit,
      fetch: _fetchCalendarItems,
      pageSize: _pageSize,
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  Future<List<ConnectedModel<CalendarItem, Event?>>> _fetchCalendarItems(
    String source,
    SourceService service,
    int offset,
    int limit,
    int date,
  ) async {
    var dateTime = DateTime.now().onlyDate();
    if (widget.filter.past) {
      dateTime = dateTime.subtract(Duration(days: date));
    } else {
      dateTime = dateTime.add(Duration(days: date));
    }

    return await service.calendarItem?.getCalendarItems(
          date: dateTime,
          status: EventStatus.values
              .where(
                  (element) => !widget.filter.hiddenStatuses.contains(element))
              .toList(),
          search: widget.search,
          groupIds: widget.filter.groups,
          eventId: widget.filter.event,
          offset: offset * _pageSize,
          limit: _pageSize,
          resourceIds: widget.filter.resources,
        ) ??
        const [];
  }

  @override
  void didUpdateWidget(covariant CalendarListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filter != widget.filter) {
      _bloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final dateFormatter = DateFormat.yMMMMd(locale);
    return CreateEventScaffold(
      onCreated: _bloc.refresh,
      event: widget.filter.sourceEvent,
      child: Column(
        children: [
          CalendarFilterView(
            initialFilter: widget.filter,
            onChanged: (value) => widget.onFilterChanged(value),
            past: true,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => PagedListView.dated(
                bloc: _bloc,
                dateBuilder: (context, items, index) {
                  var date = DateTime.now();
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
                            child: PhosphorIcon(
                              PhosphorIconsLight.calendarBlank,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 64,
                            ),
                          ),
                        Text(
                          dateFormatter.format(date),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          DateFormat.EEEE(locale).format(date),
                        ),
                      ],
                    ),
                  );
                  final list = Column(
                    children: [
                      if (items.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            AppLocalizations.of(context).noEvents,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ...items.map((event) {
                        return CalendarListTile(
                          key: ValueKey([
                            event.main.id,
                            event.source,
                            event.main.runtimeType
                          ]),
                          eventItem: event,
                          date: date,
                          onRefresh: _bloc.refresh,
                        );
                      }),
                    ],
                  );
                  final isMobile = constraints.maxWidth < 800;
                  return Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: GestureDetector(
                          onTap: () => showCalendarCreate(
                            context: context,
                            time: date,
                            event: widget.filter.sourceEvent,
                          ).then((value) => _bloc.refresh()),
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
                                ),
                        )),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
