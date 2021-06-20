import 'package:flow_server/home.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

void main(List<String> arguments) async {
  final service = Service();
  final server = await shelf_io.serve(
      service.handler, 'localhost', int.fromEnvironment('flow.port', defaultValue: 3000));
  server.autoCompress = true;
  print('Server running on localhost:${server.port}');
}
