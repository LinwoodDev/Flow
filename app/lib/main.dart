import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import 'app_module.dart';
import 'app_widget.dart';

Future<void> main() async {
  await Hive.openBox('appearance');
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
