import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flow_server/console.dart';
import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/socket_package.dart';

const tabEncoder = JsonEncoder.withIndent("\t");

abstract class ServerRoute {
  final HttpServer serverSocket;
  final SocketPackage package;

  ServerRoute(this.serverSocket, this.package);

  String get path => package.route;

  String? get auth => package.auth;

  String? get value => package.value;

  void reply({InputException? exception, dynamic value});

  void broadcast({InputException? exception, dynamic value}) {
    var package =
        SocketPackage(route: path, exception: exception, value: value);
    GetIt.I
        .get<List<Socket>>(instanceName: 'sockets')
        .forEach((element) => element.write(tabEncoder.convert(package.toJson())));
    _printSocketPackage(package);
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
      tabEncoder.convert(SocketPackage(route: path, exception: exception, value: value)
          .toJson()));
}

class ConsoleRoute extends ServerRoute {
  ConsoleRoute(HttpServer serverSocket, SocketPackage package)
      : super(serverSocket, package);

  @override
  void reply({InputException? exception, value}) => _printSocketPackage(
      SocketPackage(route: path, exception: exception, value: value));
}

void _printSocketPackage(SocketPackage package) {
  var output = tabEncoder.convert(package.value);
  printQuote("\n${package.route}");
  if (package.hasException) {
    printError(tabEncoder.convert(package.exception?.toJson()));
  } else if(!package.hasData){
    printWarning("Nothing returned");
  } else {
    printSuccess(output);
  }
}
