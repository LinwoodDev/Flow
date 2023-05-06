import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/services/source.dart';

import '../../widgets/builder_delegate.dart';
import 'event.dart';

class EventSelectTile extends StatefulWidget {
  final String source;
  final Multihash? value;
  final ValueChanged<Multihash?> onChanged;

  const EventSelectTile({
    super.key,
    required this.source,
    this.value,
    required this.onChanged,
  });

  @override
  State<EventSelectTile> createState() => _EventSelectTileState();
}

class _EventSelectTileState extends State<EventSelectTile> {
  Multihash? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _onChanged(Multihash? value) {
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Event?>(
        future: Future.value(_value == null
            ? null
            : context
                .read<FlowCubit>()
                .getService(widget.source)
                .event
                ?.getEvent(_value!)),
        builder: (context, snapshot) {
          final event = snapshot.data;
          return ListTile(
            title: Text(AppLocalizations.of(context).event),
            subtitle: Text(event?.name ?? AppLocalizations.of(context).notSet),
            leading: PhosphorIcon(PhosphorIcons.calendar(event == null
                ? PhosphorIconsStyle.light
                : PhosphorIconsStyle.fill)),
            onTap: () async {
              if (event != null) {
                Navigator.of(context).pop();
                final model = await showDialog<SourcedModel<Event>>(
                  context: context,
                  builder: (context) => EventDialog(
                    event: event,
                    source: widget.source,
                  ),
                );
                if (model != null) {
                  _onChanged(model.model.id);
                }
              } else {
                final model = await showDialog<SourcedModel<Event>>(
                  context: context,
                  builder: (context) => EventSelectDialog(
                    source: widget.source,
                  ),
                );
                if (model != null) {
                  _onChanged(model.model.id);
                }
              }
            },
            trailing: _value == null
                ? IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                    onPressed: () async {
                      final event = await showDialog<SourcedModel<Event>>(
                        context: context,
                        builder: (context) => EventDialog(
                          source: widget.source,
                          create: true,
                        ),
                      );
                      _onChanged(event?.model.id);
                    },
                  )
                : IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.x),
                    onPressed: () {
                      _onChanged(null);
                    },
                  ),
          );
        });
  }
}

class EventSelectDialog extends StatefulWidget {
  final String? source;
  final SourcedModel<Multihash>? selected;

  const EventSelectDialog({
    super.key,
    this.source,
    this.selected,
  });

  @override
  State<EventSelectDialog> createState() => _EventSelectDialogState();
}

class _EventSelectDialogState extends State<EventSelectDialog> {
  static const _pageSize = 20;
  final TextEditingController _controller = TextEditingController();
  final PagingController<int, SourcedModel<Event>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(_fetchPage);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final cubit = context.read<FlowCubit>();
      Map<String, SourceService> sources = widget.source == null
          ? cubit.getCurrentServicesMap()
          : {widget.source!: cubit.getService(widget.source!)};
      final events = await Future.wait(sources.entries.map((source) async {
        final events = await source.value.event?.getEvents(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          search: _controller.text,
        );
        return (events ?? <Event>[])
            .map((event) => SourcedModel(source.key, event))
            .toList();
      }));
      final allEvents = events.expand((element) => element).toList();
      final isLast = events.length < _pageSize;
      if (isLast) {
        _pagingController.appendLastPage(allEvents);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(allEvents, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).event),
      content: SizedBox(
        height: 400,
        width: 400,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).search,
                icon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
              ),
              controller: _controller,
              onSubmitted: (_) {
                _pagingController.refresh();
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: PagedListView<int, SourcedModel<Event>>(
                pagingController: _pagingController,
                builderDelegate:
                    buildMaterialPagedDelegate<SourcedModel<Event>>(
                  _pagingController,
                  (context, item, index) => ListTile(
                    title: Text(item.model.name),
                    selected: widget.selected?.model == item.model.id &&
                        widget.selected?.source == item.source,
                    onTap: () {
                      Navigator.of(context).pop(item);
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
          child: Text(AppLocalizations.of(context).cancel),
        ),
      ],
    );
  }
}
