import 'package:dart_frog/dart_frog.dart';
import 'package:flow_server/pages/admin.dart';
import 'package:flow_server/utils.dart';

Future<Response> onRequest(RequestContext context) async {
  return renderJasprComponent(
    context,
    const HomePage(),
  );
}
