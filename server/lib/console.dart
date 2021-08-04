import 'dart:io';

import 'package:flow_server/routes/home.dart';
import 'package:flow_server/server_route.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared/services/local/service.dart';
import 'package:shared/socket_package.dart';

const help = """

\\help\tGet the help
\\h
\\stop\tStop the server
\\s
\\reset\tReset the database
\\r

To execute a route, use:
<Route> [<value>]""";

void startConsole(HttpServer serverSocket) {
  printSuccess("Enter \\h to open the help page");
  _runConsole(serverSocket);
}

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printSuccess(String text) {
  print('\x1B[32m$text\x1B[0m');
}

void printError(String text) {
  print('\x1B[31m$text\x1B[0m');
}

void printQuote(String text) {
  print('\x1B[3m$text\x1B[0m');
}

Future<void> _runConsole(HttpServer server) async {
  stdout.write("\n> ");
  stdin.listen((event) async {
    var console = String.fromCharCodes(event);
    console = console.trim();
    int pathIndex = console.indexOf(' ');

    String path = console;
    String? value;
    if (pathIndex >= 0) {
      path = console.substring(0, pathIndex);
      value = console.substring(pathIndex);
    }
    if (path.startsWith("\\")) {
      _executeCommand(server, path.substring(1), value);
    } else if (!await handleHomeSockets(
            ConsoleRoute(server, SocketPackage(route: path, value: value)))
        .catchError((e) {
      printError(e.toString());
      return true;
    })) {
      printWarning("No route was found!");
    }
    stdout.write("\n> ");
  });
}

Future<void> _executeCommand(
    HttpServer server, String command, String? value) async {
  switch (command) {
    case "s":
    case "stop":
      print("Stopping server...");
      server.close();
      exit(0);
    case "r":
    case "reset":
      print("Resetting database? Use \\reset!");
      break;
    case "reset!":
      var dir = Directory.current;
      var dbPath = join(dir.path, 'linwood_flow.db');
      // open the database
      await GetIt.I.unregister<LocalService>();
      await databaseFactoryIo.deleteDatabase(dbPath);
      var db = await databaseFactoryIo.openDatabase(dbPath);

      GetIt.I.registerSingleton(LocalService(db));
      break;
    case "h":
    case "help":
      print(help);
      break;
    default:
      printWarning("Command not found! Please use \\help for help");
  }
}
