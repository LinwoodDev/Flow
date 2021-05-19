import 'package:moor/moor.dart';
import 'package:shared/event.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

@UseRowClass(Event)
class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get series => integer()();
}

@UseMoor(tables: [Events])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite', logStatements: true));

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}
