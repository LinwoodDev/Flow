import 'package:flow/cubits/flow.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lib5/lib5.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/model.dart';

import 'day.dart';
import 'filter.dart';
import 'item.dart';
import 'list.dart';
import 'month.dart';
import 'pending.dart';
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

  IconGetter get icon {
    switch (this) {
      case _CalendarView.list:
        return PhosphorIcons.list;
      case _CalendarView.day:
        return PhosphorIcons.calendar;
      case _CalendarView.week:
        return PhosphorIcons.columns;
      case _CalendarView.month:
        return PhosphorIcons.gridNine;
      case _CalendarView.pending:
        return PhosphorIcons.clock;
    }
  }
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  _CalendarView _calendarView = _CalendarView.list;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isSmall = constraints.maxWidth < 900;
      return FlowNavigation(
        title: AppLocalizations.of(context).calendar,
        actions: [
          if (isSmall) ...[
            MenuAnchor(
              builder: defaultMenuButton(
                  _calendarView.icon(PhosphorIconsStyle.light)),
              menuChildren: _CalendarView.values
                  .map((e) => MenuItemButton(
                        leadingIcon:
                            PhosphorIcon(e.icon(PhosphorIconsStyle.light)),
                        child: Text(e.getLocalizedName(context)),
                        onPressed: () => setState(() => _calendarView = e),
                      ))
                  .toList(),
            )
          ] else ...[
            SegmentedButton(
                segments: _CalendarView.values
                    .map((e) => ButtonSegment(
                        value: e,
                        icon: PhosphorIcon(e.icon(PhosphorIconsStyle.light)),
                        tooltip: e.getLocalizedName(context)))
                    .toList(),
                onSelectionChanged: (value) =>
                    setState(() => _calendarView = value.first),
                selected: {_calendarView}),
          ],
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
            onPressed: () => showSearch(
                context: context,
                delegate: _CalendarSearchDelegate(_calendarView)),
          ),
        ],
        body: CalendarBodyView(
          filter: widget.filter,
          view: _calendarView,
        ),
      );
    });
  }
}

class _CalendarSearchDelegate extends SearchDelegate {
  final _CalendarView view;

  _CalendarSearchDelegate(this.view);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const PhosphorIcon(PhosphorIconsLight.x),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const PhosphorIcon(PhosphorIconsLight.arrowLeft),
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
  final VoidCallback onCreated;
  final Widget child;
  final SourcedModel<Multihash>? event;
  const CreateEventScaffold({
    super.key,
    required this.onCreated,
    required this.child,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCalendarCreate(context: context, event: event)
            .then((_) => onCreated()),
        label: Text(AppLocalizations.of(context).create),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }
}

Future<void> showCalendarCreate(
    {required BuildContext context,
    SourcedModel<Multihash>? event,
    DateTime? time}) async {
  final cubit = context.read<FlowCubit>();
  SourcedModel<Event>? eventResult;
  if (event != null) {
    final model =
        await cubit.getService(event.source).event?.getEvent(event.model);
    if (model != null) eventResult = SourcedModel(event.source, model);
  }
  Future<void> showCalendarItemDialog(CalendarItem item) => showDialog(
        context: context,
        builder: (context) => CalendarItemDialog(
          event: eventResult?.model,
          item: item,
          source: eventResult?.source,
          create: true,
        ),
      );
  time ??= DateTime.now();
  if (context.mounted) {
    final calendarItem = await showLeapBottomSheet<CalendarItem>(
      context: context,
      title: AppLocalizations.of(context).create,
      childrenBuilder: (ctx) => [
        ListTile(
          title: Text(AppLocalizations.of(context).appointment),
          leading: const PhosphorIcon(PhosphorIconsLight.calendar),
          onTap: () async {
            Navigator.of(ctx).pop(CalendarItem.fixed(
              start: time,
              end: time?.add(const Duration(hours: 1)),
            ));
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).moment),
          leading: const PhosphorIcon(PhosphorIconsLight.smiley),
          onTap: () async {
            Navigator.of(ctx).pop(CalendarItem.fixed(
              start: time,
              end: time,
            ));
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).pending),
          leading: const PhosphorIcon(PhosphorIconsLight.clock),
          onTap: () async {
            Navigator.of(ctx).pop(const CalendarItem.fixed());
          },
        ),
      ],
    );
    if (calendarItem != null) {
      await showCalendarItemDialog(calendarItem);
    }
  }
}
