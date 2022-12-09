import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class FlowTitleBar extends StatelessWidget {
  const FlowTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb &&
        !(Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      return Container();
    }
    return Material(
      child: SizedBox(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: DragToMoveArea(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Linwood Flow",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            ...[
              IconButton(
                icon: const Icon(Icons.minimize_outlined),
                onPressed: () => windowManager.minimize(),
              ),
              IconButton(
                icon: const Icon(Icons.square_outlined),
                onPressed: () => windowManager.maximize(),
              ),
              IconButton(
                icon: const Icon(Icons.close_outlined),
                onPressed: () => windowManager.close(),
              ),
            ].map((e) => AspectRatio(aspectRatio: 1, child: e))
          ],
        ),
      ),
    );
  }
}
