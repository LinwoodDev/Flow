import 'dart:async';
import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:server/modules/auth.dart';
import 'package:server/modules/database.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'modules/console.dart';

abstract class Module {
  final WebServer server;

  Module(this.server);

  String get name => runtimeType.toString();

  FutureOr<void> start() {}
  FutureOr<void> registerRoutes(Router router) {}
  FutureOr<void> migrate(int version) {}
  FutureOr<void> stop() {}

  void printInfo(String text) {
    server.get<ConsoleModule>().printInfo(text);
  }

  void printWarning(String text) {
    server.get<ConsoleModule>().printWarning(text);
  }

  void printSuccess(String text) {
    server.get<ConsoleModule>().printSuccess(text);
  }

  void printError(String text) {
    server.get<ConsoleModule>().printError(text);
  }

  void printQuote(String text) {
    server.get<ConsoleModule>().printQuote(text);
  }
}

class WebServer {
  final int port;
  final String databaseFile;
  final String jwtSecret;
  late final List<Module> _modules;
  HttpServer? _server;

  HttpServer? get server => _server;

  List<Module> _createModules() =>
      [ConsoleModule(this), DatabaseModule(this), AuthModule(this)];

  WebServer(
      {this.port = 8080, required this.databaseFile, required this.jwtSecret}) {
    _modules = _createModules();
  }

  factory WebServer.fromEnvironment() {
    final env = DotEnv()..load();
    final port = int.parse(env['PORT'] ?? '8080');
    final databaseFile = env['DATABASE_FILE'] ?? 'database.db';
    final jwtSecret = env['JWT_SECRET']!;
    return WebServer(
        port: port, databaseFile: databaseFile, jwtSecret: jwtSecret);
  }

  T get<T extends Module>() {
    return _modules.firstWhere((element) => element is T) as T;
  }

  Future<void> start() async {
    if (_server != null) {
      throw StateError('Server already started');
    }
    for (var module in _modules) {
      await module.start();
    }
    final Router router = Router();
    for (var module in _modules) {
      await module.registerRoutes(router);
    }
    // Use any available host or container IP (usually `0.0.0.0`).
    final ip = InternetAddress.anyIPv4;

    // Configure a pipeline that logs requests.
    final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

    // For running in containers, we respect the PORT environment variable.
    final port = int.parse(Platform.environment['PORT'] ?? '8080');
    _server = await serve(handler, ip, port);
  }

  Future<void> stop() async {
    for (var module in _modules) {
      await module.stop();
    }
    await server?.close(force: true);
    _server = null;
  }

  List<Module> get modules => List.unmodifiable(_modules);

  bool get isRunning => server != null;
}
