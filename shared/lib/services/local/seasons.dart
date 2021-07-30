import 'package:sembast/sembast.dart';
import 'package:shared/models/season.dart';
import 'package:shared/services/api_service.dart';

class SeasonsLocalService extends SeasonsApiService {
  final Database db;
  static const String seasonsStoreName = 'seasons';
  final seasonsStore = intMapStoreFactory.store(seasonsStoreName);

  SeasonsLocalService(this.db);

  @override
  Future<Season> createSeason(Season season) => seasonsStore
      .add(db, season.toJson())
      .then((value) => season.copyWith(id: value));

  @override
  Future<List<Season>> fetchSeasons() =>
      seasonsStore.find(db).then((value) => value
          .map((e) => Season.fromJson(Map.from(e.value)..["id"] = e.key))
          .toList());

  @override
  Future<int> fetchSeasonsCount() => seasonsStore.count(db);

  @override
  Future<Season?> fetchSeason(int id) => seasonsStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null
          ? null
          : Season.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateSeason(Season season) =>
      seasonsStore.update(db, season.toJson(),
          finder: Finder(filter: Filter.byKey(season.id)));

  @override
  Future<void> deleteSeason(int id) =>
      seasonsStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<Season>> onSeasons() =>
      seasonsStore.query().onSnapshots(db).map((season) => season
          .map((e) => Season.fromJson(Map.from(e.value)..["id"] = e.key))
          .toList());

  @override
  Stream<Season?> onSeason(int id) => seasonsStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) => e == null
          ? null
          : Season.fromJson(Map.from(e.value)..["id"] = e.key));
}
