// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$ServiceRouter(Service service) {
  final router = Router();
  router.add('GET', r'/', service._info);
  router.mount(r'/session/', service._session);
  router.all(r'/<ignored|.*>', service._notFound);
  return router;
}
