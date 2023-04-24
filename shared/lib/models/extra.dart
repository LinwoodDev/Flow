import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra.g.dart';
part 'extra.freezed.dart';

@freezed
class ExtraProperties with _$ExtraProperties {
  const factory ExtraProperties.calDav({
    required String etag,
    required String path,
  }) = CalDavExtraProperties;

  factory ExtraProperties.fromJson(Map<String, dynamic> json) =>
      _$ExtraPropertiesFromJson(json);
}
