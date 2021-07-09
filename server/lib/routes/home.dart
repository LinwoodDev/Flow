import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'auth.dart';

part 'home.g.dart';

class Service {
  // Handlers can be asynchronous (returning `FutureOr` is also allowed).
  @Route.get('/')
  Future<Response> _info(Request request) async {
    return Response.ok(
        json.encode({
          'name': 'Linwood-Flow',
          'applications': ['events', 'teams', 'dev-doctor']
        }),
        headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType});
  }

  @Route.mount('/auth/')
  Router get _auth => AuthService().router;

  /*@Route.mount('/profile/')
  Handler _profile(Request request) {
    var jwtService = GetIt.I.get<JWTService>();
    return Pipeline().addMiddleware(jwtService.checkAuthorization()).addHandler(ProfileService().router);
  }*/

  // You can catch all verbs and use a URL-parameter with a regular expression
  // that matches everything to catch app.
  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound('Page not found');

  // The generated function _$ServiceRouter can be used to get a [Handler]
  // for this object. This can be used with [shelf_io.serve].
  Handler get handler => Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(GetIt.I.get<JWTService>().handleAuth())
      .addHandler(_$ServiceRouter(this));
}
