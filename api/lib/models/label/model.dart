import 'package:dart_leap/dart_leap.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'dart:typed_data';
import 'package:flow_api/models/model.dart';

part 'model.mapper.dart';

@MappableClass()
class Label with LabelMappable, IdentifiedModel, NamedModel, DescriptiveModel {
  @override
  final Uint8List? id;
  @override
  final String name, description;
  final SRGBColor color;

  const Label({
    this.id,
    this.name = '',
    this.description = '',
    this.color = SRGBColor.black,
  });

  factory Label.fromDatabase(Map<String, dynamic> row) => LabelMapper.fromMap({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toMap(),
      };
}
