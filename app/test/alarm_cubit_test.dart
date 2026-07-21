import 'package:flow/cubits/alarm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('normalizes legacy alarm and notification identifiers', () async {
    final date = DateTime(2026, 7, 22, 8);
    SharedPreferences.setMockInitialValues({
      AlarmState.alarmsKey: [
        Alarm(date: date, title: 'First').toJson(),
        Alarm(date: date, title: 'Second').toJson(),
      ],
    });

    final cubit = AlarmCubit(await SharedPreferences.getInstance());
    addTearDown(cubit.close);
    final alarms = cubit.state.alarms;

    expect(alarms, hasLength(2));
    expect(alarms.map((alarm) => alarm.id).toSet(), hasLength(2));
    expect(alarms.every((alarm) => alarm.id.isNotEmpty), isTrue);
    expect(alarms.map((alarm) => alarm.notificationId).toSet(), hasLength(2));
    expect(alarms.every((alarm) => alarm.notificationId > 0), isTrue);

    await Future<void>.delayed(Duration.zero);
    final stored = (await SharedPreferences.getInstance()).getStringList(
      AlarmState.alarmsKey,
    );
    expect(stored, isNotNull);
    expect(
      stored!.map(AlarmMapper.fromJson).every((alarm) => alarm.id.isNotEmpty),
      isTrue,
    );
  });
}
