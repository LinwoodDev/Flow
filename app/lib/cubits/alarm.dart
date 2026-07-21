import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

part 'alarm.mapper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@MappableClass()
final class Alarm with AlarmMappable {
  final String id;
  final int notificationId;
  final DateTime date;
  final String title;
  final String description;
  final bool isActive;

  const Alarm({
    this.id = '',
    this.notificationId = 0,
    required this.date,
    this.title = '',
    this.description = '',
    this.isActive = true,
  });
}

@MappableClass()
final class AlarmState with AlarmStateMappable {
  static const String alarmsKey = 'alarms';

  final List<Alarm> alarms;

  const AlarmState({this.alarms = const []});

  factory AlarmState.fromPrefs(SharedPreferences prefs) => AlarmState(
    alarms:
        prefs.getStringList(alarmsKey)?.map(AlarmMapper.fromJson).toList() ??
        [],
  );

  Future<void> save(SharedPreferences prefs) =>
      prefs.setStringList(alarmsKey, alarms.map((e) => e.toJson()).toList());
}

class AlarmCubit extends Cubit<AlarmState> {
  final SharedPreferences _prefs;
  var _generatedIds = 0;

  AlarmCubit(this._prefs) : super(AlarmState.fromPrefs(_prefs)) {
    final normalized = _normalizeAlarms(state.alarms);
    if (!const ListEquality<Alarm>().equals(normalized, state.alarms)) {
      emit(state.copyWith(alarms: normalized));
      unawaited(_save());
    }
  }

  Alarm? getAlarm(String id) =>
      state.alarms.firstWhereOrNull((e) => e.id == id);

  Future<bool> addAlarm(Alarm alarm) async {
    final normalized = _normalizeAlarm(alarm);
    final newState = state.copyWith(alarms: [...state.alarms, normalized]);
    emit(newState);
    final scheduled = await _scheduleAlarm(normalized);
    if (!scheduled) {
      emit(
        state.copyWith(
          alarms: state.alarms
              .map(
                (alarm) => alarm.id == normalized.id
                    ? alarm.copyWith(isActive: false)
                    : alarm,
              )
              .toList(),
        ),
      );
    }
    await _save();
    return scheduled;
  }

  Future<void> removeAlarm(String id) async {
    final alarm = getAlarm(id);
    if (alarm == null) return;
    final newState = state.copyWith(
      alarms: state.alarms.where((e) => e.id != id).toList(),
    );
    emit(newState);
    await _cancelAlarm(alarm);
    return _save();
  }

  Future<bool> changeAlarm(String id, Alarm alarm) async {
    final existing = getAlarm(id);
    if (existing == null) return false;
    final normalized = _normalizeAlarm(
      alarm.copyWith(id: existing.id, notificationId: existing.notificationId),
    );
    final newState = state.copyWith(
      alarms: state.alarms.map((e) => e.id == id ? normalized : e).toList(),
    );
    emit(newState);
    final scheduled = await _scheduleAlarm(normalized);
    if (!scheduled) {
      emit(
        state.copyWith(
          alarms: state.alarms
              .map(
                (alarm) => alarm.id == normalized.id
                    ? alarm.copyWith(isActive: false)
                    : alarm,
              )
              .toList(),
        ),
      );
    }
    await _save();
    return scheduled;
  }

  Future<void> rescheduleAlarms() async {
    final failedAlarmIds = <String>{};
    for (final alarm in state.alarms) {
      if (!await _scheduleAlarm(alarm) && alarm.isActive) {
        failedAlarmIds.add(alarm.id);
      }
    }
    if (failedAlarmIds.isNotEmpty) {
      emit(
        state.copyWith(
          alarms: state.alarms
              .map(
                (alarm) => failedAlarmIds.contains(alarm.id)
                    ? alarm.copyWith(isActive: false)
                    : alarm,
              )
              .toList(),
        ),
      );
      await _save();
    }
  }

  Future<void> _save() => state.save(_prefs);

  List<Alarm> _normalizeAlarms(List<Alarm> alarms) {
    final notificationIds = <int>{};
    return alarms.map((alarm) {
      final normalized = _normalizeAlarm(
        alarm,
        usedNotificationIds: notificationIds,
      );
      notificationIds.add(normalized.notificationId);
      return normalized;
    }).toList();
  }

  Alarm _normalizeAlarm(
    Alarm alarm, {
    Set<int> usedNotificationIds = const {},
  }) {
    final id = alarm.id.isEmpty ? _createAlarmId() : alarm.id;
    final notificationId =
        alarm.notificationId <= 0 ||
            usedNotificationIds.contains(alarm.notificationId)
        ? _createNotificationId(usedNotificationIds)
        : alarm.notificationId;
    return alarm.copyWith(id: id, notificationId: notificationId);
  }

  String _createAlarmId() {
    _generatedIds += 1;
    return 'alarm-${DateTime.now().microsecondsSinceEpoch}-$_generatedIds';
  }

  int _createNotificationId(Set<int> usedNotificationIds) {
    var notificationId = DateTime.now().microsecondsSinceEpoch.remainder(
      0x7fffffff,
    );
    while (notificationId <= 0 ||
        usedNotificationIds.contains(notificationId)) {
      notificationId = (notificationId + 1).remainder(0x7fffffff);
    }
    return notificationId;
  }
}

Future<bool> _scheduleAlarm(Alarm alarm) async {
  if (!alarm.isActive) {
    await _cancelAlarm(alarm);
    return true;
  }
  if (!alarm.date.isAfter(DateTime.now())) {
    await _cancelAlarm(alarm);
    return false;
  }
  try {
    if (!(await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission() ??
        true)) {
      debugPrint('Notification permission not granted');
      return false;
    }
    if (!(await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestExactAlarmsPermission() ??
        true)) {
      debugPrint('Exact alarms permission not granted');
      return false;
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: alarm.notificationId,
      title: alarm.title,
      body: alarm.description,
      scheduledDate: tz.TZDateTime.from(alarm.date, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'dev.linwood.flow.alarm',
          'Alarm',
          channelDescription: 'Alarm reminders',
          audioAttributesUsage: AudioAttributesUsage.alarm,
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    return true;
  } catch (e) {
    debugPrint('Error scheduling alarm: $e');
    return false;
  }
}

Future<void> _cancelAlarm(Alarm alarm) async {
  try {
    await flutterLocalNotificationsPlugin.cancel(id: alarm.notificationId);
  } catch (e) {
    debugPrint('Error canceling alarm: $e');
  }
}
