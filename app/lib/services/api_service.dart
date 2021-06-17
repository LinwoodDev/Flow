import 'package:shared/team.dart';
import 'package:shared/user.dart';

abstract class ApiService {
  // Team operations
  Future<List<Team>> fetchTeams();
  Future<Team> createTeam(Team team);
  Future<Team?> fetchTeam(int id);
  Future<void> updateTeam(Team team);
  Future<void> deleteTeam(int id);
  Stream<List<Team>> onTeams();
  Stream<Team?> onTeam(int id);

  // User operations
  Future<List<User>> fetchUsers();
  Future<User> createUser(User team);
  Future<User?> fetchUser(int id);
  Future<void> updateUser(User team);
  Future<void> deleteUser(int id);
  Stream<List<User>> onUsers();
  Stream<User?> onUser(int id);
}
