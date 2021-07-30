// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:get_it/get_it.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:shared/services/local/service.dart';

Future<void> setup() async {
  var factory = databaseFactoryWeb;

  // Open the database
  var db = await factory.openDatabase('linwood_flow');
  GetIt.I.registerSingleton(LocalService(db));
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
}
