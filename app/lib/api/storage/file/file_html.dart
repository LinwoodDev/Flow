// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:typed_data';

Future<void> saveFile(String name, Uint8List data) async {
  final a = document.createElement('a') as AnchorElement;
  // Create data URL
  final blob = Blob([data], 'text/plain');
  final url = Url.createObjectUrl(blob);
  a.href = url;
  a.download = name;
  a.click();
}
