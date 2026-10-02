import 'dart:io';

/// Applies source-level branding for platforms whose packagers cannot select
/// assets from Flutter's `--flavor` value themselves.
///
/// CI always starts from a clean checkout, so production builds keep the
/// checked-in stable assets while nightly builds call this script before the
/// native build starts.
void main(List<String> arguments) {
  if (arguments.length != 2) {
    stderr.writeln(
      'Usage: dart run tools/apply_branding.dart <flavor> <platform>',
    );
    exitCode = 64;
    return;
  }

  final flavor = arguments[0].toLowerCase();
  final platform = arguments[1].toLowerCase();
  if (!const {'nightly', 'development', 'dev'}.contains(flavor)) {
    stdout.writeln('Keeping production branding for $platform.');
    return;
  }

  final repositoryRoot = File.fromUri(Platform.script).parent.parent;
  final appRoot = Directory.fromUri(repositoryRoot.uri.resolve('app/'));
  switch (platform) {
    case 'windows':
      _replaceAll(_file(appRoot, 'pubspec.yaml'), {
        'display_name: Linwood Flow': 'display_name: Linwood Flow Nightly',
        'identity_name: LinwoodDevelopment.linwood-flow':
            'identity_name: LinwoodDevelopment.linwood-flow-nightly',
        'logo_path: images/logo.png': 'logo_path: images/nightly.png',
      });
    case 'linux':
      for (final size in const [128, 256]) {
        _copy(
          _file(appRoot, 'linux/branding/nightly-$size.png'),
          _file(
            appRoot,
            'linux/debian/usr/share/icons/hicolor/$size'
            'x$size/apps/dev.linwood.flow.png',
          ),
        );
      }
      _replaceAll(
        _file(
          appRoot,
          'linux/debian/usr/share/applications/dev.linwood.flow.desktop',
        ),
        {'Name=Linwood Flow': 'Name=Linwood Flow Nightly'},
      );
      _replaceAll(
        _file(
          appRoot,
          'linux/debian/usr/share/metainfo/dev.linwood.flow.appdata.xml',
        ),
        {'<name>Linwood Flow</name>': '<name>Linwood Flow Nightly</name>'},
      );
      _replaceAll(_file(appRoot, 'linux/rpm/linwood-flow.desktop'), {
        'Name=Linwood Flow': 'Name=Linwood Flow Nightly',
        'images/logo.svg': 'images/nightly.png',
      });
    case 'macos':
      final iconDirectory = _directory(
        appRoot,
        'macos/Runner/Assets.xcassets/AppIcon.appiconset',
      );
      for (final size in const [16, 32, 64, 128, 256, 512, 1024]) {
        _copy(
          _file(appRoot, 'web_nightly/ios/$size.png'),
          _file(iconDirectory, 'app_icon_$size.png'),
        );
      }
      _replaceAll(_file(appRoot, 'macos/Runner/Configs/AppInfo.xcconfig'), {
        'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.flow':
            'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.flow.nightly',
        'APP_DISPLAY_NAME = Linwood Flow':
            'APP_DISPLAY_NAME = Linwood Flow Nightly',
      });
    case 'ios':
      _replaceAll(_file(appRoot, 'ios/Runner/Info.plist'), {
        '<string>Flow</string>': '<string>Flow Nightly</string>',
        '<string>Linwood Flow</string>':
            '<string>Linwood Flow Nightly</string>',
      });
      _replaceAll(_file(appRoot, 'ios/Runner.xcodeproj/project.pbxproj'), {
        'ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;':
            'ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon-nightly;',
        'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.flow;':
            'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.flow.nightly;',
      });
    default:
      stderr.writeln('Unsupported branding platform: $platform');
      exitCode = 64;
      return;
  }
  stdout.writeln('Applied Flow Nightly branding for $platform.');
}

File _file(Directory root, String relativePath) =>
    File.fromUri(root.uri.resolve(relativePath));

Directory _directory(Directory root, String relativePath) =>
    Directory.fromUri(root.uri.resolve('$relativePath/'));

void _copy(File source, File destination) {
  if (!source.existsSync()) {
    throw StateError('Missing branding asset: ${source.path}');
  }
  source.copySync(destination.path);
}

void _replaceAll(File file, Map<String, String> replacements) {
  var content = file.readAsStringSync();
  for (final MapEntry(key: from, value: to) in replacements.entries) {
    content = content.replaceAll(to, from);
    if (!content.contains(from)) {
      throw StateError(
        'Expected branding value not found in ${file.path}: $from',
      );
    }
    content = content.replaceAll(from, to);
  }
  file.writeAsStringSync(content);
}
