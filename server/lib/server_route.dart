import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/socket_package.dart';

abstract class ServerRoute {
  final HttpServer serverSocket;
  final SocketPackage package;

  ServerRoute(this.serverSocket, this.package);

  String get path => package.route;

  String? get auth => package.auth;

  String? get value => package.value;

  void reply({InputException? exception, dynamic value});

  void broadcast({InputException? exception, dynamic value}) {
    var output = json.encode(
        SocketPackage(route: path, exception: exception, value: value)
            .toJson());
    GetIt.I
        .get<List<Socket>>(instanceName: 'sockets')
        .forEach((element) => element.write(output));
    stdout.write("\n" + output);
  }

  JWT? verifyAuth() =>
      auth == null ? null : GetIt.I.get<JWTService>().verify(auth!);
}

class SocketRoute extends ServerRoute {
  final WebSocket socket;

  SocketRoute(HttpServer serverSocket, this.socket, SocketPackage package)
      : super(serverSocket, package);

  @override
  void reply({InputException? exception, dynamic value}) => socket.add(
      json.encode(SocketPackage(route: path, exception: exception, value: value)
          .toJson()));
}

class ConsoleRoute extends ServerRoute {
  ConsoleRoute(HttpServer serverSocket, SocketPackage package)
      : super(serverSocket, package);

  @override
  void reply({InputException? exception, value}) => print(json.encode(
      SocketPackage(route: path, exception: exception, value: value).toJson()));
}
