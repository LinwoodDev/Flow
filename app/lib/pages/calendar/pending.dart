import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';

import '../../cubits/flow.dart';
import 'filter.dart';
import 'tile.dart';

class CalendarPendingView extends StatefulWidget {
  final CalendarFilter filter;
  final String search;
  final PagingController<int, List<MapEntry<String, Event>>> controller;
  final ValueChanged<CalendarFilter> onFilterChanged;

  const CalendarPendingView({
    super.key,
    required this.filter,
    this.search = '',
    required this.controller,
    required this.onFilterChanged,
  });

  @override
  State<CalendarPendingView> createState() => _CalendarPendingViewState();
}

class _CalendarPendingViewState extends State<CalendarPendingView> {
  static const _pageSize = 50;
  late FlowCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    widget.controller.addPageRequestListener(_requestPage);
    widget.controller.refresh();
  }

  @override
  void dispose() {
    widget.controller.removePageRequestListener(_requestPage);
    super.dispose();
  }

  Future<void> _requestPage(int key) async {
    final events = await _fetchEvents(key);
    if (mounted) {
      if (events.length < _pageSize) {
        widget.controller.appendLastPage([events]);
      } else {
        widget.controller.appendPage([events], key + 1);
      }
    }
  }

  Future<List<MapEntry<String, Event>>> _fetchEvents(int key) async {
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
        pending: true,
        status: EventStatus.values
            .where((element) => !widget.filter.hiddenStatuses.contains(element))
            .toList(),
        search: widget.search,
        offset: _pageSize * key,
        limit: _pageSize,
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
  void didUpdateWidget(covariant CalendarPendingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filter != oldWidget.filter) {
      widget.controller.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarFilterView(
          initialFilter: widget.filter,
          onChanged: widget.onFilterChanged,
          past: false,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => PagedListView(
              pagingController: widget.controller,
              builderDelegate:
                  PagedChildBuilderDelegate<List<MapEntry<String, Event>>>(
                itemBuilder: (context, item, index) {
                  return Column(
                    children: item
                        .map(
                          (e) => ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1000),
                            child: CalendarListTile(
                              key: ValueKey('${e.key}@${e.value.id}'),
                              event: e.value,
                              source: e.key,
                              onRefresh: widget.controller.refresh,
                            ),
                          ),
                        )
                        .toList(),
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
