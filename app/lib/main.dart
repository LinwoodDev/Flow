import 'package:flow_app/services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'setup.dart' if (dart.library.html) 'setup_web.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter("linwood-flow");
  await Hive.openBox('appearance');
  await Hive.openBox<int>('view');
  GetIt.I.registerSingleton<LocalService>(await LocalService.create());
  var serversBox = await Hive.openBox<String>('servers');
  if (serversBox.isEmpty) await serversBox.add("https://example.com");

  setup();

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
