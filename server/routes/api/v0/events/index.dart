// ignore_for_file: avoid_dynamic_calls

import 'package:dart_frog/dart_frog.dart';
import 'package:shared/services/database.dart';

Future<Response> onRequest(RequestContext context) async {
  final service = await context.read<Future<DatabaseService>>();
  // ignore: strict_raw_type
  Map? body;
  try {
    body = await context.request.json() as Map;
  } catch (_) {}
  final offset = body?['offset'] as int? ?? 0;
  final limit = body?['limit'] as int? ?? 10;
  final events = await service.event.getEvents(offset: offset, limit: limit);
  return Response.json(body: events.map((e) => e.toJson()).toList());
}
