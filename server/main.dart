// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<void> init(InternetAddress ip, int port) async {
  // Test if frontend is there
  final frontendDir = Directory('frontend');
  if (!frontendDir.existsSync()) {
    print('''
Frontend directory not found.
Please build the frontend and place it in the frontend directory.
''');
    exit(1);
  }
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(handler, ip, port);
}
