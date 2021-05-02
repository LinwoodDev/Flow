import 'dart:convert';

import 'package:flow_server/session.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

part 'main.g.dart';

class Service {
  // Handlers can be asynchronous (returning `FutureOr` is also allowed).
  @Route.get('/')
  Future<Response> _info(Request request) async {
    return Response.ok(json.encode({'name': 'linwood-flow'}));
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

void main(List<String> arguments) async {
  final service = Service();
  final server = await shelf_io.serve(
      service.handler, 'localhost', int.fromEnvironment('flow.port', defaultValue: 3000));
  print('Server running on localhost:${server.port}');
}
