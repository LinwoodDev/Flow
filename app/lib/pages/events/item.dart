import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/event/item/model.dart';
import 'package:shared/models/event/model.dart';

import '../../widgets/date_time_field.dart';
import '../../widgets/source_dropdown.dart';
import 'note.dart';
import 'event.dart';

class CalendarItemDialog extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final create = this.create || item == null || source == null;
    var currentSource = source ?? '';
    var currentCalendarItem = item ??
        CalendarItem.fixed(
          eventId: event?.id,
        );
    final cubit = context.read<FlowCubit>();
    final connector = cubit.getService(currentSource).calendarItemNote;
    final nameController =
        TextEditingController(text: currentCalendarItem.name);
    final descriptionController =
        TextEditingController(text: currentCalendarItem.description);
    final locationController =
        TextEditingController(text: currentCalendarItem.location);
    final tabs = !create && connector != null;
    final type = currentCalendarItem.type;
    String title;
    switch (type) {
      case CalendarItemType.appointment:
        title = create
            ? AppLocalizations.of(context).createAppointment
            : AppLocalizations.of(context).editAppointment;
        break;
      case CalendarItemType.moment:
        title = create
            ? AppLocalizations.of(context).createMoment
            : AppLocalizations.of(context).editMoment;
        break;
      case CalendarItemType.pending:
        title = create
            ? AppLocalizations.of(context).createPending
            : AppLocalizations.of(context).editPending;
        break;
    }

    return AlertDialog(
      title: Text(title),
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
                          if (source == null) ...[
                            SourceDropdown(
                              value: currentSource,
                              onChanged: (String? value) {
                                currentSource = value ?? '';
                                currentCalendarItem =
                                    currentCalendarItem.copyWith(
                                  eventId: null,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                          const SizedBox(height: 16),
                          EventListTile(
                            source: currentSource,
                            value: currentCalendarItem.eventId,
                            onChanged: (value) {
                              currentCalendarItem =
                                  currentCalendarItem.copyWith(eventId: value);
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<EventStatus>(
                            value: currentCalendarItem.status,
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
                              currentCalendarItem =
                                  currentCalendarItem.copyWith(
                                      status:
                                          value ?? currentCalendarItem.status);
                            },
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).status,
                              icon: const Icon(Icons.info_outlined),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).name,
                              icon: const Icon(Icons.folder_outlined),
                            ),
                            onChanged: (value) => currentCalendarItem =
                                currentCalendarItem.copyWith(name: value),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context).description,
                              border: const OutlineInputBorder(),
                              icon: const Icon(Icons.description_outlined),
                            ),
                            minLines: 3,
                            maxLines: 5,
                            controller: descriptionController,
                            onChanged: (value) => currentCalendarItem =
                                currentCalendarItem.copyWith(
                                    description: value),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).location,
                              filled: true,
                              icon: const Icon(Icons.location_on_outlined),
                            ),
                            minLines: 1,
                            maxLines: 2,
                            controller: locationController,
                            onChanged: (value) => currentCalendarItem =
                                currentCalendarItem.copyWith(location: value),
                          ),
                          const SizedBox(height: 16),
                          if (type == CalendarItemType.appointment) ...[
                            DateTimeField(
                              label: AppLocalizations.of(context).start,
                              initialValue: currentCalendarItem.start,
                              icon: const Icon(Icons.calendar_today_outlined),
                              onChanged: (value) {
                                currentCalendarItem =
                                    currentCalendarItem.copyWith(start: value);
                              },
                              canBeEmpty: true,
                            ),
                            const SizedBox(height: 8),
                            DateTimeField(
                              label: AppLocalizations.of(context).end,
                              initialValue: currentCalendarItem.end,
                              icon: const Icon(Icons.calendar_today_outlined),
                              onChanged: (value) {
                                currentCalendarItem =
                                    currentCalendarItem.copyWith(end: value);
                              },
                              canBeEmpty: true,
                            ),
                          ],
                          if (type == CalendarItemType.moment) ...[
                            DateTimeField(
                              label: AppLocalizations.of(context).time,
                              initialValue: currentCalendarItem.start,
                              icon: const Icon(Icons.calendar_today_outlined),
                              onChanged: (value) {
                                currentCalendarItem = currentCalendarItem
                                    .copyWith(start: value, end: value);
                              },
                              canBeEmpty: true,
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (tabs)
                      NotesView(
                        model: item!,
                        connector: connector,
                        source: currentSource,
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
            if (create) {
              final created = await cubit
                  .getService(currentSource)
                  .calendarItem
                  ?.createCalendarItem(currentCalendarItem);
              if (created != null) {
                currentCalendarItem = created;
              }
            } else {
              cubit
                  .getService(currentSource)
                  .calendarItem
                  ?.updateCalendarItem(currentCalendarItem);
            }
            navigator.pop(currentCalendarItem);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
