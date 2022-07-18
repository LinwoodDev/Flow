import 'package:sembast/sembast.dart';
import 'package:shared/models/badge.dart';
import 'package:shared/services/api_service.dart';

class BadgesLocalService extends BadgesApiService {
  final Database db;

  static const String badgesStoreName = 'badges';
  final badgesStore = intMapStoreFactory.store(badgesStoreName);

  BadgesLocalService(this.db);

  @override
  Future<Badge> createBadge(Badge badge) => badgesStore
      .add(db, badge.toJson())
      .then((value) => badge.copyWith(id: value));

  @override
  Future<List<Badge>> fetchBadges() =>
      badgesStore.find(db).then((value) => value
          .map((e) => Badge.fromJson(Map.from(e.value)..["id"] = e.key))
          .toList());

  @override
  Future<int> fetchBadgesCount() => badgesStore.count(db);

  @override
  Future<Badge?> fetchBadge(int id) => badgesStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null
          ? null
          : Badge.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateBadge(Badge badge) =>
      badgesStore.update(db, badge.toJson(),
          finder: Finder(filter: Filter.byKey(badge.id)));

  @override
  Future<void> deleteBadge(int id) =>
      badgesStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<Badge>> onBadges() =>
      badgesStore.query().onSnapshots(db).map((badge) => badge
          .map((e) => Badge.fromJson(Map.from(e.value)..["id"] = e.key))
          .toList());

  @override
  Stream<Badge?> onBadge(int id) => badgesStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) =>
          e == null ? null : Badge.fromJson(Map.from(e.value)..["id"] = e.key));
}
