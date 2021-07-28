import 'dart:convert';
import 'dart:io';

import 'package:flow_server/routes/home.dart';
import 'package:flow_server/services/jwt.dart';
import 'package:flow_server/socket_route.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared/services/local_service.dart';
import 'package:shared/socket_package.dart';

Future<void> main(List<String> arguments) async {
  await initServices();
  final address = Platform.environment["flow.address"] ?? "localhost";
  final port = int.fromEnvironment('flow.port', defaultValue: 3000);
  GetIt.I.registerSingleton(<Socket>[], instanceName: "sockets");
  final sockets = GetIt.I.get<List<Socket>>(instanceName: "sockets");
  final server = await ServerSocket.bind(address, port);
  server.listen((client) {
    sockets.add(client);
    client.listen((bytes) {
      var message = String.fromCharCodes(bytes);
      var data = json.decode(message);
      handleHomeSockets(SocketRoute(server, client, SocketPackage.fromJson(data)));
    },
      // handle errors
      onError: (error) {
        print(error);
        client.close();
        sockets.remove(client);
      },

      // handle the client closing the connection
      onDone: () {
        print('Client left');
        client.close();
        sockets.remove(client);
      },);
  });
  print('Server running on $address:${server.port}');
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
  final address = Platform.environment["flow.address"];
  GetIt.I.registerSingleton(JWTService(
      Platform.environment['flow.secret'] ?? '',
      address ?? "http://localhost"));
}
