import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/calendar/filter.dart';
import 'package:flow/pages/calendar/list.dart';
import 'package:flow/pages/calendar/pending.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';

import 'event.dart';

class CalendarPage extends StatefulWidget {
  final CalendarFilter filter;
  const CalendarPage({
    super.key,
    this.filter = const CalendarFilter(),
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

enum _CalendarView { list, day, week, month, pending }

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
      case _CalendarView.pending:
        return AppLocalizations.of(context)!.pending;
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
      case _CalendarView.pending:
        return Icons.pending_actions;
    }
  }
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  _CalendarView _calendarView = _CalendarView.list;
  final PagingController<int, List<MapEntry<String, Event>>> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context)!.calendar,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () =>
              showSearch(context: context, delegate: _CalendarSearchDelegate()),
        ),
        PopupMenuButton<_CalendarView>(
          icon: Icon(_calendarView.getIcon()),
          initialValue: _calendarView,
          onSelected: (value) {
            setState(() {
              _calendarView = value;
            });
            _pagingController.refresh();
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
      body: CalendarBodyView(
        pagingController: _pagingController,
        filter: widget.filter,
        view: _calendarView,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
                context: context, builder: (context) => const EventDialog())
            .then((value) => _pagingController.refresh()),
        label: Text(AppLocalizations.of(context)!.create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}

class _CalendarSearchDelegate extends SearchDelegate {
  final PagingController<int, List<MapEntry<String, Event>>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _pagingController.refresh();
    return CalendarBodyView(
      pagingController: _pagingController,
      search: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class CalendarBodyView extends StatefulWidget {
  final String search;
  final _CalendarView view;
  final CalendarFilter filter;
  final PagingController<int, List<MapEntry<String, Event>>> pagingController;
  const CalendarBodyView(
      {super.key,
      this.search = '',
      this.filter = const CalendarFilter(),
      this.view = _CalendarView.list,
      required this.pagingController});

  @override
  State<CalendarBodyView> createState() => _CalendarBodyViewState();
}

class _CalendarBodyViewState extends State<CalendarBodyView> {
  late CalendarFilter _filter;

  @override
  void initState() {
    super.initState();

    _filter = widget.filter;
  }

  @override
  void didUpdateWidget(covariant CalendarBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      widget.pagingController.refresh();
    } else if (oldWidget.view != widget.view) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlowCubit, FlowState>(builder: (context, state) {
      switch (widget.view) {
        case _CalendarView.pending:
          return CalendarPendingView(
            filter: _filter,
            controller: widget.pagingController,
            onFilterChanged: _onFilterChanged,
          );
        default:
          return CalendarListView(
            controller: widget.pagingController,
            search: widget.search,
            onFilterChanged: _onFilterChanged,
            filter: _filter,
          );
      }
    });
  }

  void _onFilterChanged(value) {
    setState(() => _filter = value);
    widget.pagingController.refresh();
  }
}
