import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/converter.dart';
import '../../model.dart';
import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Moment with _$Moment {
  const Moment._();

  @Implements<DescriptiveModel>()
  const factory Moment({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    int? eventId,
    @Default(EventStatus.confirmed) EventStatus status,
    @DateTimeConverter() DateTime? time,
  }) = _Moment;

  factory Moment.fromJson(Map<String, dynamic> json) => _$MomentFromJson(json);
}
