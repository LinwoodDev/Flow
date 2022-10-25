import 'dart:async';
import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:server/modules/auth.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'modules/console.dart';

abstract class Module {
  String get name => runtimeType.toString();

  FutureOr<void> start(WebServer server) {}
  FutureOr<void> registerRoutes(WebServer server, Router router) {}
  FutureOr<void> stop(WebServer server) {}
}

class WebServer {
  final int port;
  final String databaseUrl;
  final String jwtSecret;
  HttpServer? _server;

  HttpServer? get server => _server;

  static final List<Module> _modules = [ConsoleModule(), AuthModule()];

  WebServer(
      {this.port = 8080, required this.databaseUrl, required this.jwtSecret});

  factory WebServer.fromEnvironment() {
    final env = DotEnv()..load();
    final port = int.parse(env['PORT'] ?? '8080');
    final databaseUrl = env['DATABASE_URL']!;
    final jwtSecret = env['JWT_SECRET']!;
    return WebServer(
        port: port, databaseUrl: databaseUrl, jwtSecret: jwtSecret);
  }

  T getModule<T extends Module>() {
    return _modules.firstWhere((element) => element is T) as T;
  }

  Future<void> start() async {
    if (_server != null) {
      throw StateError('Server already started');
    }
    for (var module in _modules) {
      await module.start(this);
    }
    final Router router = Router();
    for (var module in _modules) {
      await module.registerRoutes(this, router);
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
      await module.stop(this);
    }
    await server?.close(force: true);
    _server = null;
  }

  List<Module> get modules => List.unmodifiable(_modules);

  bool get isRunning => server != null;
}
