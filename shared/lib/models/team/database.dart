import 'dart:async';

import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';
import 'service.dart';

class TeamDatabaseService extends TeamService with TableService {
  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS teams (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        address TEXT
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  FutureOr<Team?> createTeam(Team team) async {
    final id = await db?.insert('teams', team.toJson()..remove('id'));
    if (id == null) return null;
    return team.copyWith(id: id);
  }

  @override
  FutureOr<bool> deleteTeam(int id) async {
    return await db?.delete(
          'teams',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  FutureOr<List<Team>> getTeams(
      {int offset = 0, int limit = 50, String search = ''}) async {
    final where = search.isEmpty ? null : 'name LIKE ?';
    final whereArgs = search.isEmpty ? null : ['%$search%'];
    final result = await db?.query(
      'teams',
      limit: limit,
      offset: offset,
      where: where,
      whereArgs: whereArgs,
    );
    if (result == null) return [];
    return result.map((row) => Team.fromJson(row)).toList();
  }

  @override
  FutureOr<bool> updateTeam(Team team) async {
    return await db?.update(
          'teams',
          team.toJson()..remove('id'),
          where: 'id = ?',
          whereArgs: [team.id],
        ) ==
        1;
  }
}
