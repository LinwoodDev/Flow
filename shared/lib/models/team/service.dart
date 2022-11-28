import 'dart:async';

import 'package:shared/services/source.dart';

import 'model.dart';

abstract class TeamService extends ModelService {
  FutureOr<List<Team>> getTeams({
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Team?> createTeam(Team team);

  FutureOr<bool> updateTeam(Team team);

  FutureOr<bool> deleteTeam(int id);
}
