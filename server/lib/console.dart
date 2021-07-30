import 'dart:io';

import 'package:flow_server/routes/home.dart';
import 'package:flow_server/server_route.dart';
import 'package:shared/socket_package.dart';

bool _consoleRunning = false;

void startConsole(HttpServer serverSocket) async {
  _consoleRunning = true;
  while (_consoleRunning) {
    await _runConsole(serverSocket);
  }
}

void stopConsole() {
  _consoleRunning = false;
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
  String? console = stdin.readLineSync();
  if (console == null) {
    return;
  }
  console = console.trim();
  int pathIndex = console.indexOf(' ');

  String path = console;
  String? value;
  if (pathIndex >= 0) {
    path = console.substring(0, pathIndex);
    value = console.substring(pathIndex);
  }
  if(!await handleHomeSockets(
          ConsoleRoute(server, SocketPackage(route: path, value: value)))
      .catchError((e) {
        print("Error: $e");
      })) {
    printWarning("No route was found!");
  }
}
