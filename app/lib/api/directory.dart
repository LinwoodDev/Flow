import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

Future<String> getFlowDirectory() async {
  if (dataPath != null) {
    return dataPath!;
  }
  var prefs = await SharedPreferences.getInstance();
  String? path;
  if (prefs.containsKey('path')) {
    path = prefs.getString('path');
  }
  if (path == '') {
    path = null;
  }
  if (path != null) {
    return path;
  }
  if (Platform.isAndroid) path = (await getExternalStorageDirectory())?.path;
  path ??= (await getApplicationDocumentsDirectory()).path;
  path += '/Linwood/Flow';
  return path;
}
