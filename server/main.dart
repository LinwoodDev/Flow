// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:flow_server/utils.dart';
import 'package:shared/models/error.dart';

const supportedVersions = [0];

// Add version as
const _apiPattern = r'^/api/v(\d+)(?:/(.*))?';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  const customStaticFilePath = 'static';
  final cascade = Cascade()
      .add(createStaticFileHandler(path: customStaticFilePath))
      .add(handler)
      .add((context) {
    final path = context.request.uri.path;
    final match = RegExp(_apiPattern).firstMatch(path);
    if (match != null) {
      final apiVersion = int.tryParse(match.group(1) ?? '');
      if (!supportedVersions.contains(apiVersion)) {
        return errorResponse(ErrorType.invalidApiVersion);
      }
    }
    return errorResponse(ErrorType.notFound);
  }).add((context) => errorResponse(ErrorType.notFound));

  return serve(cascade.handler, ip, port);
}
