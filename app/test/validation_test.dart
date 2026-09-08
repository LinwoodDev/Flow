import 'dart:convert';

import 'package:flow/api/storage/remote/service.dart';
import 'package:flow/helpers/validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseRemoteUri', () {
    test('accepts and trims HTTP URLs', () {
      expect(
        parseRemoteUri('  https://calendar.example.test/user/  '),
        Uri.parse('https://calendar.example.test/user/'),
      );
      final credentials = parseRemoteCredentials('https://alex@example.com')!;
      expect(credentials.username, 'alex');
      expect(credentials.password, '');
      expect(credentials.url.userInfo, isEmpty);
      expect(parseRemoteCredentials('https://example.com'), isNull);
      expect(
        parseRemoteUri('http://localhost:8080/calendar.ics'),
        Uri.parse('http://localhost:8080/calendar.ics'),
      );
    });

    test('rejects empty, relative, and unsupported URLs', () {
      expect(parseRemoteUri(''), isNull);
      expect(parseRemoteUri('/calendar.ics'), isNull);
      expect(parseRemoteUri('calendar.example.test'), isNull);
      expect(parseRemoteUri('ftp://calendar.example.test/file'), isNull);
    });
  });

  group('validateDateRange', () {
    final start = DateTime(2026, 7, 21, 10);

    test('accepts equal and increasing ranges', () {
      expect(validateDateRange(start: start, end: start), isNull);
      expect(
        validateDateRange(
          start: start,
          end: start.add(const Duration(hours: 1)),
          repeatUntil: start.add(const Duration(days: 7)),
        ),
        isNull,
      );
    });

    test('rejects invalid end and recurrence dates', () {
      expect(
        validateDateRange(
          start: start,
          end: start.subtract(const Duration(minutes: 1)),
        ),
        DateRangeValidationError.endBeforeStart,
      );
      expect(
        validateDateRange(
          start: start,
          end: start,
          repeatUntil: start.subtract(const Duration(days: 1)),
        ),
        DateRangeValidationError.repeatUntilBeforeStart,
      );
    });
  });

  test('only active alarms require a future date', () {
    final now = DateTime(2026, 7, 21, 12);
    expect(
      isValidAlarmDate(
        date: now.add(const Duration(minutes: 1)),
        isActive: true,
        now: now,
      ),
      isTrue,
    );
    expect(
      isValidAlarmDate(
        date: now.subtract(const Duration(minutes: 1)),
        isActive: true,
        now: now,
      ),
      isFalse,
    );
    expect(
      isValidAlarmDate(
        date: now.subtract(const Duration(minutes: 1)),
        isActive: false,
        now: now,
      ),
      isTrue,
    );
  });

  test('authorization is omitted when credentials are empty', () {
    expect(buildAuthorizationHeaders('', null), isEmpty);
    expect(buildAuthorizationHeaders('', ''), isEmpty);
    expect(buildAuthorizationHeaders('flow', 'secret'), {
      'Authorization': 'Basic ${base64Encode(utf8.encode('flow:secret'))}',
    });
  });
}
