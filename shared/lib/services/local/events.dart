import 'package:sembast/sembast.dart';
import 'package:shared/models/event.dart';
import 'package:shared/services/api_service.dart';

class EventsLocalService extends EventsApiService {
  final Database db;

  static const String eventsStoreName = 'events';
  final eventsStore = intMapStoreFactory.store(eventsStoreName);

  EventsLocalService(this.db);

  @override
  Future<Event> createEvent(Event event) => eventsStore
      .add(db, event.toJson())
      .then((value) => event.copyWith(id: value));

  @override
  Future<List<Event>> fetchEvents() =>
      eventsStore.find(db).then((value) => value
          .map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key))
          .toList());

  @override
  Future<int> fetchEventsCount() => eventsStore.count(db);

  @override
  Future<List<Event>> fetchOpenedEvents() => eventsStore
      .find(db,
      finder: Finder(
          filter: Filter.and([
            Filter.isNull("start-date-time"),
            Filter.isNull("end-date-time"),
            Filter.equals("canceled", false)
          ])))
      .then((value) => value
      .map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key))
      .toList());

  @override
  Future<List<Event>> fetchDoneEvents() => eventsStore
      .find(db,
      finder: Finder(
          filter: Filter.or([
            Filter.equals("canceled", true),
            Filter.and([
              Filter.not(Filter.isNull("start-date-time") &
              Filter.isNull("end-date-time")),
              Filter.custom((record) =>
              !(DateTime.tryParse(record['end-date-time'] as String? ?? "")
                  ?.isAfter(DateTime.now()) ??
                  true))
            ])
          ])))
      .then((value) => value
      .map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key))
      .toList());

  @override
  Future<List<Event>> fetchPlannedEvents() => eventsStore
      .find(db,
      finder: Finder(
          filter: Filter.and([
            Filter.not(Filter.isNull("start-date-time") &
            Filter.isNull("end-date-time")),
            Filter.custom((record) =>
            !(DateTime.tryParse(record['end-date-time'] as String? ?? "")
                ?.isAfter(DateTime.now()) ??
                false)),
            Filter.equals("canceled", false),
            Filter.custom((record) =>
            DateTime.tryParse(record['start-date-time'] as String? ?? "")
                ?.isAfter(DateTime.now()) ??
                true)
          ])))
      .then((value) => value
      .map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key))
      .toList());

  @override
  Future<Event?> fetchEvent(int id) => eventsStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null
      ? null
      : Event.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateEvent(Event event) =>
      eventsStore.update(db, event.toJson(),
          finder: Finder(filter: Filter.byKey(event.id)));

  @override
  Future<void> deleteEvent(int id) =>
      eventsStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<Event>> onEvents() =>
      eventsStore.query().onSnapshots(db).map((event) => event
          .map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key))
          .toList());

  @override
  Stream<Event?> onEvent(int id) => eventsStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) =>
  e == null ? null : Event.fromJson(Map.from(e.value)..["id"] = e.key));

  @override
  Stream<List<Event>> onOpenedEvents() => eventsStore
      .query(
      finder: Finder(
          filter: Filter.and([
            Filter.isNull("start-date-time"),
            Filter.isNull("end-date-time"),
            Filter.equals("canceled", false)
          ])))
      .onSnapshots(db)
      .map((event) => event
      .map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key))
      .toList());

  @override
  Stream<List<Event>> onPlannedEvents() => eventsStore
      .query(
      finder: Finder(
          filter: Filter.and([
            Filter.not(
                Filter.isNull("start-date-time") & Filter.isNull("end-date-time")),
            Filter.custom((record) =>
            DateTime.tryParse(record['end-date-time'] as String? ?? "")
                ?.isAfter(DateTime.now()) ??
                true),
            Filter.equals("canceled", false),
            Filter.custom((record) =>
            !(DateTime.tryParse(record['start-date-time'] as String? ?? "")
                ?.isAfter(DateTime.now()) ??
                false))
          ])))
      .onSnapshots(db)
      .map((event) => event
      .map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key))
      .toList());

  @override
  Stream<List<Event>> onDoneEvents() => eventsStore
      .query(
      finder: Finder(
          filter: Filter.or([
            Filter.equals("canceled", true),
            Filter.and([
              Filter.not(Filter.isNull("start-date-time") &
              Filter.isNull("end-date-time")),
              Filter.custom((record) =>
              !(DateTime.tryParse(record['end-date-time'] as String? ?? "")
                  ?.isAfter(DateTime.now()) ??
                  true))
            ])
          ])))
      .onSnapshots(db)
      .map((event) => event
      .map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key))
      .toList());
}