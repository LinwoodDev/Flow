import 'dart:io';

import 'package:generate_leap/flutter_build.dart';

import 'build_web_service_worker.dart';

Future<void> main(List<String> args) => runFlutterBuild(args, _FlowBuild.new);

class _FlowBuild extends FlutterBuild {
  _FlowBuild(super.options)
    : super(
        name: 'flow',
        root: File.fromUri(Platform.script).parent.parent,
        appDirectory: 'app',
      );

  @override
  String get defaultFlavor => 'production';

  @override
  List<String> get inputFiles => [
    'tools/pubspec.yaml',
    'tools/pubspec.lock',
    'tools/build_offline.dart',
    'tools/build_web_service_worker.dart',
    if (file('tools/pubspec_overrides.yaml').existsSync())
      'tools/pubspec_overrides.yaml',
    'api/pubspec.yaml',
    'api/pubspec.lock',
  ];

  @override
  Iterable<File> get downloadedInputs sync* {
    // SQLite's hook downloads prebuilt libraries into .dart_tool. Preserve only
    // those downloads so verify can restore them after each flutter clean.
    final sqlite = Directory(
      '${workingDirectory.path}/.dart_tool/hooks_runner/shared/sqlite3',
    );
    if (!sqlite.existsSync()) return;
    for (final entry in sqlite.listSync(recursive: true, followLinks: false)) {
      if (entry is! File) continue;
      final parts = entry.uri.pathSegments;
      if (parts.length >= 2 &&
          parts[parts.length - 2].startsWith('download-') &&
          const [
            'libsqlite3.so',
            'libsqlite3.dylib',
            'sqlite3.dll',
          ].contains(parts.last)) {
        yield entry;
      }
    }
  }

  @override
  Future<void> afterBuild(FileSystemEntity artifact) async {
    if (platform == 'web') await buildServiceWorker(artifact as Directory);
  }
}
