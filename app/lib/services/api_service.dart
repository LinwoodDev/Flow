import 'package:shared/team.dart';

abstract class ApiService {
  Future<List<Team>> fetchTeams();
  Future<Team> createTeam(Team team);
  Future<Team?> fetchTeam(int id);
  Future<void> updateTeam(Team team);
  Future<void> deleteTeam(int id);
}
