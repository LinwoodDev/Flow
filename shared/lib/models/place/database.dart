import 'dart:async';

import 'package:collection/collection.dart';
import 'package:lib5/lib5.dart';
import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';
import 'service.dart';

class PlaceDatabaseService extends PlaceService with TableService {
  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS places (
        id BLOB(16) PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        address TEXT
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  Future<Place?> createPlace(Place place) async {
    final id = place.id ?? createUniqueMultihash();
    place = place.copyWith(id: id);
    final row = await db?.insert('places', place.toDatabase());
    if (row == null) return null;
    return place;
  }

  @override
  Future<bool> deletePlace(Multihash id) async {
    return await db?.delete(
          'places',
          where: 'id = ?',
          whereArgs: [id.fullBytes],
        ) ==
        1;
  }

  @override
  Future<List<Place>> getPlaces(
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
    return result.map((row) => Place.fromDatabase(row)).toList();
  }

  @override
  FutureOr<Place?> getPlace(Multihash id) async {
    final result = await db?.query(
      'places',
      where: 'id = ?',
      whereArgs: [id.fullBytes],
    );
    return result?.map(Place.fromDatabase).firstOrNull;
  }

  @override
  Future<bool> updatePlace(Place place) async {
    return await db?.update(
          'places',
          place.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [place.id?.fullBytes],
        ) ==
        1;
  }

  @override
  Future<void> clear() async {
    await db?.delete('places');
  }
}
