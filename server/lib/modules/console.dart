import 'dart:io';

import 'package:server/server.dart';

class ConsoleModule extends Module {
  @override
  void start(WebServer server) {
    printInfo("Enter \\h to open the help page");
    _runConsole(server);
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

  void printInfo(String text) {
    print('\x1B[34m$text\x1B[0m');
  }

  void _runConsole(WebServer server) {
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
      }
      stdout.write("\n> ");
    });
  }

  Future<void> _executeCommand(
      WebServer server, String command, String? value) async {
    switch (command) {
      case "s":
      case "stop":
        print("Stopping server...");
        server.stop();
        exit(0);
      case "r":
      case "reset":
        print("Resetting database? Use \\reset!");
        break;
      case "h":
      case "help":
        print("Modules: \n${server.modules.map((e) => e.name).join(', ')}");
        break;
      default:
        printWarning("Command not found! Please use \\help for help");
    }
  }
}
