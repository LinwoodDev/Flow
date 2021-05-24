import 'package:moor/moor.dart';
import 'package:shared/badge.dart';
import 'package:shared/event.dart';
import 'package:shared/place.dart';
import 'package:shared/series.dart';
import 'package:shared/team.dart';
import 'package:shared/user.dart';

part 'database.g.dart';

@UseMoor(tables: [Badges, Events, Places, SeriesCollection, Teams, TeamUsers, Users])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase(QueryExecutor e) : super(e);

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}
