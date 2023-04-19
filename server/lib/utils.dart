import 'package:dart_frog/dart_frog.dart';
import 'package:jaspr/server.dart' hide Middleware, Response;
import 'package:shared/models/error.dart';

/// Wraps jasprs [renderComponent] method to return a dart_frog response.
///
/// Renders the component wrapped in the default document and
/// uses the base path provided by the middleware.
Future<Response> renderJasprComponent(
  RequestContext context,
  Component child, [
  String basePath = '',
]) async {
  return Response(
    body: await renderComponent(
      Document.app(
        base: basePath,
        body: child,
      ),
    ),
    headers: {'Content-Type': 'text/html'},
  );
}

class BasePath {
  BasePath(this.path);
  final String path;
}

Response errorResponse(ErrorType errorType) {
  return Response.json(
    body: {
      'message': errorType.getDisplayString(),
      'type': errorType.name,
    },
    statusCode: errorType.httpCode,
  );
}
