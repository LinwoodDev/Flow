import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:typed_data';
import 'package:flow_api/helpers/converter.dart';
import 'package:flow_api/models/model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Label with _$Label, IdentifiedModel, NamedModel, DescriptiveModel {
  const Label._();

  @Implements<DescriptiveModel>()
  const factory Label({
    @Uint8ListConverter() Uint8List? id,
    @Default('') String name,
    @Default('') String description,
    @Default(kColorBlack) int color,
  }) = _Label;

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);

  factory Label.fromDatabase(Map<String, dynamic> row) => Label.fromJson({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
      };
}
