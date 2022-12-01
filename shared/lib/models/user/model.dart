import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/helpers/converter.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class User with _$User {
  const factory User({
    @Default(-1) int id,
    int? teamId,
    @Default('') String name,
    @Default('') String email,
    @Default('') String description,
    @Default('') String phone,
    @Uint8ListConverter() Uint8List? image,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
