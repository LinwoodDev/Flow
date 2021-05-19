import 'package:flow_app/database.dart';
import 'package:moor/moor_web.dart';

MyDatabase constructDb() {
  return MyDatabase(WebDatabase('db'));
}
