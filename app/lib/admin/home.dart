import 'package:flow_app/admin/dev_doctor.dart';
import 'package:flow_app/admin/events.dart';
import 'package:flow_app/admin/general.dart';
import 'package:flow_app/admin/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var server = Hive.box<String>('servers')
        .getAt(int.tryParse(Modular.args?.queryParams['id'] ?? '0') ?? 0)!;

    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
                title: Text("Admin Dashboard"),
                bottom: TabBar(isScrollable: true, tabs: [
                  Tab(text: "General", icon: Icon(PhosphorIcons.wrenchLight)),
                  Tab(text: "Events", icon: Icon(PhosphorIcons.calendarBlankLight)),
                  Tab(text: "Places", icon: Icon(PhosphorIcons.mapPinLight)),
                  Tab(text: "Dev-Doctor", icon: Icon(PhosphorIcons.graduationCapLight))
                ])),
            body: TabBarView(children: [
              Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: GeneralAdminSettingsPage(server: server))),
              Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: EventsAdminSettingsPage(server: server))),
              Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: PlacesAdminSettingsPage(server: server))),
              Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: DevDoctorAdminSettingsPage(server: server)))
            ])));
  }
}
