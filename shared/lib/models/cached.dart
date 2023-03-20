import 'package:freezed_annotation/freezed_annotation.dart';

import 'event/model.dart';
import 'note/model.dart';

part 'cached.freezed.dart';
part 'cached.g.dart';

@freezed
class CachedData with _$CachedData {
  factory CachedData({
    DateTime? lastUpdated,
    @Default([]) List<Event> events,
    @Default([]) List<Appointment> appointments,
    @Default([]) List<Note> notes,
  }) = _CachedData;

  factory CachedData.fromJson(Map<String, dynamic> json) =>
      _$CachedDataFromJson(json);
}
