import 'package:flow_app/admin/dev_doctor.dart';
import 'package:flow_app/admin/events.dart';
import 'package:flow_app/admin/general.dart';
import 'package:flow_app/admin/places.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flow_app/widgets/server.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: FlowScaffold(
            bottom: TabBar(isScrollable: true, tabs: [
              Tab(text: "General", icon: Icon(PhosphorIcons.wrenchLight)),
              Tab(text: "Events", icon: Icon(PhosphorIcons.calendarBlankLight)),
              Tab(text: "Places", icon: Icon(PhosphorIcons.mapPinLight)),
              Tab(text: "Dev-Doctor", icon: Icon(PhosphorIcons.graduationCapLight))
            ]),
            pageTitle: "Admin Dashboard",
            page: RoutePages.admin,
            body: TabBarView(children: [
              Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: ServerView(
                          builder: (server) => GeneralAdminSettingsPage(server: server)))),
              Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: ServerView(
                          builder: (server) => EventsAdminSettingsPage(server: server)))),
              Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: ServerView(
                          builder: (server) => PlacesAdminSettingsPage(server: server)))),
              Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: ServerView(
                          builder: (server) => DevDoctorAdminSettingsPage(server: server))))
            ])));
  }
}
