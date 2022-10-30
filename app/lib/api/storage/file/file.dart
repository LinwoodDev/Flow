import 'dart:typed_data';

import 'file_stub.dart'
    if (dart.library.html) 'file_html.dart'
    if (dart.library.io) 'file_io.dart' as file;

void saveFile(String name, Uint8List data) {
  file.saveFile(name, data);
}
