import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lib5/lib5.dart';
import 'package:shared/helpers/converter.dart';
import 'package:shared/models/model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Label with _$Label {
  const Label._();

  @Implements<DescriptiveModel>()
  const factory Label({
    @MultihashConverter() Multihash? id,
    @Default('') String name,
    @Default('') String description,
    @Default(0) int color,
  }) = _Label;

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);

  factory Label.fromDatabase(Map<String, dynamic> row) => Label.fromJson({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
      };
}
