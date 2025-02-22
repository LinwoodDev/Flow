import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flow_api/models/extra.dart';

import '../model.dart';

part 'model.mapper.dart';

@MappableClass()
final class Event
    with EventMappable, IdentifiedModel, NamedModel, DescriptiveModel {
  @override
  final Uint8List? id;
  final Uint8List? parentId;
  final bool blocked;
  @override
  final String name, description;
  final String location;
  final String? extra;

  const Event({
    this.id,
    this.parentId,
    this.blocked = true,
    this.name = '',
    this.description = '',
    this.location = '',
    this.extra,
  });

  factory Event.fromDatabase(Map<String, dynamic> row) => EventMapper.fromMap({
        ...row,
        'blocked': row['blocked'] == 1,
      });

  Map<String, dynamic> toDatabase() => {
        ...toMap(),
        'blocked': blocked ? 1 : 0,
      };

  ExtraProperties? get extraProperties =>
      extra != null ? ExtraPropertiesMapper.fromJson(extra!) : null;

  Event? addExtra(ExtraProperties extraProperties) => copyWith(
        extra: jsonEncode(extraProperties.toJson()),
      );
}

@MappableEnum()
enum EventStatus {
  confirmed,
  draft,
  cancelled,
}

@MappableEnum()
enum RepeatType {
  daily,
  weekly,
  monthly,
  yearly,
}
