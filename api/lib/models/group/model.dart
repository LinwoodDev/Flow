import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lib5/lib5.dart';

import '../../helpers/converter.dart';
import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Group with _$Group {
  const Group._();

  @Implements<DescriptiveModel>()
  const factory Group({
    @MultihashConverter() Multihash? id,
    @Default('') String name,
    @Default('') String description,
    @MultihashConverter() Multihash? parentId,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  factory Group.fromDatabase(Map<String, dynamic> row) => Group.fromJson({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
      };
}
