import 'dart:io';

import 'package:flow_server/routes/home.dart';
import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared/services/local_service.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

Future<void> main(List<String> arguments) async {
  await initServices();
  final service = Service();
  final server =
      await shelf_io.serve(service.handler, 'localhost', int.fromEnvironment('flow.port', defaultValue: 3000));
  server.autoCompress = true;
  print('Server running on localhost:${server.port}');
}

Future<void> initServices() async {
  // get the application documents directory
  var dir = Directory.current;
// make sure it exists
  await dir.create(recursive: true);
// build the database path
  var dbPath = join(dir.path, 'linwood_flow.db');
// open the database
  var db = await databaseFactoryIo.openDatabase(dbPath);
  GetIt.I.registerSingleton(LocalService(db));

  // JWT Service
  GetIt.I.registerSingleton(JWTService(Platform.environment['flow.secret'] ?? ''));
}
