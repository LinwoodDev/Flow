import 'package:dart_mappable/dart_mappable.dart';
import 'package:flow_api/services/database.dart';

import 'event/item/model.dart';
import 'event/model.dart';
import 'note/model.dart';

part 'cached.mapper.dart';

@MappableClass()
class CachedData with CachedDataMappable {
  final DateTime? lastUpdated;
  final List<Event> events;
  final List<Notebook> notebooks;
  final List<CalendarItem> items;
  final List<Note> notes;

  const CachedData({
    this.lastUpdated,
    this.events = const [],
    this.notebooks = const [],
    this.items = const [],
    this.notes = const [],
  });

  CachedData concat(CachedData other) {
    return CachedData(
      lastUpdated: other.lastUpdated ?? lastUpdated,
      events: [
        ...events,
        ...other.events
            .where((e) => !events.any((e2) => equalUint8List(e2.id, e.id)))
      ],
      notebooks: [
        ...notebooks,
        ...other.notebooks
            .where((e) => !notebooks.any((e2) => equalUint8List(e2.id, e.id)))
      ],
      items: [
        ...items,
        ...other.items
            .where((e) => !items.any((e2) => equalUint8List(e2.id, e.id)))
      ],
      notes: [
        ...notes,
        ...other.notes
            .where((e) => !notes.any((e2) => equalUint8List(e2.id, e.id)))
      ],
    );
  }
}
