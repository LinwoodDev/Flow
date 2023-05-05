import 'package:flow/cubits/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';

class FlowWindowButtons extends StatefulWidget {
  final bool divider;

  const FlowWindowButtons({super.key, this.divider = true});

  @override
  State<FlowWindowButtons> createState() => _FlowWindowButtonsState();
}

class _FlowWindowButtonsState extends State<FlowWindowButtons>
    with WindowListener {
  bool maximized = false, alwaysOnTop = false, fullScreen = false;

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
    updateStates();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  Future<void> updateStates() async {
    final nextMaximized = await windowManager.isMaximized();
    final nextAlwaysOnTop = await windowManager.isAlwaysOnTop();
    final nextFullScreen = await windowManager.isFullScreen();
    if (mounted) {
      setState(() {
        maximized = nextMaximized;
        alwaysOnTop = nextAlwaysOnTop;
        fullScreen = nextFullScreen;
      });
    }
  }

  @override
  void onWindowUnmaximize() {
    setState(() => maximized = false);
  }

  @override
  void onWindowMaximize() {
    setState(() => maximized = true);
  }

  @override
  void onWindowEnterFullScreen() {
    setState(() => fullScreen = true);
  }

  @override
  void onWindowLeaveFullScreen() {
    setState(() => fullScreen = false);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, FlowSettings>(
        buildWhen: (previous, current) =>
            previous.nativeTitleBar != current.nativeTitleBar,
        builder: (context, settings) {
          if (!kIsWeb && !settings.nativeTitleBar) {
            return LayoutBuilder(
              builder: (context, constraints) => Row(
                children: [
                  if (widget.divider) const VerticalDivider(),
                  Card(
                    elevation: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Builder(builder: (context) {
                            return Row(
                              children: [
                                if (!fullScreen) ...[
                                  IconButton(
                                    icon: const Icon(Icons.minimize_outlined),
                                    tooltip:
                                        AppLocalizations.of(context).minimize,
                                    splashRadius: 20,
                                    onPressed: () => windowManager.minimize(),
                                  ),
                                  IconButton(
                                    tooltip: maximized
                                        ? AppLocalizations.of(context).restore
                                        : AppLocalizations.of(context).maximize,
                                    icon: Icon(
                                      Icons.square_outlined,
                                      size: maximized ? 14 : 20,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    onPressed: () async =>
                                        await windowManager.isMaximized()
                                            ? windowManager.unmaximize()
                                            : windowManager.maximize(),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close_outlined),
                                    tooltip: AppLocalizations.of(context).close,
                                    color: Colors.red,
                                    splashRadius: 20,
                                    onPressed: () => windowManager.close(),
                                  )
                                ]
                              ]
                                  .map((e) =>
                                      AspectRatio(aspectRatio: 1, child: e))
                                  .toList(),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }
}
