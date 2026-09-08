import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';

part 'model.mapper.dart';

@MappableClass(discriminatorKey: 'type')
sealed class RemoteStorage with RemoteStorageMappable {
  final String url;
  final String username;
  final String name;

  const RemoteStorage({
    required this.url,
    required this.username,
    this.name = '',
  });

  bool get isReadOnly => this is ICalStorage;

  Uri get uri => Uri.parse(url);

  String get identifier => '$username@$url';
  String toFilename() => base64UrlEncode(utf8.encode(identifier));
  String get displayName => name.trim().isNotEmpty
      ? name.trim()
      : username.isEmpty
      ? uri.host
      : '$username@${uri.host}';
}

@MappableClass(discriminatorValue: 'caldav')
final class CalDavStorage extends RemoteStorage with CalDavStorageMappable {
  const CalDavStorage({
    required super.url,
    required super.username,
    super.name,
  });
}

@MappableClass(discriminatorValue: 'ical')
final class ICalStorage extends RemoteStorage with ICalStorageMappable {
  const ICalStorage({required super.url, required super.username, super.name});
}

@MappableClass(discriminatorValue: 'deviceCalendar')
final class DeviceCalendarStorage extends RemoteStorage
    with DeviceCalendarStorageMappable {
  final List<String> calendarIds;

  const DeviceCalendarStorage({
    super.url = 'device://calendar',
    super.username = '',
    this.calendarIds = const [],
    super.name,
  });

  @override
  String get identifier {
    if (calendarIds.isEmpty) return 'device-calendar';
    final sortedIds = calendarIds.toSet().toList()..sort();
    final selection = base64UrlEncode(utf8.encode(jsonEncode(sortedIds)));
    return 'device-calendar:$selection';
  }

  @override
  String get displayName => name.isEmpty ? 'Device calendar' : name;
}

@MappableClass(discriminatorValue: 'webdav')
final class WebDavStorage extends RemoteStorage with WebDavStorageMappable {
  const WebDavStorage({
    required super.url,
    required super.username,
    super.name,
  });
}

@MappableClass(discriminatorValue: 'sia')
final class SiaStorage extends RemoteStorage with SiaStorageMappable {
  const SiaStorage({required super.url, required super.username, super.name});
}
