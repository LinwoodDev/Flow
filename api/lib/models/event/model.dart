import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lib5/lib5.dart';
import 'package:flow_api/models/extra.dart';

import '../../helpers/converter.dart';
import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Event with _$Event, IdentifiedModel, NamedModel, DescriptiveModel {
  const Event._();

  @Implements<DescriptiveModel>()
  const factory Event({
    @MultihashConverter() Multihash? id,
    @MultihashConverter() Multihash? parentId,
    @MultihashConverter() Multihash? groupId,
    @MultihashConverter() Multihash? placeId,
    @Default(true) bool blocked,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    String? extra,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  factory Event.fromDatabase(Map<String, dynamic> row) => Event.fromJson({
        ...row,
        'blocked': row['blocked'] == 1,
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
        'blocked': blocked ? 1 : 0,
      };

  ExtraProperties? get extraProperties =>
      extra != null ? ExtraProperties.fromJson(jsonDecode(extra!)) : null;

  Event? addExtra(ExtraProperties extraProperties) => copyWith(
        extra: jsonEncode(extraProperties.toJson()),
      );
}

enum EventStatus {
  confirmed,
  draft,
  cancelled,
}

enum RepeatType {
  daily,
  weekly,
  monthly,
  yearly,
}
