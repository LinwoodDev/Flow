// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AuthServiceRouter(AuthService service) {
  final router = Router();
  router.add('POST', r'/register', service._register);
  router.add('POST', r'/login', service._login);
  return router;
}
