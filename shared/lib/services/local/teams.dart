import 'package:sembast/sembast.dart';
import 'package:shared/models/team.dart';
import 'package:shared/services/api_service.dart';

class TeamsLocalService extends TeamsApiService {
  final Database db;

  static const String teamsStoreName = 'teams';
  final teamsStore = intMapStoreFactory.store(teamsStoreName);

  TeamsLocalService(this.db);

  @override
  Future<Team> createTeam(Team team) => teamsStore
      .add(db, team.toJson())
      .then((value) => team.copyWith(id: value));

  @override
  Future<List<Team>> fetchTeams() => teamsStore.find(db).then((value) => value
      .map((e) => Team.fromJson(Map.from(e.value)..["id"] = e.key))
      .toList());

  @override
  Future<int> fetchTeamsCount() => teamsStore.count(db);

  @override
  Future<Team?> fetchTeam(int id) => teamsStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null
      ? null
      : Team.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateTeam(Team team) => teamsStore.update(db, team.toJson(),
      finder: Finder(filter: Filter.byKey(team.id)));

  @override
  Future<void> deleteTeam(int id) =>
      teamsStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<Team>> onTeams() =>
      teamsStore.query().onSnapshots(db).map((event) => event
          .map((e) => Team.fromJson(Map.from(e.value)..["id"] = e.key))
          .toList());

  @override
  Stream<Team?> onTeam(int id) => teamsStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) =>
  e == null ? null : Team.fromJson(Map.from(e.value)..["id"] = e.key));
}