import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../main.dart';

Response onRequest(RequestContext context) {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  return Response.json(
    body: {
      'application': 'dev.linwood.flow',
      'documentation': 'https://docs.flow.linwood.dev',
      'versions': supportedVersions
    },
  );
}
