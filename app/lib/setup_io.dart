import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared/services/local_service.dart';

Future<void> setup() async {
  // get the application documents directory
  var dir = await getApplicationDocumentsDirectory();
// make sure it exists
  await dir.create(recursive: true);
// build the database path
  var dbPath = join(dir.path, 'linwood_flow.db');
// open the database
  var db = await databaseFactoryIo.openDatabase(dbPath);
  GetIt.I.registerSingleton(LocalService(db));
}
