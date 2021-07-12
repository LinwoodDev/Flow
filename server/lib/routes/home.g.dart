// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$ServiceRouter(Service service) {
  final router = Router();
  router.add('GET', r'/', service._info);
  router.mount(r'/auth/', service._auth);
  router.mount(r'/profile/', service._profile);
  router.all(r'/<ignored|.*>', service._notFound);
  return router;
}
