import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/item/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../../helpers/sourced_paging_controller.dart';
import '../../widgets/builder_delegate.dart';
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
  late final SourcedPagingController<ConnectedModel<CalendarItem, Event?>>
      _controller;
  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _controller = SourcedPagingController(_cubit);
    _controller.addFetchListener((source, service, offset, limit) async =>
        service.calendarItem?.getCalendarItems(
          status: EventStatus.values
              .where(
                  (element) => !widget.filter.hiddenStatuses.contains(element))
              .toList(),
          search: widget.search,
          pending: true,
          offset: offset,
          limit: limit,
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CalendarPendingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filter != oldWidget.filter) {
      _controller.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CreateEventScaffold(
      onCreated: _controller.refresh,
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
              builder: (context, constraints) => PagedListView(
                pagingController: _controller,
                builderDelegate: buildMaterialPagedDelegate<
                    SourcedConnectedModel<CalendarItem, Event?>>(
                  _controller,
                  (context, item, index) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: CalendarListTile(
                        key: ValueKey('${item.source}@${item.main.id}'),
                        eventItem: item,
                        onRefresh: _controller.refresh,
                      ),
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
