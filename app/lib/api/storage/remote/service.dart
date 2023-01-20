import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared/services/source.dart';

abstract class RemoteService extends SourceService {
  final String baseUrl;
  String get version;

  RemoteService(this.baseUrl);

  Uri _buildUri(String path, {Map<String, String>? queryParameters}) {
    var uri = Uri.parse('$baseUrl/v$apiVersion/$path');
    if (queryParameters != null) {
      uri = uri.replace(
          queryParameters: Map.from(uri.queryParameters)
            ..addAll(queryParameters));
    }
    return uri;
  }

  // ignore: unused_element
  Future<dynamic> _get(String path, dynamic body,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    var uri = _buildUri(path, queryParameters: queryParameters);
    var response = await http.get(uri, headers: headers);
    return _handleResponse(response);
  }

  // ignore: unused_element
  Future<dynamic> _post(String path, dynamic body,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    var uri = _buildUri(path, queryParameters: queryParameters);
    final bodyString = body != null ? jsonEncode(body) : null;
    var response = await http.post(uri, body: bodyString, headers: headers);
    return _handleResponse(response);
  }

  // ignore: unused_element
  Future<dynamic> _put(String path, dynamic body,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    var uri = _buildUri(path, queryParameters: queryParameters);
    final bodyString = body != null ? jsonEncode(body) : null;
    var response = await http.put(uri, body: bodyString, headers: headers);
    return _handleResponse(response);
  }

  // ignore: unused_element
  Future<dynamic> _delete(String path, dynamic body,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    var uri = _buildUri(path, queryParameters: queryParameters);
    final bodyString = body != null ? jsonEncode(body) : null;
    var response = await http.delete(uri, body: bodyString, headers: headers);
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
