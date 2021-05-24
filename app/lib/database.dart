import 'package:moor/moor.dart';
import 'package:shared/event.dart';

part 'database.g.dart';

MyDatabase constructDb() {
  throw new UnimplementedError("This platform is not supported!");
}

@UseMoor(tables: [Events, Servers])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase(QueryExecutor e) : super(e);

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}

@UseRowClass(Server)
class Servers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get address => text()();
}

class Server implements Insertable<Server> {
  final int id;
  final String address;

  Server({required this.id, required this.address});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ServersCompanion(id: Value(id), address: Value(address)).toColumns(nullToAbsent);
  }
}
