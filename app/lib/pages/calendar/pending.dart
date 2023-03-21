import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/appointment/model.dart';
import 'package:shared/models/event/model.dart';

import '../../cubits/flow.dart';
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
  static const _pageSize = 50;
  late FlowCubit _cubit;
  final PagingController<int, List<MapEntry<String, Appointment>>> _controller =
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
    final appointments = await _fetchAppointments(key);
    if (mounted) {
      if (appointments.length < _pageSize) {
        _controller.appendLastPage([appointments]);
      } else {
        _controller.appendPage([appointments], key + 1);
      }
    }
  }

  Future<List<MapEntry<String, Appointment>>> _fetchAppointments(
      int key) async {
    if (!mounted) return [];

    var sources = _cubit.getCurrentServicesMap();
    if (widget.filter.source != null) {
      sources = {
        widget.filter.source!: _cubit.getSource(widget.filter.source!)
      };
    }
    final appointments = <MapEntry<String, Appointment>>[];
    for (final source in sources.entries) {
      final fetched = await source.value.appointment?.getAppointments(
        status: EventStatus.values
            .where((element) => !widget.filter.hiddenStatuses.contains(element))
            .toList(),
        search: widget.search,
        offset: _pageSize * key,
        limit: _pageSize,
      );
      if (fetched == null) continue;
      appointments.addAll(
          fetched.map((appointment) => MapEntry(source.key, appointment)));
    }
    return appointments;
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
      onCreated: (p0) => _controller.refresh(),
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
                    List<MapEntry<String, Appointment>>>(
                  _controller,
                  (context, item, index) {
                    return Column(
                      children: item
                          .map(
                            (e) => ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1000),
                              child: CalendarListTile(
                                key: ValueKey('${e.key}@${e.value.id}'),
                                appointment: e.value,
                                source: e.key,
                                onRefresh: _controller.refresh,
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
      ),
    );
  }
}
