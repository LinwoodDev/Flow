import 'package:dart_mappable/dart_mappable.dart';
import 'package:http/http.dart';

part 'request.mapper.dart';

@MappableClass()
class APIRequest with APIRequestMappable {
  final int id;
  final String method, authority, path;
  final Map<String, String> headers;
  final String body;

  const APIRequest({
    this.id = -1,
    required this.method,
    required this.authority,
    required this.path,
    this.headers = const {},
    this.body = '',
  });

  Future<Response> send([Client? client]) async {
    final currentClient = client ?? Client();
    var uri = authority;
    if (!uri.endsWith('/')) uri += '/';
    var currentPath = path.startsWith('/') ? path.substring(1) : path;
    if (currentPath.isNotEmpty) uri += currentPath;
    final request = Request(method, Uri.parse(uri));
    request.headers.addAll(headers);
    request.body = body;
    try {
      final stream = await currentClient.send(request);
      return Response.fromStream(stream);
    } catch (_) {
      rethrow;
    } finally {
      if (client == null) currentClient.close();
    }
  }
}
