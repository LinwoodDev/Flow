import 'package:dart_mappable/dart_mappable.dart';
import 'dart:typed_data';

import '../model.dart';

part 'model.mapper.dart';

@MappableClass()
class Place with PlaceMappable, IdentifiedModel, NamedModel, DescriptiveModel {
  @override
  final Uint8List? id;
  @override
  final String name, description;
  final String address;

  const Place({
    this.id,
    this.name = '',
    this.description = '',
    this.address = '',
  });

  factory Place.fromDatabase(Map<String, dynamic> row) => PlaceMapper.fromMap({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toMap(),
      };
}
