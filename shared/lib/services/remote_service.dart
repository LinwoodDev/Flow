import 'package:shared/models/badge.dart';
import 'package:shared/models/event.dart';
import 'package:shared/models/season.dart';
import 'package:shared/models/task.dart';
import 'package:shared/models/team.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/api_service.dart';

class RemoteService extends ApiService {
  // Team operations
  @override
  Future<List<Team>> fetchTeams() {
    throw UnimplementedError();
  }

  @override
  Future<Team> createTeam(Team team) {
    throw UnimplementedError();
  }

  @override
  Future<Team?> fetchTeam(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTeam(Team team) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTeam(int id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Team>> onTeams() {
    throw UnimplementedError();
  }

  @override
  Stream<Team?> onTeam(int id) {
    throw UnimplementedError();
  }

  @override
  // User operations
  Future<List<User>> fetchUsers() {
    throw UnimplementedError();
  }

  @override
  Future<User> createUser(User user) {
    throw UnimplementedError();
  }

  @override
  Future<User?> fetchUser(int id) {
    throw UnimplementedError();
  }

  @override
  Future<User?> fetchUserByName(String name) {
    throw UnimplementedError();
  }

  @override
  Future<User?> fetchUserByEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasUser(User user) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(User user) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(int id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<User>> onUsers() {
    throw UnimplementedError();
  }

  @override
  Stream<User?> onUser(int id) {
    throw UnimplementedError();
  }

  // Event operations
  @override
  Future<List<Event>> fetchEvents() {
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> fetchOpenedEvents() {
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> fetchDoneEvents() {
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> fetchPlannedEvents() {
    throw UnimplementedError();
  }

  @override
  Future<Event> createEvent(Event event) {
    throw UnimplementedError();
  }

  @override
  Future<Event?> fetchEvent(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateEvent(Event event) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteEvent(int id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Event>> onEvents() {
    throw UnimplementedError();
  }

  @override
  Stream<Event?> onEvent(int id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Event>> onOpenedEvents() {
    throw UnimplementedError();
  }

  @override
  Stream<List<Event>> onDoneEvents() {
    throw UnimplementedError();
  }

  @override
  Stream<List<Event>> onPlannedEvents() {
    throw UnimplementedError();
  }

  @override
  // Badge operations
  Future<List<Badge>> fetchBadges() {
    throw UnimplementedError();
  }

  @override
  Future<Badge> createBadge(Badge badge) {
    throw UnimplementedError();
  }

  @override
  Future<Badge?> fetchBadge(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateBadge(Badge badge) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBadge(int id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Badge>> onBadges() {
    throw UnimplementedError();
  }

  @override
  Stream<Badge?> onBadge(int id) {
    throw UnimplementedError();
  }

  @override
  // Season operations
  Future<List<Season>> fetchSeasons() {
    throw UnimplementedError();
  }

  @override
  Future<Season> createSeason(Season season) {
    throw UnimplementedError();
  }

  @override
  Future<Season?> fetchSeason(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateSeason(Season season) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSeason(int id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Season>> onSeasons() {
    throw UnimplementedError();
  }

  @override
  Stream<Season?> onSeason(int id) {
    throw UnimplementedError();
  }

  @override
  // Task operations
  Future<List<Task>> fetchTasks() {
    throw UnimplementedError();
  }

  @override
  Future<Task> createTask(Task task) {
    throw UnimplementedError();
  }

  @override
  Future<Task?> fetchTask(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task task) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(int id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Task>> onTasks() {
    throw UnimplementedError();
  }

  @override
  Stream<Task?> onTask(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Submission>> fetchSubmissions(int task, {SubmissionState? state}) {
    throw UnimplementedError();
  }

  @override
  Future<Submission?> fetchSubmission(int task, int user) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Submission>> onSubmissions(int task, {SubmissionState? state}) {
    throw UnimplementedError();
  }

  @override
  Stream<Submission?> onSubmission(int task, int user) {
    throw UnimplementedError();
  }
}
