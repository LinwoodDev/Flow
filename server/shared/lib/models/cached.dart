import 'package:freezed_annotation/freezed_annotation.dart';

import 'event/item/model.dart';
import 'event/model.dart';
import 'note/model.dart';

part 'cached.freezed.dart';
part 'cached.g.dart';

@freezed
class CachedData with _$CachedData {
  const CachedData._();

  const factory CachedData({
    DateTime? lastUpdated,
    @Default([]) List<Event> events,
    @Default([]) List<CalendarItem> items,
    @Default([]) List<Note> notes,
  }) = _CachedData;

  factory CachedData.fromJson(Map<String, dynamic> json) =>
      _$CachedDataFromJson(json);

  CachedData concat(CachedData other) {
    return CachedData(
      lastUpdated: other.lastUpdated ?? lastUpdated,
      events: [
        ...events,
        ...other.events.where((e) => !events.any((e2) => e2.id == e.id))
      ],
      items: [
        ...items,
        ...other.items.where((e) => !items.any((e2) => e2.id == e.id))
      ],
      notes: [
        ...notes,
        ...other.notes.where((e) => !notes.any((e2) => e2.id == e.id))
      ],
    );
  }
}
