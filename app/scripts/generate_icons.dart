import 'dart:io';

import 'package:flutter_launcher_icons/config/config.dart';
import 'package:flutter_launcher_icons/logger.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:image/image.dart' as img;

Future<void> main() async {
  Directory.current = File.fromUri(Platform.script).parent.parent;
  final logger = FLILogger(false);
  final temporary = Directory.systemTemp.createTempSync('flow-launcher-icons-');
  try {
    for (final flavor in [null, 'production', 'nightly', 'development']) {
      final source = flavor == 'nightly' || flavor == 'development'
          ? 'images/nightly.png'
          : 'images/logo.png';
      final decoded = img.decodePng(File(source).readAsBytesSync())!;
      final image = File('${temporary.path}/${flavor ?? 'main'}.png');
      image.writeAsBytesSync(img.encodePng(decoded.convert(numChannels: 4)));
      // Flatten iOS artwork ourselves: the generator's alpha blending mixes
      // background channels incorrectly and cannot handle indexed PNGs.
      final opaque = img.Image(width: decoded.width, height: decoded.height);
      for (final pixel in decoded) {
        final alpha = pixel.aNormalized;
        int blend(num channel) => (channel * alpha + 47 * (1 - alpha)).round();
        opaque.setPixelRgb(
          pixel.x,
          pixel.y,
          blend(pixel.r),
          blend(pixel.g),
          blend(pixel.b),
        );
      }
      final iosImage = File('${temporary.path}/${flavor ?? 'main'}-ios.png');
      iosImage.writeAsBytesSync(img.encodePng(opaque));
      await createIconsFromConfig(
        Config(
          android: true,
          ios: true,
          imagePath: image.path,
          imagePathIOS: iosImage.path,
          minSdkAndroid: 24,
          adaptiveIconBackground: '#2F2F2F',
          adaptiveIconForeground: image.path,
          adaptiveIconMonochrome: image.path,
          removeAlphaIOS: true,
          backgroundColorIOS: '#2F2F2F',
        ),
        logger,
        '.',
        flavor,
      );
      final resources = Directory('android/app/src/${flavor ?? 'main'}/res');
      for (final file
          in resources.listSync(recursive: true).whereType<File>()) {
        final name = file.uri.pathSegments.last;
        if (name == 'ic_launcher.png' || name == 'ic_launcher.xml') {
          file.copySync(
            file.path.replaceFirst('ic_launcher.', 'ic_launcher_round.'),
          );
        }
      }
    }
  } finally {
    temporary.deleteSync(recursive: true);
  }

  // Remove the old Android Studio resources that conflict with generated icons.
  final resources = Directory('android/app/src/main/res');
  for (final file in resources.listSync(recursive: true).whereType<File>()) {
    if (file.path.endsWith('.webp') &&
        file.uri.pathSegments.last.startsWith('ic_launcher')) {
      file.deleteSync();
    }
  }
  for (final path in [
    'drawable/ic_launcher_foreground.xml',
    'drawable/ic_launcher_monochrome.xml',
    'values/ic_launcher_background.xml',
  ]) {
    final file = File('${resources.path}/$path');
    if (file.existsSync()) file.deleteSync();
  }
  File('images/logo.png')
      .copySync('android/app/src/main/ic_launcher-playstore.png');
}
