import 'dart:async';

import 'package:flow/cubits/settings.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_leap/material_leap.dart';

class AlarmCountdownPage extends StatefulWidget {
  final int index;

  const AlarmCountdownPage({super.key, required this.index});

  @override
  State<AlarmCountdownPage> createState() => _AlarmCountdownPageState();
}

class _AlarmCountdownPageState extends State<AlarmCountdownPage> {
  late Duration _duration;
  late final Timer _timer;
  late final Alarm _alarm;

  @override
  void initState() {
    super.initState();
    final settingsCubit = context.read<SettingsCubit>();
    _alarm = settingsCubit.state.alarms.elementAtOrNull(widget.index) ??
        Alarm(date: DateTime.now());
    _updateDuration();
    _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => setState(() {
              _updateDuration();
            }));
  }

  void _updateDuration() => _duration = _alarm.date.difference(DateTime.now());

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    var fontSize = switch (size.width) {
      < LeapBreakpoints.compact => 64,
      < LeapBreakpoints.medium => 96,
      < LeapBreakpoints.large => 128,
      _ => 256,
    };
    return FlowNavigation(
      title: AppLocalizations.of(context).alarm,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                '${_duration.inDays}:${_duration.inHours % 24}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: fontSize.toDouble(),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _alarm.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat.yMMMMEEEEd().format(_alarm.date),
            ),
            Text(
              DateFormat.Hm().format(_alarm.date),
            ),
          ],
        ),
      ),
    );
  }
}
