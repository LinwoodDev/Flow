import 'dart:io';

import 'package:flow/cubits/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

import 'window_buttons.dart';

class FlowTitleBar extends StatelessWidget {
  const FlowTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, FlowSettings>(
        buildWhen: (previous, current) =>
            previous.nativeTitleBar != current.nativeTitleBar,
        builder: (context, state) {
          if (!kIsWeb &&
                  !(Platform.isWindows ||
                      Platform.isLinux ||
                      Platform.isMacOS) ||
              state.nativeTitleBar) {
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
        });
  }
}
