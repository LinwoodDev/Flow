import 'package:flow_app/admin/dev_doctor.dart';
import 'package:flow_app/admin/events.dart';
import 'package:flow_app/admin/general.dart';
import 'package:flow_app/admin/places.dart';
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
    var server = Hive.box<String>('servers')
        .getAt(int.tryParse(Modular.args?.queryParams['id'] ?? '0') ?? 0)!;

    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(title: const Text("Admin Dashboard")),
            body: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(children: [
                  ExpansionTile(
                      initiallyExpanded: true,
                      title: const Text("General"),
                      leading: const Icon(PhosphorIcons.wrenchLight),
                      children: [GeneralAdminSettingsPage(server: server)]),
                  ExpansionTile(
                      initiallyExpanded: true,
                      title: const Text("Events"),
                      children: [EventsAdminSettingsPage(server: server)],
                      leading: const Icon(PhosphorIcons.calendarBlankLight),
                      trailing: Switch(
                          onChanged: (bool value) => setState(() => events = value),
                          value: events)),
                  ExpansionTile(
                      initiallyExpanded: true,
                      title: const Text("Places"),
                      children: [PlacesAdminSettingsPage(server: server)],
                      leading: const Icon(PhosphorIcons.mapPinLight),
                      trailing: Switch(
                          onChanged: (bool value) => setState(() => places = value),
                          value: places)),
                  ExpansionTile(
                      initiallyExpanded: true,
                      title: const Text("Dev-Doctor"),
                      children: [DevDoctorAdminSettingsPage(server: server)],
                      leading: const Icon(PhosphorIcons.graduationCapLight),
                      trailing: Switch(
                          onChanged: (bool value) => setState(() => devDoctor = value),
                          value: devDoctor))
                ]),
              ),
            )));
  }
}
