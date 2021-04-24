// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$SessionServiceRouter(SessionService service) {
  final router = Router();
  router.add('POST', r'/register', service._register);
  router.add('POST', r'/login', service._login);
  return router;
}
