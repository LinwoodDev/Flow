import 'package:flow/cubits/flow.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow/helpers/event.dart';
import 'package:flow/pages/alarm/page.dart';
import 'package:flow/pages/groups/view.dart';
import 'package:flow/pages/resources/view.dart';
import 'package:flow/pages/users/view.dart';
import 'package:flow/widgets/markdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/item/service.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/model.dart';

import '../../widgets/source_dropdown.dart';
import '../notes/view.dart';
import '../events/select.dart';

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
  CalendarItemService? _service;
  late CalendarItem _item;

  @override
  void initState() {
    super.initState();
    _create = widget.create || widget.item == null || widget.source == null;
    _source = widget.source ?? '';
    _item = widget.item ??
        FixedCalendarItem(
          eventId: widget.event?.id,
        );
    _service = context.read<FlowCubit>().getService(_source).calendarItem;
  }

  void _convertTo(CalendarItemType type) {
    setState(() {
      switch (type) {
        case CalendarItemType.appointment:
          _item = _item.copyWith(
            start: _item.start ?? DateTime.now(),
            end: (_item.start == _item.end ? null : _item.end) ??
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
    final service = cubit.getService(_source);
    final noteConnector = service.calendarItemNote;
    final resourceConnector = service.calendarItemResource;
    final userConnector = service.calendarItemUser;
    final groupConnector = service.calendarItemGroup;
    final tabs = !_create &&
        noteConnector != null &&
        resourceConnector != null &&
        userConnector != null &&
        groupConnector != null;
    final type = _item.type;
    final title = switch (type) {
      CalendarItemType.appointment => _create
          ? AppLocalizations.of(context).createAppointment
          : AppLocalizations.of(context).editAppointment,
      CalendarItemType.moment => _create
          ? AppLocalizations.of(context).createMoment
          : AppLocalizations.of(context).editMoment,
      CalendarItemType.pending => _create
          ? AppLocalizations.of(context).createPending
          : AppLocalizations.of(context).editPending,
    };

    return ResponsiveAlertDialog(
      title: Text(title),
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
      headerActions: [
        if (tabs)
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.trash),
            onPressed: () async {
              await _service?.deleteCalendarItem(_item.id!);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.alarm),
          onPressed: () async {
            final alarm = Alarm(
              date: (_item.start ?? DateTime.now()),
              description: _item.description,
              title: _item.name,
              isActive: _item.start != null,
            );
            final settingsCubit = context.read<SettingsCubit>();
            final result = await showDialog<Alarm>(
              context: context,
              builder: (context) => AlarmDialog(initialValue: alarm),
            );
            if (result == null) return;
            settingsCubit.addAlarm(result);
          },
        ),
        MenuAnchor(
          builder: defaultMenuButton(
            icon: const PhosphorIcon(PhosphorIconsLight.arrowsCounterClockwise),
          ),
          menuChildren: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                AppLocalizations.of(context).convertTo,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.calendar),
              onPressed: () => _convertTo(CalendarItemType.appointment),
              child: Text(AppLocalizations.of(context).appointment),
            ),
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.smiley),
              onPressed: () => _convertTo(CalendarItemType.moment),
              child: Text(AppLocalizations.of(context).moment),
            ),
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.clock),
              onPressed: () => _convertTo(CalendarItemType.pending),
              child: Text(AppLocalizations.of(context).pending),
            ),
          ],
        ),
      ],
      content: DefaultTabController(
        length: tabs ? 5 : 1,
        child: Column(
          spacing: 8,
          children: [
            if (tabs)
              TabBar(
                  isScrollable: true,
                  tabs: [
                    (
                      PhosphorIconsLight.faders,
                      AppLocalizations.of(context).general
                    ),
                    (
                      PhosphorIconsLight.checkCircle,
                      AppLocalizations.of(context).notes
                    ),
                    (
                      PhosphorIconsLight.cube,
                      AppLocalizations.of(context).resources
                    ),
                    (
                      PhosphorIconsLight.user,
                      AppLocalizations.of(context).users
                    ),
                    (
                      PhosphorIconsLight.usersThree,
                      AppLocalizations.of(context).group
                    ),
                  ]
                      .map((e) => HorizontalTab(
                            icon: PhosphorIcon(e.$1),
                            label: Text(e.$2),
                          ))
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
                          SourceDropdown<CalendarItemService>(
                            value: _source,
                            buildService: (e) => e.calendarItem,
                            onChanged: (connected) {
                              _source = connected?.source ?? '';
                              _item = _item.copyWith(
                                eventId: null,
                              );
                              _service = connected?.model;
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                        EventSelectTile(
                          source: _source,
                          value: _item.eventId,
                          onChanged: (value) {
                            _item = _item.copyWith(eventId: value?.model);
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownMenu<EventStatus>(
                          initialSelection: _item.status,
                          dropdownMenuEntries: EventStatus.values
                              .map((value) => DropdownMenuEntry<EventStatus>(
                                    value: value,
                                    leadingIcon: PhosphorIcon(
                                        value.icon(PhosphorIconsStyle.light),
                                        color: value.getColor()),
                                    label: value.getLocalizedName(context),
                                  ))
                              .toList(),
                          onSelected: (EventStatus? value) {
                            _item =
                                _item.copyWith(status: value ?? _item.status);
                          },
                          label: Text(AppLocalizations.of(context).status),
                          leadingIcon:
                              const PhosphorIcon(PhosphorIconsLight.info),
                          expandedInsets: const EdgeInsets.all(4),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _item.name,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).name,
                            filled: true,
                            icon: const PhosphorIcon(PhosphorIconsLight.folder),
                          ),
                          onChanged: (value) =>
                              _item = _item.copyWith(name: value),
                        ),
                        const SizedBox(height: 16),
                        MarkdownField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).description,
                            border: const OutlineInputBorder(),
                            icon:
                                const PhosphorIcon(PhosphorIconsLight.fileText),
                          ),
                          onChanged: (value) =>
                              _item = _item.copyWith(description: value),
                          value: _item.description,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).location,
                            icon: const PhosphorIcon(PhosphorIconsLight.mapPin),
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
                            icon: const PhosphorIcon(
                                PhosphorIconsLight.calendarBlank),
                            onChanged: (value) {
                              _item = _item.copyWith(start: value);
                            },
                            canBeEmpty: true,
                          ),
                          const SizedBox(height: 8),
                          DateTimeField(
                            label: AppLocalizations.of(context).end,
                            initialValue: _item.end,
                            icon: const PhosphorIcon(
                                PhosphorIconsLight.calendarBlank),
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
                            icon: const PhosphorIcon(
                                PhosphorIconsLight.calendarBlank),
                            onChanged: (value) {
                              _item = _item.copyWith(start: value, end: value);
                            },
                            canBeEmpty: true,
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (tabs) ...[
                    NotesView(
                      model: widget.item!,
                      connector: noteConnector,
                      source: _source,
                    ),
                    ResourcesView(
                      model: widget.item!,
                      connector: resourceConnector,
                      source: _source,
                    ),
                    UsersView(
                      model: widget.item!,
                      connector: userConnector,
                      source: _source,
                    ),
                    GroupsView(
                      model: widget.item!,
                      connector: groupConnector,
                      source: _source,
                    ),
                  ],
                ],
              ),
            ),
          ],
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
            if (_create) {
              final created = await _service?.createCalendarItem(_item);
              if (created == null) {
                return;
              }
              _item = created;
            } else {
              await _service?.updateCalendarItem(_item);
            }
            if (context.mounted) {
              Navigator.of(context).pop(SourcedModel(_source, _item));
            }
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
