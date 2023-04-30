import 'package:flow/pages/events/event.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../../helpers/sourced_paging_controller.dart';
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
          icon: const Icon(Icons.search_outlined),
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
  late final SourcedPagingController<Event> _controller;
  late EventFilter _filter;

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _controller = SourcedPagingController(_flowCubit);
    _controller.addFetchListener((source, service, offset, limit) async =>
        _filter.source != null && _filter.source != source
            ? null
            : service.event?.getEvents(
                offset: offset,
                limit: limit,
                groupId: _filter.source == source ? _filter.group : null,
                placeId: _filter.source == source ? _filter.place : null,
                search: widget.search));
    _filter = widget.filter;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant EventsBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      _controller.refresh();
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
              _controller.refresh();
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: PagedListView(
              pagingController: _controller,
              builderDelegate: buildMaterialPagedDelegate<SourcedModel<Event>>(
                _controller,
                (ctx, item, index) => Align(
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
                        _controller.itemList!.remove(item);
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: EventTile(
                        flowCubit: _flowCubit,
                        pagingController: _controller,
                        source: item.source,
                        event: item.model,
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
            .then((_) => _controller.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}
