import 'package:flow/pages/settings/content.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<GlobalKey> _itemKeys = List.generate(4, (index) => GlobalKey());
  final ScrollController _scrollController = ScrollController();
  int selected = -1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateSelected);
  }

  void _updateSelected() {
    final scrollOffset = _scrollController.offset;
    final index = _itemKeys.lastIndexWhere((key) {
      final context = key.currentContext;
      if (context == null) return false;
      final box = context.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero);
      return offset.dy <= scrollOffset;
    });
    if (index != selected) setState(() => selected = index);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).settings,
      endDrawer: SettingsDrawer(
        itemKeys: _itemKeys,
        selected: selected,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SettingsContent(itemKeys: _itemKeys),
          ),
        ),
      ),
    );
  }
}
