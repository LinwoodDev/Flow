import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class FlowWindowButtons extends StatelessWidget {
  final bool divider;
  const FlowWindowButtons({super.key, this.divider = true});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb &&
        !(Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        if (divider) const VerticalDivider(),
        ...[
          IconButton(
            icon: const Icon(Icons.minimize_outlined),
            onPressed: () => windowManager.minimize(),
          ),
          IconButton(
            icon: const Icon(Icons.square_outlined),
            onPressed: () async => await windowManager.isMaximized()
                ? windowManager.restore()
                : windowManager.maximize(),
          ),
          IconButton(
            icon: const Icon(Icons.close_outlined),
            onPressed: () => windowManager.close(),
            color: Colors.red,
          ),
        ].map((e) => AspectRatio(aspectRatio: 1, child: e))
      ]),
    );
  }
}
