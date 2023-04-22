import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/helpers/converter.dart';
import 'package:shared/models/model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class User with _$User {
  @Implements<DescriptiveModel>()
  const factory User({
    int? id,
    int? groupId,
    @Default('') String name,
    @Default('') String email,
    @Default('') String description,
    @Default('') String phone,
    @Uint8ListConverter() Uint8List? image,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
