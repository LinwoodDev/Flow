import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/event/item/model.dart';
import 'package:shared/models/event/model.dart';

import '../../widgets/date_time_field.dart';
import '../../widgets/source_dropdown.dart';
import '../events/note.dart';
import '../events/event.dart';

class CalendarItemDialog extends StatefulWidget {
  final bool create;
  final CalendarItem? item;
  final Event? event;
  final String? source;

  const CalendarItemDialog({
    super.key,
    this.item,
    this.create = false,
    this.source,
    this.event,
  });

  @override
  State<CalendarItemDialog> createState() => _CalendarItemDialogState();
}

class _CalendarItemDialogState extends State<CalendarItemDialog> {
  late final bool _create;
  late String _source;
  late CalendarItem _item;

  @override
  void initState() {
    super.initState();
    _create = widget.create || widget.item == null || widget.source == null;
    _source = widget.source ?? '';
    _item = widget.item ??
        CalendarItem.fixed(
          eventId: widget.event?.id,
        );
  }

  void _convertTo(CalendarItemType type) {
    setState(() {
      switch (type) {
        case CalendarItemType.appointment:
          _item = _item.copyWith(
            start: _item.start ?? DateTime.now(),
            end: _item.end ??
                (_item.start ?? DateTime.now()).add(const Duration(hours: 1)),
          );
          break;
        case CalendarItemType.moment:
          _item = _item.copyWith(
            start: _item.start ?? DateTime.now(),
            end: _item.start ?? DateTime.now(),
          );
          break;
        case CalendarItemType.pending:
          _item = _item.copyWith(
            start: null,
            end: null,
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FlowCubit>();
    final connector = cubit.getService(_source).calendarItemNote;
    final tabs = !_create && connector != null;
    final type = _item.type;
    String title;
    switch (type) {
      case CalendarItemType.appointment:
        title = _create
            ? AppLocalizations.of(context).createAppointment
            : AppLocalizations.of(context).editAppointment;
        break;
      case CalendarItemType.moment:
        title = _create
            ? AppLocalizations.of(context).createMoment
            : AppLocalizations.of(context).editMoment;
        break;
      case CalendarItemType.pending:
        title = _create
            ? AppLocalizations.of(context).createPending
            : AppLocalizations.of(context).editPending;
        break;
    }

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          MenuAnchor(
            builder: (context, controller, child) => IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () =>
                  controller.isOpen ? controller.close() : controller.open(),
            ),
            menuChildren: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  AppLocalizations.of(context).convertTo,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              MenuItemButton(
                leadingIcon: const Icon(Icons.event_outlined),
                onPressed: () => _convertTo(CalendarItemType.appointment),
                child: Text(AppLocalizations.of(context).appointment),
              ),
              MenuItemButton(
                leadingIcon: const Icon(Icons.mood_outlined),
                onPressed: () => _convertTo(CalendarItemType.moment),
                child: Text(AppLocalizations.of(context).moment),
              ),
              MenuItemButton(
                leadingIcon: const Icon(Icons.pending_actions_outlined),
                onPressed: () => _convertTo(CalendarItemType.pending),
                child: Text(AppLocalizations.of(context).pending),
              ),
            ],
          ),
        ],
      ),
      content: SizedBox(
        width: 500,
        height: 500,
        child: DefaultTabController(
          length: tabs ? 2 : 1,
          child: Column(
            children: [
              if (tabs)
                TabBar(
                    tabs: <dynamic>[
                  [Icons.tune_outlined, AppLocalizations.of(context).general],
                  [
                    Icons.check_circle_outline_outlined,
                    AppLocalizations.of(context).notes
                  ],
                ]
                        .map((e) => Tab(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Icon(e[0]),
                                  const SizedBox(width: 8),
                                  Text(e[1]),
                                ])))
                        .toList()),
              Flexible(
                child: TabBarView(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          if (widget.source == null) ...[
                            SourceDropdown(
                              value: _source,
                              onChanged: (String? value) {
                                _source = value ?? '';
                                _item = _item.copyWith(
                                  eventId: null,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                          const SizedBox(height: 16),
                          EventListTile(
                            source: _source,
                            value: _item.eventId,
                            onChanged: (value) {
                              _item = _item.copyWith(eventId: value);
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<EventStatus>(
                            value: _item.status,
                            items: EventStatus.values
                                .map<DropdownMenuItem<EventStatus>>((value) {
                              return DropdownMenuItem<EventStatus>(
                                value: value,
                                child: Row(
                                  children: [
                                    Icon(value.getIcon(),
                                        color: value.getColor()),
                                    const SizedBox(width: 8),
                                    Text(value.getLocalizedName(context)),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (EventStatus? value) {
                              _item =
                                  _item.copyWith(status: value ?? _item.status);
                            },
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).status,
                              icon: const Icon(Icons.info_outlined),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: _item.name,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).name,
                              filled: true,
                              icon: const Icon(Icons.folder_outlined),
                            ),
                            onChanged: (value) =>
                                _item = _item.copyWith(name: value),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context).description,
                              border: const OutlineInputBorder(),
                              icon: const Icon(Icons.description_outlined),
                            ),
                            minLines: 3,
                            maxLines: 5,
                            initialValue: _item.description,
                            onChanged: (value) =>
                                _item = _item.copyWith(description: value),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).location,
                              icon: const Icon(Icons.location_on_outlined),
                            ),
                            minLines: 1,
                            maxLines: 2,
                            initialValue: _item.location,
                            onChanged: (value) =>
                                _item = _item.copyWith(location: value),
                          ),
                          const SizedBox(height: 16),
                          if (type == CalendarItemType.appointment) ...[
                            DateTimeField(
                              label: AppLocalizations.of(context).start,
                              initialValue: _item.start,
                              icon: const Icon(Icons.calendar_today_outlined),
                              onChanged: (value) {
                                _item = _item.copyWith(start: value);
                              },
                              canBeEmpty: true,
                            ),
                            const SizedBox(height: 8),
                            DateTimeField(
                              label: AppLocalizations.of(context).end,
                              initialValue: _item.end,
                              icon: const Icon(Icons.calendar_today_outlined),
                              onChanged: (value) {
                                _item = _item.copyWith(end: value);
                              },
                              canBeEmpty: true,
                            ),
                          ],
                          if (type == CalendarItemType.moment) ...[
                            DateTimeField(
                              label: AppLocalizations.of(context).time,
                              initialValue: _item.start,
                              icon: const Icon(Icons.calendar_today_outlined),
                              onChanged: (value) {
                                _item =
                                    _item.copyWith(start: value, end: value);
                              },
                              canBeEmpty: true,
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (tabs)
                      NotesView(
                        model: widget.item!,
                        connector: connector,
                        source: _source,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            if (_create) {
              final created = await cubit
                  .getService(_source)
                  .calendarItem
                  ?.createCalendarItem(_item);
              if (created != null) {
                _item = created;
              }
            } else {
              cubit.getService(_source).calendarItem?.updateCalendarItem(_item);
            }
            navigator.pop(_item);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
