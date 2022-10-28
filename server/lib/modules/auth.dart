import 'package:server/server.dart';
import 'package:shelf_router/shelf_router.dart';

class AuthModule extends Module {
  AuthModule(super.server);

  @override
  void registerRoutes(Router router) {
    // TODO: implement registerRoutes
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void stop() {
    // TODO: implement stop
  }
  @override
  Future<void> migrate(int version) {
    printInfo("Migrating AuthModule to version $version");
    return Future.delayed(Duration(seconds: 1));
  }
}
