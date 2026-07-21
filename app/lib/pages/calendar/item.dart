import 'package:flow/cubits/alarm.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/event.dart';
import 'package:flow/helpers/validation.dart';
import 'package:flow/pages/alarm/page.dart';
import 'package:flow/pages/groups/view.dart';
import 'package:flow/pages/resources/view.dart';
import 'package:flow/pages/users/view.dart';
import 'package:flow/widgets/markdown_field.dart';
import 'package:flow/widgets/confirm_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:intl/intl.dart';
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
  late bool _isRepeating;
  late RepeatType _repeatType;
  late int _repeatInterval;
  late int _repeatCount;
  DateTime? _repeatUntil;
  late Set<int> _repeatWeeklyDays;
  late Set<int> _repeatMonthlyDays;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _create = widget.create || widget.item == null || widget.source == null;
    _source = widget.source ?? '';
    _item = widget.item ?? FixedCalendarItem(eventId: widget.event?.id);
    _service = context.read<FlowCubit>().getService(_source).calendarItem;
    if (_item is RepeatingCalendarItem) {
      final repeating = _item as RepeatingCalendarItem;
      _isRepeating = true;
      _repeatType = repeating.repeatType;
      _repeatInterval = repeating.interval;
      _repeatCount = repeating.count;
      _repeatUntil = repeating.until;
      _repeatWeeklyDays = repeating.weeklyWeekdays.toSet();
      _repeatMonthlyDays = repeating.monthlyMonthDays.toSet();
    } else {
      _isRepeating = false;
      _repeatType = RepeatType.daily;
      _repeatInterval = 1;
      _repeatCount = 0;
      _repeatUntil = null;
      _repeatWeeklyDays = {};
      _repeatMonthlyDays = {};
    }
  }

  String _repeatTypeLabel(BuildContext context, RepeatType type) {
    final loc = AppLocalizations.of(context);
    return switch (type) {
      RepeatType.daily => loc.repeatDaily,
      RepeatType.weekly => loc.repeatWeekly,
      RepeatType.monthly => loc.repeatMonthly,
      RepeatType.yearly => loc.repeatYearly,
    };
  }

  String _weekdayLabel(BuildContext context, int weekday) {
    final baseMonday = DateTime(2020, 1, 6);
    return DateFormat.EEEE(
      AppLocalizations.of(context).localeName,
    ).format(baseMonday.add(Duration(days: weekday - DateTime.monday)));
  }

  CalendarItem _buildPersistedItem() {
    final start = _item.start;
    if (!_isRepeating ||
        start == null ||
        _item.type == CalendarItemType.pending) {
      return FixedCalendarItem(
        id: _item.id,
        name: _item.name,
        description: _item.description,
        location: _item.location,
        eventId: _item.eventId,
        start: _item.start,
        end: _item.end,
        status: _item.status,
      );
    }

    final variation = switch (_repeatType) {
      RepeatType.weekly => RepeatingCalendarItem.encodeWeeklyWeekdays(
        _repeatWeeklyDays.isNotEmpty ? _repeatWeeklyDays : {start.weekday},
      ),
      RepeatType.monthly => RepeatingCalendarItem.encodeMonthlyMonthDays(
        _repeatMonthlyDays.isNotEmpty ? _repeatMonthlyDays : {start.day},
      ),
      RepeatType.daily || RepeatType.yearly => 0,
    };

    return RepeatingCalendarItem(
      id: _item.id,
      name: _item.name,
      description: _item.description,
      location: _item.location,
      eventId: _item.eventId,
      start: _item.start,
      end: _item.end,
      status: _item.status,
      repeatType: _repeatType,
      interval: _repeatInterval,
      variation: variation,
      count: _repeatCount,
      until: _repeatUntil,
      exceptions: _item is RepeatingCalendarItem
          ? (_item as RepeatingCalendarItem).exceptions
          : const [],
    );
  }

  String? _validate(CalendarItem item) {
    final validation = validateDateRange(
      start: item.start,
      end: item.end,
      repeatUntil: _isRepeating ? _repeatUntil : null,
    );
    return switch (validation) {
      DateRangeValidationError.endBeforeStart => AppLocalizations.of(
        context,
      ).endBeforeStart,
      DateRangeValidationError.repeatUntilBeforeStart => AppLocalizations.of(
        context,
      ).repeatUntilBeforeStart,
      null => null,
    };
  }

  Future<void> _save() async {
    if (_saving) return;
    final item = _buildPersistedItem();
    final validationError = _validate(item);
    if (validationError != null) {
      setState(() => _error = validationError);
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      if (_create) {
        final created = await _service?.createCalendarItem(item);
        if (created == null) {
          if (mounted) {
            setState(() => _error = AppLocalizations.of(context).saveFailed);
          }
          return;
        }
        _item = created;
      } else {
        final updated = await _service?.updateCalendarItem(item) ?? false;
        if (!updated) {
          if (mounted) {
            setState(() => _error = AppLocalizations.of(context).saveFailed);
          }
          return;
        }
        _item = item;
      }
      if (mounted) {
        setState(() => _saving = false);
        Navigator.of(context).pop(SourcedModel(_source, _item));
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = AppLocalizations.of(context).saveFailed);
      }
    } finally {
      if (mounted && _saving) setState(() => _saving = false);
    }
  }

  void _convertTo(CalendarItemType type) {
    setState(() {
      switch (type) {
        case CalendarItemType.appointment:
          _item = _item.copyWith(
            start: _item.start ?? DateTime.now(),
            end:
                (_item.start == _item.end ? null : _item.end) ??
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
          _item = _item.copyWith(start: null, end: null);
          _isRepeating = false;
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
    final tabs =
        !_create &&
        noteConnector != null &&
        resourceConnector != null &&
        userConnector != null &&
        groupConnector != null;
    final type = _item.type;
    final title = switch (type) {
      CalendarItemType.appointment =>
        _create
            ? AppLocalizations.of(context).createAppointment
            : AppLocalizations.of(context).editAppointment,
      CalendarItemType.moment =>
        _create
            ? AppLocalizations.of(context).createMoment
            : AppLocalizations.of(context).editMoment,
      CalendarItemType.pending =>
        _create
            ? AppLocalizations.of(context).createPending
            : AppLocalizations.of(context).editPending,
    };
    final isAllDay =
        _item.start?.hour == 0 &&
        _item.start?.minute == 0 &&
        _item.end?.hour == 23 &&
        _item.end?.minute == 59;

    return ResponsiveAlertDialog(
      title: Text(title),
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
      headerActions: [
        if (tabs)
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.trash),
            tooltip: AppLocalizations.of(context).delete,
            onPressed: () async {
              final confirmed = await confirmDelete(
                context,
                title: AppLocalizations.of(
                  context,
                ).deleteCalendarItem(_item.name),
                message: AppLocalizations.of(
                  context,
                ).deleteCalendarItemDescription(_item.name),
              );
              if (!confirmed) return;
              final deleted =
                  await _service?.deleteCalendarItem(_item.id!) ?? false;
              if (!deleted && context.mounted) {
                setState(
                  () => _error = AppLocalizations.of(context).deleteFailed,
                );
                return;
              }
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
            final alarmCubit = context.read<AlarmCubit>();
            final result = await showDialog<Alarm>(
              context: context,
              builder: (context) => AlarmDialog(initialValue: alarm),
            );
            if (result == null) return;
            final scheduled = await alarmCubit.addAlarm(result);
            if (!scheduled && mounted) {
              setState(() => _error = AppLocalizations.of(context).saveFailed);
            }
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
            if (_error != null)
              MaterialBanner(
                content: Text(_error!),
                leading: const PhosphorIcon(PhosphorIconsLight.warningCircle),
                actions: [
                  IconButton(
                    onPressed: () => setState(() => _error = null),
                    icon: const PhosphorIcon(PhosphorIconsLight.x),
                    tooltip: AppLocalizations.of(context).close,
                  ),
                ],
              ),
            if (tabs)
              TabBar(
                isScrollable: true,
                tabs:
                    [
                          (
                            PhosphorIconsLight.faders,
                            AppLocalizations.of(context).general,
                          ),
                          (
                            PhosphorIconsLight.checkCircle,
                            AppLocalizations.of(context).notes,
                          ),
                          (
                            PhosphorIconsLight.cube,
                            AppLocalizations.of(context).resources,
                          ),
                          (
                            PhosphorIconsLight.user,
                            AppLocalizations.of(context).users,
                          ),
                          (
                            PhosphorIconsLight.usersThree,
                            AppLocalizations.of(context).group,
                          ),
                        ]
                        .map(
                          (e) => HorizontalTab(
                            icon: PhosphorIcon(e.$1),
                            label: Text(e.$2),
                          ),
                        )
                        .toList(),
              ),
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
                              _item = _item.copyWith(eventId: null);
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
                              .map(
                                (value) => DropdownMenuEntry<EventStatus>(
                                  value: value,
                                  leadingIcon: PhosphorIcon(
                                    value.icon(PhosphorIconsStyle.light),
                                    color: value.getColor(),
                                  ),
                                  label: value.getLocalizedName(context),
                                ),
                              )
                              .toList(),
                          onSelected: (EventStatus? value) {
                            _item = _item.copyWith(
                              status: value ?? _item.status,
                            );
                          },
                          label: Text(AppLocalizations.of(context).status),
                          leadingIcon: const PhosphorIcon(
                            PhosphorIconsLight.info,
                          ),
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
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.fileText,
                            ),
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
                            filled: true,
                          ),
                          minLines: 1,
                          maxLines: 2,
                          initialValue: _item.location,
                          onChanged: (value) =>
                              _item = _item.copyWith(location: value),
                        ),
                        const SizedBox(height: 16),
                        if (type == CalendarItemType.appointment) ...[
                          CheckboxListTile(
                            title: Text(AppLocalizations.of(context).allDay),
                            value: isAllDay,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                if (value) {
                                  final start = _item.start ?? DateTime.now();
                                  _item = _item.copyWith(
                                    start: DateTime(
                                      start.year,
                                      start.month,
                                      start.day,
                                    ),
                                    end: _item.end != null
                                        ? DateTime(
                                            _item.end!.year,
                                            _item.end!.month,
                                            _item.end!.day,
                                          ).add(
                                            const Duration(
                                              hours: 23,
                                              minutes: 59,
                                            ),
                                          )
                                        : null,
                                  );
                                } else {
                                  final start = _item.start ?? DateTime.now();
                                  _item = _item.copyWith(
                                    start: DateTime(
                                      start.year,
                                      start.month,
                                      start.day,
                                      start.hour,
                                      start.minute,
                                    ),
                                    end: _item.end != null
                                        ? DateTime(
                                            _item.end!.year,
                                            _item.end!.month,
                                            _item.end!.day,
                                            start.hour + 1,
                                            start.minute,
                                          )
                                        : null,
                                  );
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 8),
                          Row(
                            spacing: 4,
                            children: [
                              Expanded(
                                child: DateTimeField(
                                  label: AppLocalizations.of(context).start,
                                  initialValue: _item.start,
                                  onChanged: (value) {
                                    _item = _item.copyWith(start: value);
                                  },
                                  canBeEmpty: false,
                                  filled: true,
                                  showTime: !isAllDay,
                                ),
                              ),
                              Expanded(
                                child: DateTimeField(
                                  label: AppLocalizations.of(context).end,
                                  initialValue: _item.end,
                                  onChanged: (value) {
                                    _item = _item.copyWith(
                                      end: isAllDay && value != null
                                          ? value.add(
                                              const Duration(
                                                hours: 23,
                                                minutes: 59,
                                              ),
                                            )
                                          : value,
                                    );
                                  },
                                  canBeEmpty: false,
                                  filled: true,
                                  showTime: !isAllDay,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (type == CalendarItemType.moment) ...[
                          DateTimeField(
                            label: AppLocalizations.of(context).time,
                            initialValue: _item.start,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.calendarBlank,
                            ),
                            onChanged: (value) {
                              _item = _item.copyWith(start: value, end: value);
                            },
                            canBeEmpty: true,
                          ),
                        ],
                        if (type != CalendarItemType.pending) ...[
                          const SizedBox(height: 16),
                          CheckboxListTile(
                            title: Text(AppLocalizations.of(context).repeat),
                            value: _isRepeating,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _isRepeating = value;
                              });
                            },
                          ),
                          if (_isRepeating) ...[
                            const SizedBox(height: 8),
                            DropdownMenu<RepeatType>(
                              initialSelection: _repeatType,
                              dropdownMenuEntries: RepeatType.values
                                  .map(
                                    (value) => DropdownMenuEntry(
                                      value: value,
                                      label: _repeatTypeLabel(context, value),
                                    ),
                                  )
                                  .toList(),
                              onSelected: (value) {
                                if (value == null) return;
                                setState(() {
                                  _repeatType = value;
                                });
                              },
                              label: Text(
                                AppLocalizations.of(context).repeatFrequency,
                              ),
                              expandedInsets: const EdgeInsets.all(4),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              initialValue: _repeatInterval.toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  context,
                                ).repeatInterval,
                                filled: true,
                                helperText: AppLocalizations.of(
                                  context,
                                ).repeatIntervalHelper,
                              ),
                              onChanged: (value) {
                                final parsed = int.tryParse(value);
                                if (parsed == null || parsed < 1) return;
                                _repeatInterval = parsed;
                              },
                            ),
                            if (_repeatType == RepeatType.weekly) ...[
                              const SizedBox(height: 8),
                              Text(AppLocalizations.of(context).repeatWeekdays),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(7, (index) {
                                  final weekday = index + 1;
                                  final selected = _repeatWeeklyDays.contains(
                                    weekday,
                                  );
                                  return FilterChip(
                                    label: Text(
                                      _weekdayLabel(context, weekday),
                                    ),
                                    selected: selected,
                                    onSelected: (value) {
                                      setState(() {
                                        if (value) {
                                          _repeatWeeklyDays.add(weekday);
                                        } else {
                                          _repeatWeeklyDays.remove(weekday);
                                        }
                                      });
                                    },
                                  );
                                }),
                              ),
                            ],
                            if (_repeatType == RepeatType.monthly) ...[
                              const SizedBox(height: 8),
                              Text(
                                AppLocalizations.of(context).repeatMonthDays,
                              ),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: List.generate(31, (index) {
                                  final day = index + 1;
                                  final selected = _repeatMonthlyDays.contains(
                                    day,
                                  );
                                  return FilterChip(
                                    label: Text('$day'),
                                    selected: selected,
                                    onSelected: (value) {
                                      setState(() {
                                        if (value) {
                                          _repeatMonthlyDays.add(day);
                                        } else {
                                          _repeatMonthlyDays.remove(day);
                                        }
                                      });
                                    },
                                  );
                                }),
                              ),
                            ],
                            const SizedBox(height: 8),
                            TextFormField(
                              initialValue: _repeatCount > 0
                                  ? _repeatCount.toString()
                                  : '',
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  context,
                                ).repeatOccurrences,
                                filled: true,
                                helperText: AppLocalizations.of(
                                  context,
                                ).repeatOccurrencesHelper,
                              ),
                              onChanged: (value) {
                                final parsed = int.tryParse(value);
                                _repeatCount = parsed == null || parsed < 1
                                    ? 0
                                    : parsed;
                              },
                            ),
                            const SizedBox(height: 8),
                            DateTimeField(
                              label: AppLocalizations.of(context).repeatUntil,
                              initialValue: _repeatUntil,
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.calendarCheck,
                              ),
                              onChanged: (value) {
                                _repeatUntil = value;
                              },
                              canBeEmpty: true,
                              filled: true,
                              showTime: !isAllDay,
                            ),
                          ],
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
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
