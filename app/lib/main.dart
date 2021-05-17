import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_module.dart';
import 'app_widget.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('appearance');
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
