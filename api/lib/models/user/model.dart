import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flow_api/models/model.dart';

part 'model.mapper.dart';

@MappableClass()
class User with UserMappable, IdentifiedModel, NamedModel, DescriptiveModel {
  @override
  final Uint8List? id;
  @override
  final String name, description;
  final String email, phone;
  final Uint8List? image;

  const User({
    this.id,
    this.name = '',
    this.email = '',
    this.description = '',
    this.phone = '',
    this.image,
  });

  factory User.fromDatabase(Map<String, dynamic> row) => UserMapper.fromMap({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toMap(),
      };
}
