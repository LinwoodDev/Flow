import 'package:collection/collection.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
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
      body: BlocBuilder<SettingsCubit, FlowSettings>(
        buildWhen: (previous, current) => previous.alarms != current.alarms,
        builder: (context, state) {
          return GridView.extent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 1.25,
            children: state.alarms
                .mapIndexed((i, e) => Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async {
                        final settingsCubit = context.read<SettingsCubit>();
                        final alarm = await showDialog<Alarm>(
                          context: context,
                          builder: (context) => AlarmDialog(
                            initialValue: e,
                          ),
                        );
                        if (alarm != null) {
                          settingsCubit.changeAlarm(i, alarm);
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
                                    onChanged: (_) {
                                      final settingsCubit =
                                          context.read<SettingsCubit>();
                                      settingsCubit.changeAlarm(
                                          i, e.copyWith(isActive: !e.isActive));
                                    },
                                    title: Text(
                                      AppLocalizations.of(context).enabled,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.clockCountdown),
                                  tooltip:
                                      AppLocalizations.of(context).countdown,
                                  onPressed: () {
                                    GoRouter.of(context).goNamed(
                                      'alarm-countdown',
                                      pathParameters: {'index': i.toString()},
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.trash),
                                  tooltip: AppLocalizations.of(context).delete,
                                  onPressed: () {
                                    final settingsCubit =
                                        context.read<SettingsCubit>();
                                    settingsCubit.removeAlarm(i);
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
                    )))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final settingsCubit = context.read<SettingsCubit>();
          final alarm = await showDialog<Alarm>(
            context: context,
            builder: (context) => const AlarmDialog(),
          );
          if (alarm != null) {
            settingsCubit.addAlarm(alarm);
          }
        },
        icon: const Icon(PhosphorIconsLight.plus),
        label: Text(AppLocalizations.of(context).create),
      ),
    );
  }
}

class AlarmDialog extends StatelessWidget {
  final Alarm? initialValue;
  const AlarmDialog({super.key, this.initialValue});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    var alarm = initialValue ??
        Alarm(
            date: DateTime(
              now.year,
              now.month,
              now.day + 1,
              8,
            ),
            title: '');
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).alarm),
      headerActions: [
        Tooltip(
          message: AppLocalizations.of(context).enabled,
          child: StatefulBuilder(
            builder: (context, setState) => Switch(
              value: alarm.isActive,
              onChanged: (value) => setState(() {
                alarm = alarm.copyWith(isActive: value);
              }),
            ),
          ),
        ),
      ],
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: ListView(
        shrinkWrap: true,
        children: [
          DateTimeField(
            label: AppLocalizations.of(context).time,
            initialValue: alarm.date,
            onChanged: (value) => alarm = alarm.copyWith(date: value),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name, filled: true),
            initialValue: alarm.title,
            onChanged: (value) => alarm = alarm.copyWith(title: value),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context).description,
                border: const OutlineInputBorder()),
            initialValue: alarm.title,
            minLines: 3,
            maxLines: 5,
            onChanged: (value) => alarm = alarm.copyWith(title: value),
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
            Navigator.of(context).pop(alarm);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
