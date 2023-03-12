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
  final ScrollController _scrollController = ScrollController(
    keepScrollOffset: true,
  );
  final GlobalKey _scrollViewKey = GlobalKey();
  int selected = -1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateSelected);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateSelected());
  }

  void _updateSelected() {
    final scrollOffset = _scrollController.offset;
    final scrollView =
        _scrollViewKey.currentContext!.findRenderObject() as RenderBox;
    final scrollViewTop = scrollView.localToGlobal(Offset.zero).dy;
    final index = _itemKeys.indexWhere((key) {
      final item = key.currentContext!.findRenderObject() as RenderBox;
      final itemTop = item.localToGlobal(Offset.zero).dy;
      return itemTop - scrollViewTop >= scrollOffset;
    });
    if (index != selected) {
      setState(() {
        selected = index;
      });
    }
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
        onChanged: (index) async {
          await Scrollable.ensureVisible(
            _itemKeys[index].currentContext!,
            duration: const Duration(milliseconds: 500),
          );
          setState(() {
            selected = index;
          });
        },
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            key: _scrollViewKey,
            child: SettingsContent(itemKeys: _itemKeys),
          ),
        ),
      ),
    );
  }
}
