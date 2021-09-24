import 'dart:convert';
import 'dart:io';

import 'package:flow_server/console.dart';
import 'package:flow_server/routes/home.dart';
import 'package:flow_server/server_route.dart';
import 'package:flow_server/services/config.dart';
import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/services/local/service.dart';
import 'package:shared/socket_package.dart';

Future<void> main(List<String> arguments) async {
  print("Starting Linwood Flow backend server...");
  await initServices();
  final address =
      Platform.environment["FLOW_ADDRESS"] ?? InternetAddress.anyIPv6;
  final port = int.fromEnvironment('FLOW_PORT', defaultValue: 8000);
  final secure = bool.fromEnvironment('FLOW_SECURE', defaultValue: false);
  GetIt.I.registerSingleton(<WebSocket>[], instanceName: "sockets");
  final sockets = GetIt.I.get<List<WebSocket>>(instanceName: "sockets");
  late HttpServer server;

  // SSL
  if (secure) {
    SecurityContext context = SecurityContext();
    var chain =
        Platform.script.resolve('certificates/server_chain.pem').toFilePath();
    var key =
        Platform.script.resolve('certificates/server_key.pem').toFilePath();
    context.useCertificateChain(chain);
    context.usePrivateKey(key,
        password: Platform.environment["FLOW_PRIVATE_KEY"] ?? 'linwood-flow');

    server = await HttpServer.bindSecure(address, port, context);
  } else {
    server = await HttpServer.bind(address, port);
  }

  print("Server started on "
      "'wss://${server.address.address}:${server.port}/'");
  try {
    server.transform(WebSocketTransformer()).listen((WebSocket ws) {
      sockets.add(ws);
      print("Connected!");
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
    },
        onError: (e) => printError(e),
        onDone: () => print("Stopping websocket server..."));
  } catch (e) {
    printError(e.toString());
  }
  startConsole(server);
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

  // Create main config
  var file = File(join(dir.path, "config.json"));
  if (!(await file.exists())) {
    await file.create();
  }
  var service = ConfigService(file);
  await service.reload();
  await service.save();
  GetIt.I.registerSingleton(service);

  // JWT Service
  final address = Platform.environment["flow.address"];
  GetIt.I.registerSingleton(JWTService(
      Platform.environment['flow.secret'] ?? '',
      address ?? "http://localhost"));
}
