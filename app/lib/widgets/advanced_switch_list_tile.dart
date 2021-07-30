import 'package:flutter/material.dart';

class AdvancedSwitchListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final bool value;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final ValueChanged<bool>? onChanged;

  const AdvancedSwitchListTile(
      {Key? key,
      this.leading,
      this.title,
      this.subtitle,
      required this.value,
      this.onTap,
      this.onLongPress,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
          child: ListTile(
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        onLongPress: onLongPress,
      )),
      const SizedBox(height: 50, child: VerticalDivider()),
      Switch(value: value, onChanged: onChanged)
    ]);
  }
}
