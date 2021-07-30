import 'package:shared/models/badge.dart';
import 'package:shared/models/event.dart';
import 'package:shared/models/season.dart';
import 'package:shared/models/task.dart';
import 'package:shared/models/team.dart';
import 'package:shared/models/user.dart';

abstract class ApiService {
  TeamsApiService get teams;

  UsersApiService get users;

  EventsApiService get events;

  BadgesApiService get badges;

  SeasonsApiService get seasons;

  TasksApiService get tasks;

  SubmissionsApiService get submissions;
}

abstract class TeamsApiService {
  Future<List<Team>> fetchTeams();

  Future<int> fetchTeamsCount();

  Future<Team> createTeam(Team team);

  Future<Team?> fetchTeam(int id);

  Future<void> updateTeam(Team team);

  Future<void> deleteTeam(int id);

  Stream<List<Team>> onTeams();

  Stream<Team?> onTeam(int id);
}

abstract class UsersApiService {
  Future<List<User>> fetchUsers();

  Future<int> fetchUsersCount();

  Future<User> createUser(User user);

  Future<User?> fetchUser(int id);

  Future<User?> fetchUserByName(String name);

  Future<User?> fetchUserByEmail(String email);

  Future<bool> hasUser(User user);

  Future<void> updateUser(User user);

  Future<void> deleteUser(int id);

  Stream<List<User>> onUsers();

  Stream<User?> onUser(int id);
}

abstract class EventsApiService {
  Future<List<Event>> fetchEvents();

  Future<int> fetchEventsCount();

  Future<List<Event>> fetchOpenedEvents();

  Future<List<Event>> fetchDoneEvents();

  Future<List<Event>> fetchPlannedEvents();

  Future<Event> createEvent(Event event);

  Future<Event?> fetchEvent(int id);

  Future<void> updateEvent(Event event);

  Future<void> deleteEvent(int id);

  Stream<List<Event>> onEvents();

  Stream<Event?> onEvent(int id);

  Stream<List<Event>> onOpenedEvents();

  Stream<List<Event>> onDoneEvents();

  Stream<List<Event>> onPlannedEvents();
}

abstract class BadgesApiService {
  Future<List<Badge>> fetchBadges();

  Future<int> fetchBadgesCount();

  Future<Badge> createBadge(Badge badge);

  Future<Badge?> fetchBadge(int id);

  Future<void> updateBadge(Badge badge);

  Future<void> deleteBadge(int id);

  Stream<List<Badge>> onBadges();

  Stream<Badge?> onBadge(int id);
}

abstract class SeasonsApiService {
  Future<List<Season>> fetchSeasons();

  Future<int> fetchSeasonsCount();

  Future<Season> createSeason(Season season);

  Future<Season?> fetchSeason(int id);

  Future<void> updateSeason(Season season);

  Future<void> deleteSeason(int id);

  Stream<List<Season>> onSeasons();

  Stream<Season?> onSeason(int id);
}

abstract class TasksApiService {
  Future<List<Task>> fetchTasks();

  Future<int> fetchTasksCount();

  Future<Task> createTask(Task task);

  Future<Task?> fetchTask(int id);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(int id);

  Stream<List<Task>> onTasks();

  Stream<Task?> onTask(int id);
}

abstract class SubmissionsApiService {
  Future<List<Submission>> fetchSubmissions(int task, {SubmissionState? state});

  Future<int> fetchSubmissionsCount(int task, {SubmissionState? state});

  Future<Submission?> fetchSubmission(int task, int user);

  Stream<List<Submission>> onSubmissions(int task, {SubmissionState? state});

  Stream<Submission?> onSubmission(int task, int user);

  Future<void> createSubmission(Submission submission);

  Future<void> updateSubmission(Submission submission);

  Future<void> deleteSubmission(int id);
}
