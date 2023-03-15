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

  factory RemoteStorage.fromJson(Map<String, dynamic> json) =>
      _$RemoteStorageFromJson(json);

  String toDisplayString() => '$username@$url';
  String toFilename() => base64UrlEncode(utf8.encode(toDisplayString()));
}
