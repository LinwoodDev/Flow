import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class RemoteStorage with _$RemoteStorage {
  const RemoteStorage._();

  const factory RemoteStorage.calDav({
    required String url,
    required String username,
  }) = CalDavStorage;
  const factory RemoteStorage.webDav({
    required String url,
    required String username,
  }) = WebDavStorage;
  const factory RemoteStorage.sia({
    required String url,
    required String username,
  }) = SiaStorage;

  factory RemoteStorage.fromJson(Map<String, dynamic> json) =>
      _$RemoteStorageFromJson(json);

  Uri get uri => Uri.parse(url);

  String get identifier => '$username@$url';
  String toFilename() => base64UrlEncode(utf8.encode(identifier));
  String get displayName => '$username@${uri.host}';
}
