import 'package:sembast/sembast.dart';
import 'package:shared/services/local/events.dart';
import 'package:shared/services/local/submissions.dart';
import 'package:shared/services/local/tasks.dart';
import 'package:shared/services/local/teams.dart';
import 'package:shared/services/local/users.dart';

import '../api_service.dart';
import 'badges.dart';

class LocalService extends ApiService {
  final Database db;
  @override
  final BadgesLocalService badges;
  @override
  final EventsLocalService events;
  final SubmissionsLocalService submissions;
  @override
  final TasksLocalService tasks;
  @override
  final TeamsLocalService teams;
  @override
  final UsersLocalService users;

  LocalService(this.db)
      : badges = BadgesLocalService(db),
        events = EventsLocalService(db),
        submissions = SubmissionsLocalService(db),
        tasks = TasksLocalService(db),
        teams = TeamsLocalService(db),
        users = UsersLocalService(db);
}
