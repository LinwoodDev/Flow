import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../../helpers/sourced_paging_controller.dart';
import '../../widgets/builder_delegate.dart';
import '../../widgets/material_bottom_sheet.dart';
import 'appointment.dart';
import 'event.dart';
import 'filter.dart';
import 'moment.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({
    super.key,
  });

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  static const _pageSize = 20;
  late final FlowCubit _flowCubit;
  EventFilter _filter = const EventFilter();
  final PagingController<int, MapEntry<Event, String>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final sources = _flowCubit.getCurrentServicesMap().entries;
      final notes = <MapEntry<Event, String>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.event?.getEvents(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          groupId: source.key == _filter.source ? _filter.group : null,
        );
        if (fetched == null) continue;
        notes.addAll(fetched.map((note) => MapEntry(note, source.key)));
        if (fetched.length < _pageSize) {
          isLast = true;
        }
      }
      if (isLast) {
        _pagingController.appendLastPage(notes);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(notes, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).events,
      body: Column(
        children: [
          EventFilterView(
            initialFilter: _filter,
            onChanged: (filter) {
              setState(() {
                _filter = filter;
              });
              _pagingController.refresh();
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: PagedListView(
                  pagingController: _pagingController,
                  builderDelegate:
                      buildMaterialPagedDelegate<MapEntry<Event, String>>(
                    _pagingController,
                    (ctx, item, index) => Dismissible(
                      key: ValueKey(item.key.id),
                      onDismissed: (direction) async {
                        await _flowCubit
                            .getService(item.value)
                            .event
                            ?.deleteEvent(item.key.id);
                        _pagingController.itemList!.remove(item);
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: EventTile(
                        flowCubit: _flowCubit,
                        pagingController: _pagingController,
                        source: item.value,
                        event: item.key,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
                context: context, builder: (context) => const EventDialog())
            .then((value) => _pagingController.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  const EventTile({
    Key? key,
    required this.source,
    required this.event,
    required this.flowCubit,
    required this.pagingController,
  }) : super(key: key);

  final FlowCubit flowCubit;
  final Event event;
  final String source;
  final PagingController<int, MapEntry<Event, String>> pagingController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.name),
      subtitle: Text(event.description),
      onTap: () => _editEvent(context),
      trailing: PopupMenuButton<Function>(
        itemBuilder: (ctx) => <dynamic>[
          [
            Icons.delete_outline,
            AppLocalizations.of(context).delete,
            _deleteEvent,
          ],
        ]
            .map((e) => PopupMenuItem<Function>(
                  value: e[2],
                  child: Row(
                    children: [
                      Icon(e[0]),
                      const SizedBox(width: 8),
                      Text(e[1]),
                    ],
                  ),
                ))
            .toList(),
        onSelected: (value) => value(context),
      ),
    );
  }

  void _deleteEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteEvent(event.name)),
        content: Text(
            AppLocalizations.of(context).deleteEventDescription(event.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context).cancel,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await flowCubit.getService(source).event?.deleteEvent(event.id);
              pagingController.itemList!.remove(MapEntry(
                event,
                source,
              ));
              pagingController.refresh();
            },
            child: Text(
              AppLocalizations.of(context).delete,
            ),
          ),
        ],
      ),
    );
  }

  void _editEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EventDialog(
        event: event,
        source: source,
      ),
    ).then((value) => pagingController.refresh());
  }
}

Future<SourcedModel<Event>?> showEventModalBottomSheet(
    {required BuildContext context, Event? event, DateTime? time}) async {
  SourcedModel<Event>? event;
  final cubit = context.read<FlowCubit>();
  final pagingController = SourcedPagingController<Event>(cubit);
  pagingController.addFetchListener((source, service, offset, limit) async =>
      service.event?.getEvents(offset: offset, limit: limit));
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
                builderDelegate:
                    buildMaterialPagedDelegate<SourcedModel<Event>>(
                  pagingController,
                  (ctx, item, index) {
                    return ListTile(
                      title: Text(item.model.name),
                      leading: const Icon(Icons.event_outlined),
                      onTap: () {
                        event = item;
                        Navigator.of(ctx).pop();
                      },
                    );
                  },
                )),
          ]);
  pagingController.dispose();
  if (shouldCreate == true && context.mounted) {
    event = await showDialog(
      context: context,
      builder: (ctx) => EventDialog(
        event: event?.model,
        source: event?.source,
      ),
    );
  }
  return event;
}

Future<void> showCalendarCreate(
    {required BuildContext context,
    SourcedModel<Event>? event,
    DateTime? time}) async {
  final eventResult =
      event ?? await showEventModalBottomSheet(context: context, time: time);
  if (eventResult == null) return;
  if (context.mounted) {
    await showMaterialBottomSheet(
      context: context,
      title: AppLocalizations.of(context).create,
      childrenBuilder: (ctx) => [
        ListTile(
          title: Text(AppLocalizations.of(context).appointment),
          leading: const Icon(Icons.event_outlined),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => AppointmentDialog(
                event: eventResult.model,
                source: eventResult.source,
                create: true,
              ),
            );
            if (context.mounted) Navigator.of(ctx).pop();
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).moment),
          leading: const Icon(Icons.mood_outlined),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => MomentDialog(
                event: eventResult.model,
                source: eventResult.source,
                create: true,
              ),
            );
            if (context.mounted) Navigator.of(ctx).pop();
          },
        ),
      ],
    );
  }
}
