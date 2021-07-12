import 'dart:convert';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'setup.dart' if (dart.library.html) 'setup_web.dart' if (dart.library.io) 'setup_io.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter("linwood-flow");
  await Hive.openBox('appearance');
  await Hive.openBox<int>('view');

  var biometricStorage =
      await BiometricStorage().getStorage('key', options: StorageFileInitOptions(authenticationRequired: false));
  var containsEncryptionKey = await biometricStorage.read() != null;
  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await biometricStorage.write(base64UrlEncode(key));
  }

  var encryptionKey = base64Url.decode((await biometricStorage.read())!);
  var cipher = HiveAesCipher(encryptionKey);
  await Hive.openBox('accounts', encryptionCipher: cipher);

  await setup();

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
