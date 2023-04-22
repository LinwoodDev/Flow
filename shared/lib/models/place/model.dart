import 'package:freezed_annotation/freezed_annotation.dart';

import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Place with _$Place {
  @Implements<DescriptiveModel>()
  const factory Place({
    int? id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String address,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}
