import 'dart:convert';
import 'dart:io';

import 'package:flow_server/console.dart';
import 'package:flow_server/routes/home.dart';
import 'package:flow_server/services/jwt.dart';
import 'package:flow_server/server_route.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/services/local/service.dart';
import 'package:shared/socket_package.dart';

Future<void> main(List<String> arguments) async {
  await initServices();
  //final address = Platform.environment["flow.address"] ?? "localhost";
  final port = int.fromEnvironment('flow.port', defaultValue: 3000);
  GetIt.I.registerSingleton(<WebSocket>[], instanceName: "sockets");
  final sockets = GetIt.I.get<List<WebSocket>>(instanceName: "sockets");
  HttpServer.bind(InternetAddress.loopbackIPv4, port).then((server) {
    print("Search server is running on "
        "'https://${server.address.address}:$port/'");
    server.listen((HttpRequest request) {
      WebSocketTransformer.upgrade(request).then((WebSocket ws) {
        sockets.add(ws);
        ws.listen((message) {
          try {
            var data = json.decode(message);
            var route = SocketRoute(server, ws, SocketPackage.fromJson(data));
            try {
              handleHomeSockets(route);
            } on FormatException catch (e) {
              ws.add(e.toString());
            } on InputException catch (e) {
              route.reply(exception: e);
            }
          } on FormatException catch (e) {
            ws.add(e.toString());
          }
        }, onError: (e) {
          sockets.remove(ws);
          print(e);
          ws.close();
        }, onDone: () {
          sockets.remove(ws);
        });
      });
    });
    startConsole(server);
  });
  stopConsole();
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
