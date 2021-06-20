import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'session.dart';

part 'home.g.dart';

class Service {
  // Handlers can be asynchronous (returning `FutureOr` is also allowed).
  @Route.get('/')
  Future<Response> _info(Request request) async {
    return Response.ok(json.encode({
      'name': 'Linwood-Flow',
      'applications': ['events', 'teams', 'dev-doctor']
    }));
  }

  @Route.mount('/session/')
  Router get _session => SessionService().router;

  // You can catch all verbs and use a URL-parameter with a regular expression
  // that matches everything to catch app.
  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound('Page not found');

  // The generated function _$ServiceRouter can be used to get a [Handler]
  // for this object. This can be used with [shelf_io.serve].
  Handler get handler => _$ServiceRouter(this);
}
