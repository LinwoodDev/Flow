import 'package:flow/pages/groups/property.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/event/service.dart';

import '../../../cubits/flow.dart';

class EventGroupPage extends StatelessWidget {
  final int eventGroupId;
  final String source;

  const EventGroupPage({
    super.key,
    required this.eventGroupId,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventGroup?>(
        future: Future.value(context
            .read<FlowCubit>()
            .getCurrentServicesMap()[source]!
            .eventGroup
            .getGroup(eventGroupId)),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noData),
            );
          }
          var eventGroup = snapshot.data!;
          return StatefulBuilder(builder: (context, setState) {
            return FlowNavigation(
              title: AppLocalizations.of(context)!.groupName(eventGroup.name),
              selected: "groups",
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () async {
                    final newGroup = await showDialog<EventGroup>(
                      context: context,
                      builder: (context) => EventGroupPropertyDialog(
                        eventGroup: eventGroup,
                        source: source,
                      ),
                    );
                    if (newGroup == null) return;
                    setState(() => eventGroup = newGroup);
                  },
                ),
              ],
              body: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: _EventGroupContent(
                    eventGroup: eventGroup,
                    source: source,
                  ),
                ),
              ),
            );
          });
        });
  }
}

class _EventGroupContent extends StatefulWidget {
  final EventGroup eventGroup;
  final String source;
  const _EventGroupContent({
    required this.eventGroup,
    required this.source,
  });

  @override
  State<_EventGroupContent> createState() => _EventGroupContentState();
}

class _EventGroupContentState extends State<_EventGroupContent> {
  static const _pageSize = 20;

  late final EventService _eventService;
  final PagingController<int, Event> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _eventService =
        context.read<FlowCubit>().getCurrentServicesMap()[widget.source]!.event;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _eventService.getEvents(
        groupId: widget.eventGroup.id,
        offset: pageKey * _pageSize,
        limit: _pageSize,
      );
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Event>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Event>(
        itemBuilder: (context, item, index) => ListTile(
          title: Text(item.name),
        ),
      ),
    );
  }
}
