import 'package:dart_mappable/dart_mappable.dart';
import 'dart:typed_data';

import '../model.dart';

part 'model.mapper.dart';

@MappableClass()
final class Group
    with GroupMappable, IdentifiedModel, NamedModel, DescriptiveModel {
  @override
  final Uint8List? id;
  @override
  final String name, description;
  final Uint8List? parentId;

  const Group({
    this.id,
    this.name = '',
    this.description = '',
    this.parentId,
  });

  factory Group.fromDatabase(Map<String, dynamic> row) => GroupMapper.fromMap({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toMap(),
      };
}
