import 'package:shared/badge.dart';
import 'package:shared/event.dart';
import 'package:shared/season.dart';
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
  Future<User> createUser(User user);
  Future<User?> fetchUser(int id);
  Future<void> updateUser(User user);
  Future<void> deleteUser(int id);
  Stream<List<User>> onUsers();
  Stream<User?> onUser(int id);

  // Event operations
  Future<List<Event>> fetchEvents();
  Future<Event> createEvent(Event event);
  Future<Event?> fetchEvent(int id);
  Future<void> updateEvent(Event event);
  Future<void> deleteEvent(int id);
  Stream<List<Event>> onEvents();
  Stream<Event?> onEvent(int id);

  // Badge operations
  Future<List<Badge>> fetchBadges();
  Future<Badge> createBadge(Badge badge);
  Future<Badge?> fetchBadge(int id);
  Future<void> updateBadge(Badge badge);
  Future<void> deleteBadge(int id);
  Stream<List<Badge>> onBadges();
  Stream<Badge?> onBadge(int id);

  // Season operations
  Future<List<Season>> fetchSeasons();
  Future<Season> createSeason(Season season);
  Future<Season?> fetchSeason(int id);
  Future<void> updateSeason(Season season);
  Future<void> deleteSeason(int id);
  Stream<List<Season>> onSeasons();
  Stream<Season?> onSeason(int id);
}
