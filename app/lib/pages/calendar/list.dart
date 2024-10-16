import 'package:flow/cubits/flow.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  late final PagingController<
      ConnectedModel<int, ConnectedModel<Map<String, int>, Map<String, int>>>,
      List<SourcedConnectedModel<CalendarItem, Event?>>> _controller;
  static const _pageSize = 50;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _controller = PagingController(
        firstPageKey: const ConnectedModel(-1, ConnectedModel({}, {})));
    _controller.addPageRequestListener(_requestPage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _requestPage(
      ConnectedModel<int, ConnectedModel<Map<String, int>, Map<String, int>>>
          key) async {
    var day = key.source;
    var sources = key.model;
    final allSources = widget.filter.source != null
        ? [
            widget.filter.source!,
          ]
        : _cubit.getCurrentSources();

    ConnectedModel<Map<String, int>, Map<String, int>> createFullSourceMap() {
      final map = Map.fromEntries(allSources.map((e) => MapEntry(e, 0)));
      return ConnectedModel(map, Map.from(map));
    }

    if (day < 0) {
      day = 0;
      sources = createFullSourceMap();
    }
    var appointmentSource = sources.source;
    var items = <SourcedConnectedModel<CalendarItem, Event?>>[];
    if (appointmentSource.isNotEmpty) {
      final model = await _fetchCalendarItems(day, appointmentSource);
      items.addAll(model.source);
      appointmentSource.removeWhere((key, value) => !model.model.contains(key));
    }
    if (appointmentSource.isEmpty) {
      day++;
      sources = createFullSourceMap();
    }
    if (mounted) {
      _controller.appendPage([items], ConnectedModel(day, sources));
    }
  }

  Future<
      ConnectedModel<List<SourcedConnectedModel<CalendarItem, Event?>>,
          List<String>>> _fetchCalendarItems(
      int day, Map<String, int> sources) async {
    if (!mounted) return ConnectedModel([], sources.keys.toList());
    var date = DateTime.now().onlyDate();
    if (widget.filter.past) {
      date = date.subtract(Duration(days: day));
    } else {
      date = date.add(Duration(days: day));
    }

    if (!mounted) return ConnectedModel([], sources.keys.toList());

    final appointments = <SourcedConnectedModel<CalendarItem, Event?>>[];
    final nextSources = <String>[];
    for (final source in sources.entries) {
      final fetched =
          await _cubit.getService(source.key).calendarItem?.getCalendarItems(
                date: date,
                status: EventStatus.values
                    .where((element) =>
                        !widget.filter.hiddenStatuses.contains(element))
                    .toList(),
                search: widget.search,
                groupId: widget.filter.group,
                placeId: widget.filter.place,
                eventId: widget.filter.event,
                offset: source.value * _pageSize,
                limit: _pageSize,
              );
      if (fetched == null) continue;
      appointments
          .addAll(fetched.map((event) => SourcedModel(source.key, event)));
      if (fetched.length >= _pageSize) {
        nextSources.add(source.key);
      }
    }
    return ConnectedModel(appointments, nextSources);
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
      onCreated: _controller.refresh,
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
              builder: (context, constraints) => PagedListView(
                pagingController: _controller,
                builderDelegate: buildMaterialPagedDelegate<
                    List<SourcedConnectedModel<CalendarItem, Event?>>>(
                  _controller,
                  (context, item, index) {
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
                        if (item.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              AppLocalizations.of(context).noEvents,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ...item.map((event) {
                          return CalendarListTile(
                            key: ValueKey([
                              event.main.id,
                              event.source,
                              event.main.runtimeType
                            ]),
                            eventItem: event,
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
                          child: GestureDetector(
                            onTap: () => showCalendarCreate(
                              context: context,
                              time: date,
                              event: widget.filter.sourceEvent,
                            ).then((value) => _controller.refresh()),
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
          ),
        ],
      ),
    );
  }
}
