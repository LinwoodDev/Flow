import 'package:enum_to_string/enum_to_string.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppearanceSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Appearance")),
        drawer: FlowDrawer(page: RoutePages.appearance),
        body: ValueListenableBuilder(
            valueListenable: Hive.box('appearance').listenable(),
            builder: (context, Box<dynamic> box, _) {
              var theme = ThemeMode.values[box.get('theme', defaultValue: 0)];
              return ListView(children: [
                ListTile(
                    title: Text('settings.appearance.theme.title').tr(),
                    subtitle:
                        Text('settings.appearance.theme.' + EnumToString.convertToString(theme))
                            .tr(),
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          ThemeMode? selectedRadio = theme;
                          return AlertDialog(
                              actions: [
                                TextButton(
                                    child: Text('cancel'.tr().toUpperCase()),
                                    onPressed: () => Navigator.of(context).pop()),
                                TextButton(
                                    child: Text('save'.tr().toUpperCase()),
                                    onPressed: () async {
                                      box.put('theme', selectedRadio!.index);
                                      Navigator.pop(context);
                                    })
                              ],
                              content: StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children:
                                        List<Widget>.generate(ThemeMode.values.length, (int index) {
                                      return RadioListTile<ThemeMode>(
                                          value: ThemeMode.values[index],
                                          groupValue: selectedRadio,
                                          title: Text('settings.appearance.theme.' +
                                                  EnumToString.convertToString(
                                                      ThemeMode.values[index]))
                                              .tr(),
                                          onChanged: (value) {
                                            setState(() => selectedRadio = value);
                                          });
                                    }));
                              }));
                        }))
              ]);
            }));
  }
}
