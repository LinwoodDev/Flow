import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database.dart'
    if (dart.library.html) 'database_web.dart'
    if (dart.library.io) 'database_native.dart';
import 'setup.dart' if (dart.library.html) 'setup_web.dart';

import 'app_module.dart';
import 'app_widget.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  await Hive.initFlutter("linwood-flow");
  await Hive.openBox('appearance');
  await Hive.openBox<String>('servers');

  setup();

  getIt.registerSingleton(constructDb());

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
