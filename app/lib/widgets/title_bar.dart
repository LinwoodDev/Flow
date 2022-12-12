import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'window_buttons.dart';

class FlowTitleBar extends StatelessWidget {
  const FlowTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb &&
        !(Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      return Container();
    }
    return Material(
      elevation: 2,
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
            const FlowWindowButtons()
          ],
        ),
      ),
    );
  }
}
