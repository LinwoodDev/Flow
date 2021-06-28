import 'dart:async';

import 'package:flow_app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:shared/badge.dart';
import 'package:shared/event.dart';
import 'package:shared/season.dart';
import 'package:shared/task.dart';
import 'package:shared/team.dart';
import 'package:shared/user.dart';

class LocalService extends ApiService {
  final Database db;

  LocalService(this.db);

  static Future<LocalService> create() async {
    if (kIsWeb) {
      var factory = databaseFactoryWeb;

      // Open the database
      var db = await factory.openDatabase('test');
      return LocalService(db);
    } else {
      // get the application documents directory
      var dir = await getApplicationDocumentsDirectory();
// make sure it exists
      await dir.create(recursive: true);
// build the database path
      var dbPath = join(dir.path, 'linwood_flow.db');
// open the database
      var db = await databaseFactoryIo.openDatabase(dbPath);
      return LocalService(db);
    }
  }

  // Team operations
  static const String teamsStoreName = 'teams';
  final teamsStore = intMapStoreFactory.store(teamsStoreName);

  @override
  Future<Team> createTeam(Team team) => teamsStore.add(db, team.toJson()).then((value) => team.copyWith(id: value));

  @override
  Future<List<Team>> fetchTeams() =>
      teamsStore.find(db).then((value) => value.map((e) => Team.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Future<Team?> fetchTeam(int id) => teamsStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null ? null : Team.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateTeam(Team team) =>
      teamsStore.update(db, team.toJson(), finder: Finder(filter: Filter.byKey(team.id)));

  @override
  Future<void> deleteTeam(int id) => teamsStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<Team>> onTeams() => teamsStore
      .query()
      .onSnapshots(db)
      .map((event) => event.map((e) => Team.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Stream<Team?> onTeam(int id) => teamsStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) => e == null ? null : Team.fromJson(Map.from(e.value)..["id"] = e.key));

  // User operations
  static const String usersStoreName = 'users';
  final usersStore = intMapStoreFactory.store(usersStoreName);

  @override
  Future<User> createUser(User user) => usersStore.add(db, user.toJson()).then((value) => user.copyWith(id: value));

  @override
  Future<List<User>> fetchUsers() =>
      usersStore.find(db).then((value) => value.map((e) => User.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Future<User?> fetchUser(int id) => usersStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null ? null : User.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateUser(User user) =>
      usersStore.update(db, user.toJson(), finder: Finder(filter: Filter.byKey(user.id)));

  @override
  Future<void> deleteUser(int id) => usersStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<User>> onUsers() => usersStore
      .query()
      .onSnapshots(db)
      .map((event) => event.map((e) => User.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Stream<User?> onUser(int id) => usersStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) => e == null ? null : User.fromJson(Map.from(e.value)..["id"] = e.key));

  // Event operations
  static const String eventsStoreName = 'events';
  final eventsStore = intMapStoreFactory.store(eventsStoreName);

  @override
  Future<Event> createEvent(Event event) =>
      eventsStore.add(db, event.toJson()).then((value) => event.copyWith(id: value));

  @override
  Future<List<Event>> fetchEvents() => eventsStore
      .find(db)
      .then((value) => value.map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Future<List<Event>> fetchOpenedEvents() => eventsStore
      .find(db, finder: Finder(filter: Filter.and([Filter.isNull("date-time"), Filter.equals("canceled", false)])))
      .then((value) => value.map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Future<List<Event>> fetchDoneEvents() => eventsStore
      .find(db,
          finder: Finder(
              filter: Filter.and([
            Filter.not(Filter.isNull("date-time")),
            Filter.custom(
                (record) => DateTime.tryParse(record['date-time'] as String? ?? "")?.isAfter(DateTime.now()) ?? false)
          ])))
      .then((value) => value.map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Future<List<Event>> fetchPlannedEvents() => eventsStore
      .find(db,
          finder: Finder(
              filter: Filter.and([
            Filter.not(Filter.isNull("date-time")),
            Filter.custom((record) =>
                !(DateTime.tryParse(record['date-time'] as String? ?? "")?.isAfter(DateTime.now()) ?? false))
          ])))
      .then((value) => value.map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Future<Event?> fetchEvent(int id) => eventsStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null ? null : Event.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateEvent(Event event) =>
      eventsStore.update(db, event.toJson(), finder: Finder(filter: Filter.byKey(event.id)));

  @override
  Future<void> deleteEvent(int id) => eventsStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<Event>> onEvents() => eventsStore
      .query()
      .onSnapshots(db)
      .map((event) => event.map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Stream<Event?> onEvent(int id) => eventsStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) => e == null ? null : Event.fromJson(Map.from(e.value)..["id"] = e.key));

  @override
  Stream<List<Event>> onOpenedEvents() => eventsStore
      .query(finder: Finder(filter: Filter.and([Filter.isNull("date-time"), Filter.equals("canceled", false)])))
      .onSnapshots(db)
      .map((event) => event.map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Stream<List<Event>> onPlannedEvents() => eventsStore
      .query(
          finder: Finder(
              filter: Filter.and([
        Filter.not(Filter.isNull("date-time")),
        Filter.custom(
            (record) => !(DateTime.tryParse(record['date-time'] as String? ?? "")?.isAfter(DateTime.now()) ?? false))
      ])))
      .onSnapshots(db)
      .map((event) => event.map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Stream<List<Event>> onDoneEvents() => eventsStore
      .query()
      .onSnapshots(db)
      .map((event) => event.map((e) => Event.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  // Badge operations
  static const String badgesStoreName = 'badges';
  final badgesStore = intMapStoreFactory.store(badgesStoreName);

  @override
  Future<Badge> createBadge(Badge badge) =>
      badgesStore.add(db, badge.toJson()).then((value) => badge.copyWith(id: value));

  @override
  Future<List<Badge>> fetchBadges() => badgesStore
      .find(db)
      .then((value) => value.map((e) => Badge.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Future<Badge?> fetchBadge(int id) => badgesStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null ? null : Badge.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateBadge(Badge badge) =>
      badgesStore.update(db, badge.toJson(), finder: Finder(filter: Filter.byKey(badge.id)));

  @override
  Future<void> deleteBadge(int id) => badgesStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<Badge>> onBadges() => badgesStore
      .query()
      .onSnapshots(db)
      .map((badge) => badge.map((e) => Badge.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Stream<Badge?> onBadge(int id) => badgesStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) => e == null ? null : Badge.fromJson(Map.from(e.value)..["id"] = e.key));

  // Season operations
  static const String seasonsStoreName = 'seasons';
  final seasonsStore = intMapStoreFactory.store(seasonsStoreName);

  @override
  Future<Season> createSeason(Season season) =>
      seasonsStore.add(db, season.toJson()).then((value) => season.copyWith(id: value));

  @override
  Future<List<Season>> fetchSeasons() => seasonsStore
      .find(db)
      .then((value) => value.map((e) => Season.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Future<Season?> fetchSeason(int id) => seasonsStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null ? null : Season.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateSeason(Season season) =>
      seasonsStore.update(db, season.toJson(), finder: Finder(filter: Filter.byKey(season.id)));

  @override
  Future<void> deleteSeason(int id) => seasonsStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<Season>> onSeasons() => seasonsStore
      .query()
      .onSnapshots(db)
      .map((season) => season.map((e) => Season.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Stream<Season?> onSeason(int id) => seasonsStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) => e == null ? null : Season.fromJson(Map.from(e.value)..["id"] = e.key));

  // Task operations
  static const String tasksStoreName = 'tasks';
  final tasksStore = intMapStoreFactory.store(tasksStoreName);

  @override
  Future<Task> createTask(Task task) => tasksStore.add(db, task.toJson()).then((value) => task.copyWith(id: value));

  @override
  Future<List<Task>> fetchTasks() =>
      tasksStore.find(db).then((value) => value.map((e) => Task.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Future<Task?> fetchTask(int id) => tasksStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null ? null : Task.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateTask(Task task) =>
      tasksStore.update(db, task.toJson(), finder: Finder(filter: Filter.byKey(task.id)));

  @override
  Future<void> deleteTask(int id) => tasksStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<Task>> onTasks() => tasksStore
      .query()
      .onSnapshots(db)
      .map((task) => task.map((e) => Task.fromJson(Map.from(e.value)..["id"] = e.key)).toList());

  @override
  Stream<Task?> onTask(int id) => tasksStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) => e == null ? null : Task.fromJson(Map.from(e.value)..["id"] = e.key));
}
