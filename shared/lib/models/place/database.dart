import 'dart:async';

import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';
import 'service.dart';

class PlaceDatabaseService extends PlaceService with TableService {
  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS places (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        address TEXT,
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  FutureOr<Place?> createPlace(Place place) async {
    final id = await db?.insert('places', place.toJson()..remove('id'));
    if (id == null) return null;
    return place.copyWith(id: id);
  }

  @override
  FutureOr<bool> deletePlace(int id) async {
    return await db?.delete(
          'places',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  FutureOr<List<Place>> getPlaces(
      {int offset = 0, int limit = 50, String search = ''}) async {
    final where = search.isEmpty ? null : 'name LIKE ?';
    final whereArgs = search.isEmpty ? null : ['%$search%'];
    final result = await db?.query(
      'places',
      limit: limit,
      offset: offset,
      where: where,
      whereArgs: whereArgs,
    );
    if (result == null) return [];
    return result.map((row) => Place.fromJson(row)).toList();
  }

  @override
  FutureOr<bool> updatePlace(Place place) async {
    return await db?.update(
          'places',
          place.toJson()..remove('id'),
          where: 'id = ?',
          whereArgs: [place.id],
        ) ==
        1;
  }
}
