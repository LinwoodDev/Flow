import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/converter.dart';
import '../../model.dart';
import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Appointment with _$Appointment {
  const Appointment._();

  @Implements<DescriptiveModel>()
  const factory Appointment.fixed({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    required int eventId,
    @Default(EventStatus.confirmed) EventStatus status,
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
  }) = FixedAppointment;

  @Implements<DescriptiveModel>()
  const factory Appointment.repeating({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    required int eventId,
    @Default(EventStatus.confirmed) EventStatus status,
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
    @Default(RepeatType.daily) RepeatType repeatType,
    @Default(1) int interval,
    @Default(0) int variation,
    @Default(0) int count,
    @DateTimeConverter() DateTime? until,
    @Default([]) List<int> exceptions,
  }) = RepeatingAppointment;

  @Implements<DescriptiveModel>()
  const factory Appointment.auto({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    required int eventId,
    @Default(EventStatus.confirmed) EventStatus status,
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
    @Default(-1) int autoGroupId,
    @DateTimeConverter() DateTime? searchStart,
    @Default(60) int autoDuration,
  }) = AutoAppointment;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  bool collidesWith(Appointment date) {
    return (date.end == null || (date.start?.isBefore(date.end!) ?? true)) &&
        (date.start == null || (date.end?.isAfter(date.start!) ?? true));
  }
}
