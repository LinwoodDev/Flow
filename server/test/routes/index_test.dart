import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../main.dart';
import '../../routes/api/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('GET /api', () {
    test('responds with a 200 and "Welcome to Dart Frog!".', () {
      final context = _MockRequestContext();
      final response = route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.body(),
        completion(
          equals(
            '{"application":"dev.linwood.flow","documentation":"https://docs.flow.linwood.dev","versions":$supportedVersions}}',
          ),
        ),
      );
    });
  });
}
