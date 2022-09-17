import 'package:server/server.dart';

Future<void> main(List<String> args) => WebServer.fromEnvironment().start();
