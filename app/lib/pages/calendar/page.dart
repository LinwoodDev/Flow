import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/calendar/filter.dart';
import 'package:flow/pages/calendar/list.dart';
import 'package:flow/pages/calendar/pending.dart';
import 'package:flow/widgets/material_bottom_sheet.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';

import '../../widgets/builder_delegate.dart';
import 'day.dart';
import 'event.dart';
import 'month.dart';
import 'week.dart';

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
        return AppLocalizations.of(context).list;
      case _CalendarView.day:
        return AppLocalizations.of(context).day;
      case _CalendarView.week:
        return AppLocalizations.of(context).week;
      case _CalendarView.month:
        return AppLocalizations.of(context).month;
      case _CalendarView.pending:
        return AppLocalizations.of(context).pending;
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

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).calendar,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () => showSearch(
              context: context,
              delegate: _CalendarSearchDelegate(_calendarView)),
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
      body: CalendarBodyView(
        filter: widget.filter,
        view: _calendarView,
      ),
    );
  }
}

class _CalendarSearchDelegate extends SearchDelegate {
  final _CalendarView view;

  _CalendarSearchDelegate(this.view);

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
    return CalendarBodyView(
      search: query,
      view: view,
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
  const CalendarBodyView({
    super.key,
    this.search = '',
    this.filter = const CalendarFilter(),
    this.view = _CalendarView.list,
  });

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

    if (oldWidget.view != widget.view) {
      setState(() {});
    }
  }

  Widget _getView() {
    switch (widget.view) {
      case _CalendarView.pending:
        return CalendarPendingView(
          filter: _filter,
          onFilterChanged: _onFilterChanged,
          search: widget.search,
        );
      case _CalendarView.day:
        return CalendarDayView(
          filter: _filter,
          onFilterChanged: _onFilterChanged,
          search: widget.search,
        );
      case _CalendarView.week:
        return CalendarWeekView(
          filter: _filter,
          onFilterChanged: _onFilterChanged,
          search: widget.search,
        );
      case _CalendarView.month:
        return CalendarMonthView(
          filter: _filter,
          onFilterChanged: _onFilterChanged,
          search: widget.search,
        );
      default:
        return CalendarListView(
          search: widget.search,
          onFilterChanged: _onFilterChanged,
          filter: _filter,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlowCubit, FlowState>(builder: (context, state) {
      return _getView();
    });
  }

  void _onFilterChanged(value) {
    setState(() {
      _filter = value;
    });
  }
}

class CreateEventScaffold extends StatelessWidget {
  final void Function(Event?) onCreated;
  final Widget child;
  const CreateEventScaffold({
    super.key,
    required this.onCreated,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    void create(Event? event) {
      onCreated(event);
      if (event == null) return;
      showMaterialBottomSheet(
        context: context,
        title: AppLocalizations.of(context).create,
        childrenBuilder: (ctx) => [
          ListTile(
            title: Text(AppLocalizations.of(context).appointment),
            leading: const Icon(Icons.event_outlined),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).moment),
            leading: const Icon(Icons.mood_outlined),
          ),
        ],
      );
    }

    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            showEventModalBottomSheet(context: context).then(create),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}

Future<Event?> showEventModalBottomSheet(
    {required BuildContext context, Event? event}) async {
  Event? event;
  final pagingController = PagingController<int, Event>(
    firstPageKey: 0,
  );
  final shouldCreate = await showMaterialBottomSheet<bool>(
      context: context,
      title: AppLocalizations.of(context).events,
      actionsBuilder: (ctx) => [
            TextButton.icon(
              icon: const Icon(Icons.add_circle_outline_outlined),
              label: Text(AppLocalizations.of(context).create),
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
            ),
          ],
      childrenBuilder: (ctx) => [
            PagedListView(
                shrinkWrap: true,
                pagingController: pagingController,
                builderDelegate: buildMaterialPagedDelegate<Event>(
                  pagingController,
                  (ctx, item, index) {
                    return ListTile(
                      title: Text(item.name),
                      leading: const Icon(Icons.event_outlined),
                      onTap: () {
                        event = item;
                        Navigator.of(ctx).pop();
                      },
                    );
                  },
                )),
          ]);
  if (shouldCreate == true && context.mounted) {
    event = await showDialog(
      context: context,
      builder: (ctx) => EventDialog(
        event: event,
      ),
    );
  }
  return event;
}
