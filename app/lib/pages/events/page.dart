import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/pages/events/event.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/model.dart';

import '../../cubits/flow.dart';
import 'filter.dart';
import 'tile.dart';

class EventsPage extends StatefulWidget {
  final EventFilter filter;
  const EventsPage({
    super.key,
    this.filter = const EventFilter(),
  });

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).events,
      actions: [
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
          onPressed: () => showSearch(
            context: context,
            delegate: _EventsSearchDelegate(
              widget.filter,
            ),
          ),
        ),
      ],
      body: EventsBodyView(
        filter: widget.filter,
      ),
    );
  }
}

class _EventsSearchDelegate extends SearchDelegate {
  final EventFilter filter;

  _EventsSearchDelegate(this.filter);

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
    return EventsBodyView(
      search: query,
      filter: filter,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class EventsBodyView extends StatefulWidget {
  final String search;
  final EventFilter filter;

  const EventsBodyView({
    super.key,
    this.search = '',
    this.filter = const EventFilter(),
  });

  @override
  State<EventsBodyView> createState() => _EventsBodyViewState();
}

class _EventsBodyViewState extends State<EventsBodyView> {
  late final FlowCubit _flowCubit;
  late final SourcedPagingBloc<Event> _bloc;
  late EventFilter _filter;

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _bloc = SourcedPagingBloc.item(
        cubit: _flowCubit,
        fetch: (source, service, offset, limit) async =>
            _filter.source != null && _filter.source != source
                ? null
                : service.event?.getEvents(
                    offset: offset,
                    limit: limit,
                    groupId: _filter.source == source ? _filter.group : null,
                    search: widget.search));
    _filter = widget.filter;
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant EventsBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      _bloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          EventFilterView(
            initialFilter: _filter,
            onChanged: (filter) {
              setState(() {
                _filter = filter;
              });
              _bloc.refresh();
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: PagedListView.item(
              bloc: _bloc,
              itemBuilder: (ctx, item, index) => Align(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Dismissible(
                    key: ValueKey('${item.model.id}@${item.source}'),
                    onDismissed: (direction) async {
                      await _flowCubit
                          .getService(item.source)
                          .event
                          ?.deleteEvent(item.model.id!);
                      _bloc.remove(item);
                    },
                    background: Container(
                      color: Colors.red,
                    ),
                    child: EventTile(
                      flowCubit: _flowCubit,
                      bloc: _bloc,
                      source: item.source,
                      event: item.model,
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
            .then((_) => _bloc.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }
}
