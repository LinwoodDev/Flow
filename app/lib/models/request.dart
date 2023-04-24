import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

part 'request.freezed.dart';
part 'request.g.dart';

@freezed
class APIRequest with _$APIRequest {
  const APIRequest._();

  const factory APIRequest({
    @Default(-1) int id,
    required String method,
    required String authority,
    required String path,
    @Default({}) Map<String, String> headers,
    @Default('') String body,
  }) = _APIRequest;

  factory APIRequest.fromJson(Map<String, dynamic> json) =>
      _$APIRequestFromJson(json);

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
