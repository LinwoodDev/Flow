import 'package:shared/team.dart';

abstract class ApiService {
  Future<List<Team>> fetchTeams();
  Future<void> createTeam(Team team);
}
