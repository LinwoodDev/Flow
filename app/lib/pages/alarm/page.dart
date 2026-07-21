import 'package:flow/cubits/alarm.dart';
import 'package:flow/helpers/validation.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow/widgets/confirm_delete.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).alarm,
      body: BlocBuilder<AlarmCubit, AlarmState>(
        buildWhen: (previous, current) => previous.alarms != current.alarms,
        builder: (context, state) {
          if (state.alarms.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context).noAlarms));
          }
          final alarms = List<Alarm>.from(state.alarms)
            ..sort((a, b) => a.date.compareTo(b.date));
          return GridView.extent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 1.25,
            children: alarms
                .map(
                  (e) => Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async {
                        final alarmCubit = context.read<AlarmCubit>();
                        final alarm = await showDialog<Alarm>(
                          context: context,
                          builder: (context) => AlarmDialog(initialValue: e),
                        );
                        if (alarm != null) {
                          alarmCubit.changeAlarm(e.id, alarm);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SwitchListTile(
                                    value: e.isActive,
                                    contentPadding: EdgeInsets.only(left: 6),
                                    onChanged: (_) {
                                      final alarmCubit = context
                                          .read<AlarmCubit>();
                                      alarmCubit.changeAlarm(
                                        e.id,
                                        e.copyWith(isActive: !e.isActive),
                                      );
                                    },
                                    title: Text(
                                      AppLocalizations.of(context).enabled,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.clockCountdown,
                                  ),
                                  tooltip: AppLocalizations.of(
                                    context,
                                  ).countdown,
                                  onPressed: () {
                                    GoRouter.of(context).goNamed(
                                      'alarm-countdown',
                                      pathParameters: {'id': e.id},
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.trash,
                                  ),
                                  tooltip: AppLocalizations.of(context).delete,
                                  onPressed: () async {
                                    final alarmCubit = context
                                        .read<AlarmCubit>();
                                    final name = e.title.isEmpty
                                        ? AppLocalizations.of(context).alarm
                                        : e.title;
                                    final confirmed = await confirmDelete(
                                      context,
                                      title: AppLocalizations.of(
                                        context,
                                      ).deleteAlarm(name),
                                      message: AppLocalizations.of(
                                        context,
                                      ).deleteAlarmDescription(name),
                                    );
                                    if (confirmed) {
                                      await alarmCubit.removeAlarm(e.id);
                                    }
                                  },
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 4,
                              children: [
                                Text(
                                  DateFormat.Hm().format(e.date),
                                  style: TextTheme.of(context).displayLarge,
                                ),
                                Text(
                                  DateFormat.yMMMMEEEEd().format(e.date),
                                  style: TextTheme.of(context).titleSmall,
                                ),
                              ],
                            ),
                            Text(
                              e.title,
                              style: TextTheme.of(context).titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final alarmCubit = context.read<AlarmCubit>();
          final alarm = await showDialog<Alarm>(
            context: context,
            builder: (context) => const AlarmDialog(),
          );
          if (alarm != null) {
            alarmCubit.addAlarm(alarm);
          }
        },
        icon: const Icon(PhosphorIconsLight.plus),
        label: Text(AppLocalizations.of(context).create),
      ),
    );
  }
}

class AlarmDialog extends StatefulWidget {
  final Alarm? initialValue;
  const AlarmDialog({super.key, this.initialValue});

  @override
  State<AlarmDialog> createState() => _AlarmDialogState();
}

class _AlarmDialogState extends State<AlarmDialog> {
  late Alarm _alarm;
  String? _error;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _alarm =
        widget.initialValue ??
        Alarm(date: DateTime(now.year, now.month, now.day + 1, 8), title: '');
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).alarm),
      headerActions: [
        Tooltip(
          message: AppLocalizations.of(context).enabled,
          child: Switch(
            value: _alarm.isActive,
            onChanged: (value) => setState(() {
              _alarm = _alarm.copyWith(isActive: value);
              _error = null;
            }),
          ),
        ),
      ],
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: ListView(
        shrinkWrap: true,
        children: [
          if (_error != null) ...[
            Text(
              _error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            const SizedBox(height: 12),
          ],
          DateTimeField(
            label: AppLocalizations.of(context).time,
            initialValue: _alarm.date,
            onChanged: (value) {
              _alarm = _alarm.copyWith(date: value);
              if (_error != null) setState(() => _error = null);
            },
            canBeEmpty: false,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).name,
              filled: true,
            ),
            initialValue: _alarm.title,
            onChanged: (value) => _alarm = _alarm.copyWith(title: value),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).description,
              border: const OutlineInputBorder(),
            ),
            initialValue: _alarm.description,
            minLines: 3,
            maxLines: 5,
            onChanged: (value) => _alarm = _alarm.copyWith(description: value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (!isValidAlarmDate(
              date: _alarm.date,
              isActive: _alarm.isActive,
              now: DateTime.now(),
            )) {
              setState(
                () => _error = AppLocalizations.of(context).futureAlarmRequired,
              );
              return;
            }
            Navigator.of(context).pop(_alarm);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
