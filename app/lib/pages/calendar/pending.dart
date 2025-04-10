import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/model.dart';

import '../../cubits/flow.dart';
import 'filter.dart';
import 'page.dart';
import 'tile.dart';

class CalendarPendingView extends StatefulWidget {
  final CalendarFilter filter;
  final String search;
  final ValueChanged<CalendarFilter> onFilterChanged;

  const CalendarPendingView({
    super.key,
    required this.filter,
    this.search = '',
    required this.onFilterChanged,
  });

  @override
  State<CalendarPendingView> createState() => _CalendarPendingViewState();
}

class _CalendarPendingViewState extends State<CalendarPendingView> {
  late FlowCubit _cubit;
  late final SourcedPagingBloc<ConnectedModel<CalendarItem, Event?>> _bloc;
  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _bloc = SourcedPagingBloc.item(
        cubit: _cubit,
        fetch: (source, service, offset, limit) async =>
            service.calendarItem?.getCalendarItems(
              status: EventStatus.values
                  .where((element) =>
                      !widget.filter.hiddenStatuses.contains(element))
                  .toList(),
              search: widget.search,
              pending: true,
              offset: offset,
              limit: limit,
              resourceIds: widget.filter.resources,
            ));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CalendarPendingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filter != oldWidget.filter) {
      _bloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CreateEventScaffold(
      onCreated: _bloc.refresh,
      event: widget.filter.sourceEvent,
      child: Column(
        children: [
          CalendarFilterView(
            initialFilter: widget.filter,
            onChanged: widget.onFilterChanged,
            past: false,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) =>
                  PagedListView<ConnectedModel<CalendarItem, Event?>>.item(
                bloc: _bloc,
                itemBuilder: (context, item, index) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: CalendarListTile(
                      key: ValueKey('${item.source}@${item.main.id}'),
                      eventItem: item,
                      onRefresh: _bloc.refresh,
                    ),
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
