import 'package:flow_app/services/api_service.dart';
import 'package:flow_app/services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/badge.dart';

class BadgePage extends StatefulWidget {
  final int? id;
  final bool isDesktop;

  const BadgePage({Key? key, this.id, this.isDesktop = false}) : super(key: key);

  @override
  _BadgePageState createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();
  late ApiService service;

  @override
  void initState() {
    super.initState();
    service = GetIt.I.get<LocalService>();
  }

  @override
  void didUpdateWidget(BadgePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    service = GetIt.I.get<LocalService>();
  }

  String? server = "";

  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? _buildView(null)
        : StreamBuilder<Badge?>(
            stream: service.onBadge(widget.id!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error ${snapshot.error}");
              if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              return _buildView(snapshot.data);
            });
  }

  Widget _buildView(Badge? badge) {
    var create = badge == null;
    _nameController.text = badge?.name ?? "";
    _descriptionController.text = badge?.description ?? "";
    return Scaffold(
        appBar: AppBar(title: Text(create ? "Create badge" : badge!.name)),
        floatingActionButton: FloatingActionButton(
            heroTag: "badge-check",
            child: Icon(PhosphorIcons.checkLight),
            onPressed: () {
              if (create) {
                service.createBadge(Badge(_nameController.text, description: _descriptionController.text));
                if (widget.isDesktop) {
                  _nameController.clear();
                  _descriptionController.clear();
                }
              } else
                service
                    .updateBadge(badge!.copyWith(name: _nameController.text, description: _descriptionController.text));
              if (Modular.to.canPop() && !widget.isDesktop) Modular.to.pop();
            }),
        body: Column(children: [
          if (widget.isDesktop)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                  onPressed: () => Modular.to.pushNamed(widget.id == null
                      ? "/badges/create"
                      : Uri(pathSegments: ["", "badges", "details"], queryParameters: {"id": widget.id.toString()})
                          .toString()),
                  icon: Icon(PhosphorIcons.arrowSquareOutLight),
                  label: Text("OPEN IN NEW WINDOW")),
            ),
          Expanded(
              child: SingleChildScrollView(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          constraints: BoxConstraints(maxWidth: 800),
                          child: Column(children: [
                            SizedBox(height: 50),
                            DropdownButtonFormField<String>(
                                value: server,
                                decoration: InputDecoration(labelText: "Server", border: OutlineInputBorder()),
                                onChanged: (value) => setState(() => server = value),
                                items: [
                                  ...Hive.box<String>('servers')
                                      .values
                                      .map((e) => DropdownMenuItem(child: Text(e), value: e)),
                                  DropdownMenuItem(child: Text("Local"), value: "")
                                ]),
                            SizedBox(height: 50),
                            TextField(
                                decoration: InputDecoration(labelText: "Name", icon: Icon(PhosphorIcons.calendarLight)),
                                controller: _nameController),
                            TextField(
                                decoration:
                                    InputDecoration(labelText: "Description", icon: Icon(PhosphorIcons.articleLight)),
                                maxLines: null,
                                controller: _descriptionController,
                                minLines: 3)
                          ])))))
        ]));
  }
}
