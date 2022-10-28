import 'dart:io';

import 'package:server/server.dart';

class ConsoleModule extends Module {
  ConsoleModule(super.server);

  @override
  void start() {
    printInfo("Enter \\h to open the help page");
    _runConsole();
  }

  @override
  void printWarning(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  @override
  void printSuccess(String text) {
    print('\x1B[32m$text\x1B[0m');
  }

  @override
  void printError(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  @override
  void printQuote(String text) {
    print('\x1B[3m$text\x1B[0m');
  }

  @override
  void printInfo(String text) {
    print('\x1B[34m$text\x1B[0m');
  }

  void _runConsole() {
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
        _executeCommand(path.substring(1), value);
      }
      stdout.write("\n> ");
    });
  }

  Future<void> _executeCommand(String command, String? value) async {
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
