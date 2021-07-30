import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shared/config/main.dart';

const tabEncoder = JsonEncoder.withIndent("\t");

class ConfigService {
  final File configFile;
  MainConfig mainConfig = MainConfig();

  ConfigService(this.configFile);

  Future<void> reload() async {
    try {
      var data = await configFile.readAsString();
      mainConfig = MainConfig.fromJson(json.decode(data));
    } on FormatException {
      mainConfig = MainConfig();
    }
  }

  Future<void> save() =>
      configFile.writeAsString(tabEncoder.convert(mainConfig.toJson()));
}
