import 'package:flow_app/widgets/advanced_switch_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final ScrollController _scrollController = ScrollController();
  bool events = false, places = true, devDoctor = false;

  @override
  Widget build(BuildContext context) {
    String? server;
    if(Modular.args?.queryParams.containsKey("id") ?? false) {
      server = Hive.box<String>('servers')
        .getAt(int.tryParse(Modular.args?.queryParams['id'] ?? '0') ?? 0)!;
    }

    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(title: Text("Admin Dashboard - " + (server ?? "Local"))),
            body: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(children: [
                      const SizedBox(height: 20),
                      const TextField(decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder())),
                      const SizedBox(height: 20),
                      const TextField(
                        decoration: InputDecoration(labelText: "Description", filled: true),
                        minLines: 3,
                        maxLines: null,
                      ),
                      const SizedBox(height: 50),
                      AdvancedSwitchListTile(
                          title: const Text("Events"),
                          onTap: () {},
                          leading: const Icon(PhosphorIcons.calendarBlankLight),
                          onChanged: (bool value) => setState(() => events = value),
                          value: events),
                      AdvancedSwitchListTile(
                          title: const Text("Teams"),
                          onTap: () {},
                          leading: const Icon(PhosphorIcons.calendarBlankLight),
                          onChanged: (bool value) => setState(() => events = value),
                          value: events),
                      AdvancedSwitchListTile(
                          title: const Text("Tasks"),
                          onTap: () {},
                          leading: const Icon(PhosphorIcons.calendarBlankLight),
                          onChanged: (bool value) => setState(() => events = value),
                          value: events),
                      AdvancedSwitchListTile(
                          title: const Text("Places"),
                          onTap: () {},
                          leading: const Icon(PhosphorIcons.mapPinLight),
                          onChanged: (bool value) => setState(() => places = value),
                          value: places),
                      AdvancedSwitchListTile(
                          title: const Text("Dev-Doctor"),
                          onTap: () {},
                          leading: const Icon(PhosphorIcons.graduationCapLight),
                          onChanged: (bool value) =>
                              setState(() => devDoctor = value),
                          value: devDoctor)
                    ]),
                  ),
                )
              )
            )));
  }
}
