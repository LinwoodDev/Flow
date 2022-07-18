import 'package:easy_localization/easy_localization.dart';
import 'package:flow/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppearanceSettingsPage extends StatelessWidget {
  const AppearanceSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        pageTitle: "Appearance",
        page: RoutePages.appearance,
        body: ValueListenableBuilder(
            valueListenable: Hive.box('appearance').listenable(),
            builder: (context, Box<dynamic> box, _) {
              var theme = ThemeMode.values[box.get('theme', defaultValue: 0)];
              return ListView(children: [
                ListTile(
                    title: const Text('settings.appearance.theme.title').tr(),
                    subtitle:
                        Text('settings.appearance.theme.${theme.name}').tr(),
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          ThemeMode? selectedRadio = theme;
                          return AlertDialog(
                              actions: [
                                TextButton(
                                    child: Text('cancel'.tr().toUpperCase()),
                                    onPressed: () => Modular.to.pop()),
                                TextButton(
                                    child: Text('save'.tr().toUpperCase()),
                                    onPressed: () async {
                                      box.put('theme', selectedRadio!.index);
                                      Modular.to.pop();
                                    })
                              ],
                              content: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List<Widget>.generate(
                                        ThemeMode.values.length, (int index) {
                                      return RadioListTile<ThemeMode>(
                                          value: ThemeMode.values[index],
                                          groupValue: selectedRadio,
                                          title: Text(
                                                  'settings.appearance.theme.${ThemeMode.values[index].name}')
                                              .tr(),
                                          onChanged: (value) {
                                            setState(
                                                () => selectedRadio = value);
                                          });
                                    }));
                              }));
                        }))
              ]);
            }));
  }
}
