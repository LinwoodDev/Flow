import 'package:flow_app/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

MyDatabase constructDb() {
  return MyDatabase(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
}
