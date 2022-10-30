import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<void> saveFile(String name, Uint8List data) async {
  final path = await FilePicker.platform.saveFile(fileName: name);
  if (path == null) {
    return;
  }
  final file = File(path);
  await file.writeAsBytes(data);
}
