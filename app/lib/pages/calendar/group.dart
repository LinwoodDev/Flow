import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';

class EventGroupDialog extends StatefulWidget {
  final String source;
  final Event event;

  const EventGroupDialog({
    super.key,
    required this.source,
    required this.event,
  });

  @override
  State<EventGroupDialog> createState() => _EventGroupDialogState();
}

class _EventGroupDialogState extends State<EventGroupDialog> {
  static const _pageSize = 20;
  final TextEditingController _controller = TextEditingController();
  final PagingController<int, EventGroup> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(_fetchPage);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final groups = await context
          .read<FlowCubit>()
          .getSource(widget.source)
          .eventGroup
          .getGroups(
            offset: pageKey * _pageSize,
            limit: _pageSize,
            search: _controller.text,
          );
      final isLast = groups.length < _pageSize;
      if (isLast) {
        _pagingController.appendLastPage(groups);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(groups, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.group),
      content: SizedBox(
        height: 400,
        width: 400,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.search,
                icon: const Icon(Icons.search_outlined),
              ),
              controller: _controller,
              onSubmitted: (_) {
                print('onSubmitted');
                _pagingController.refresh();
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: PagedListView<int, EventGroup>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<EventGroup>(
                  itemBuilder: (context, item, index) => ListTile(
                    title: Text(item.name),
                    selected: widget.event.groupId == item.id,
                    onTap: () {
                      context
                          .read<FlowCubit>()
                          .getSource(widget.source)
                          .event
                          .updateEvent(
                            widget.event.copyWith(groupId: item.id),
                          );
                      Navigator.of(context).pop(item.id);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
    );
  }
}
