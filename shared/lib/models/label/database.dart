import 'dart:async';

import 'package:lib5/lib5.dart';
import 'package:shared/models/label/model.dart';
import 'package:shared/models/label/service.dart';
import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

class LabelDatabaseService extends LabelService with TableService {
  LabelDatabaseService();

  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS labels (
        id BLOB(16) PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        color INTEGER NOT NULL DEFAULT 0
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  Future<Label?> createLabel(Label label) async {
    final id = label.id ?? createUniqueMultihash();
    label = label.copyWith(id: id);
    final row = await db?.insert('labels', label.toDatabase());
    if (row == null) return null;
    return label;
  }

  @override
  Future<bool> deleteLabel(Multihash id) async {
    return await db?.delete(
          'labels',
          where: 'id = ?',
          whereArgs: [id.fullBytes],
        ) ==
        1;
  }

  @override
  Future<List<Label>> getLabels({
    int offset = 0,
    int limit = 50,
    String search = '',
  }) async {
    String? where;
    List<Object>? whereArgs;
    if (search.isNotEmpty) {
      where = 'name LIKE ?';
      whereArgs = ['%$search%'];
    }
    final result = await db?.query(
      'labels',
      where: where,
      whereArgs: whereArgs,
      offset: offset,
      limit: limit,
    );
    if (result == null) return [];
    return result.map(Label.fromDatabase).toList();
  }

  @override
  Future<bool> updateLabel(Label label) async {
    return await db?.update(
          'labels',
          label.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [label.id?.fullBytes],
        ) ==
        1;
  }

  @override
  Future<void> clear() async {
    await db?.delete('labels');
  }
}
