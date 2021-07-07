import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'profile.g.dart';

class ProfileService {
  @Route.get("/")
  Future<Response> _info(Request request) async {
    return Response.ok("");
  }

  Router get router => _$ProfileServiceRouter(this);
}
