import 'package:flow_server/session.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

part 'main.g.dart';

class Service {
  // A handler is annotated with @Route.<verb>('<route>'), the '<route>' may
  // embed URL-parameters, and these may be taken as parameters by the handler.
  // But either all URL-parameters or none of the URL parameters must be taken
  // as parameters by the handler.
  @Route.get('/say-hi/<name>')
  Response _hi(Request request, String name) => Response.ok('hi $name');

  // Embedded URL parameters may also be associated with a regular-expression
  // that the pattern must match.
  @Route.get('/user/<userId|[0-9]+>')
  Response _user(Request request, String userId) =>
      Response.ok('User has the user-number: $userId');

  // Handlers can be asynchronous (returning `FutureOr` is also allowed).
  @Route.get('/wave')
  Future<Response> _wave(Request request) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return Response.ok('_o/');
  }

  // Other routers can be mounted...
  @Route.mount('/api/')
  Router get _api => Api().router;
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

class Api {
  // A handler can have more that one route :)
  @Route.get('/messages')
  @Route.get('/messages/')
  Future<Response> _messages(Request request) async => Response.ok('[]');

  // This nested catch-all, will only catch /api/.* when mounted above.
  // Notice that ordering if annotated handlers and mounts is significant.
  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound('null');

  // The generated function _$ApiRouter can be used to expose a [Router] for
  // this object.
  Router get router => _$ApiRouter(this);
}

void main(List<String> arguments) async {
  final service = Service();
  final server = await shelf_io.serve(service.handler, 'localhost', 8080);
  print('Server running on localhost:${server.port}');
}
