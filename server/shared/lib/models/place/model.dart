import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lib5/lib5.dart';

import '../../helpers/converter.dart';
import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Place with _$Place {
  const Place._();

  @Implements<DescriptiveModel>()
  const factory Place({
    @MultihashConverter() Multihash? id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String address,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  factory Place.fromDatabase(Map<String, dynamic> row) => Place.fromJson({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
      };
}
