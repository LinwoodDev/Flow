import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Place with _$Place {
  const factory Place({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String address,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}
