import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:typed_data';

import '../../helpers/converter.dart';
import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Group with _$Group, IdentifiedModel, NamedModel, DescriptiveModel {
  const Group._();

  @Implements<DescriptiveModel>()
  const factory Group({
    @Uint8ListConverter() Uint8List? id,
    @Default('') String name,
    @Default('') String description,
    @Uint8ListConverter() Uint8List? parentId,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  factory Group.fromDatabase(Map<String, dynamic> row) => Group.fromJson({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
      };
}
