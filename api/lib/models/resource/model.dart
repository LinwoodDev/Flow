import 'package:dart_mappable/dart_mappable.dart';
import 'dart:typed_data';

import '../model.dart';

part 'model.mapper.dart';

@MappableClass()
class Resource
    with ResourceMappable, IdentifiedModel, NamedModel, DescriptiveModel {
  @override
  final Uint8List? id;
  @override
  final String name, description;
  final String address;

  const Resource({
    this.id,
    this.name = '',
    this.description = '',
    this.address = '',
  });

  factory Resource.fromDatabase(Map<String, dynamic> row) =>
      ResourceMapper.fromMap({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toMap(),
      };
}
