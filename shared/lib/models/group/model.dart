import 'package:freezed_annotation/freezed_annotation.dart';

import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Group with _$Group {
  const Group._();

  @Implements<DescriptiveModel>()
  const factory Group({
    String? id,
    @Default('') String name,
    @Default('') String description,
    String? parentId,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  factory Group.fromDatabase(Map<String, dynamic> row) => Group.fromJson({
        ...row,
        'id': row['id']?.toString(),
        'parentId': row['parentId']?.toString(),
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
        'id': int.tryParse(id ?? ''),
        'parentId': int.tryParse(parentId ?? ''),
      };
}
