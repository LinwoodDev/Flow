import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';

part 'model.mapper.dart';

@MappableClass()
sealed class RemoteStorage with RemoteStorageMappable {
  final String url;
  final String username;

  const RemoteStorage({
    required this.url,
    required this.username,
  });

  Uri get uri => Uri.parse(url);

  String get identifier => '$username@$url';
  String toFilename() => base64UrlEncode(utf8.encode(identifier));
  String get displayName => '$username@${uri.host}';
}

@MappableClass()
final class CalDavStorage extends RemoteStorage with CalDavStorageMappable {
  const CalDavStorage({
    required super.url,
    required super.username,
  });
}

@MappableClass()
final class ICalStorage extends RemoteStorage with ICalStorageMappable {
  const ICalStorage({
    required super.url,
    required super.username,
  });
}

@MappableClass()
final class WebDavStorage extends RemoteStorage with WebDavStorageMappable {
  const WebDavStorage({
    required super.url,
    required super.username,
  });
}

@MappableClass()
final class SiaStorage extends RemoteStorage with SiaStorageMappable {
  const SiaStorage({
    required super.url,
    required super.username,
  });
}
