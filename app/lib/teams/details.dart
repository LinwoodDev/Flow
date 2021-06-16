import 'package:flow_app/services/local_service.dart';
import 'package:flow_app/widgets/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/team.dart';

class TeamPage extends StatefulWidget {
  final Team? team;
  final int? id;
  final bool isDesktop;

  const TeamPage({Key? key, this.team, this.id, this.isDesktop = false}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  String? server = "";
  @override
  Widget build(BuildContext context) {
    var create = widget.team == null;
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          if (widget.isDesktop && widget.id != null) ...[
            ElevatedButton.icon(
                onPressed: () => Modular.to.pushNamed(Uri(
                    pathSegments: ["", "events", "details"],
                    queryParameters: {"id": widget.id.toString()}).toString()),
                icon: Icon(PhosphorIcons.arrowSquareOutLight),
                label: Text("OPEN IN NEW WINDOW")),
            SizedBox(height: 10)
          ],
          Expanded(
            child: Scaffold(
              appBar: widget.isDesktop
                  ? PreferredSize(
                      preferredSize: Size.fromHeight(70),
                      child: AppBar(flexibleSpace: _buildTabBar()))
                  : AppBar(
                      title: Text(create ? "Create team" : widget.team!.name),
                      bottom: _buildTabBar()),
              floatingActionButton: FloatingActionButton(
                  heroTag: "team-check",
                  child: Icon(PhosphorIcons.checkLight),
                  onPressed: () {
                    if (create) {
                      GetIt.I.get<LocalService>().createTeam(
                          Team(_nameController.text, description: _descriptionController.text));
                    }
                  }),
              body: Column(
                children: [
                  Expanded(
                    child: TabBarView(children: [
                      SingleChildScrollView(
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  constraints: BoxConstraints(maxWidth: 800),
                                  child: Column(children: [
                                    SizedBox(height: 50),
                                    DropdownButtonFormField<String>(
                                        value: server,
                                        decoration: InputDecoration(
                                            labelText: "Server", border: OutlineInputBorder()),
                                        onChanged: (value) => setState(() => server = value),
                                        items: [
                                          ...Hive.box<String>('servers').values.map(
                                              (e) => DropdownMenuItem(child: Text(e), value: e)),
                                          DropdownMenuItem(child: Text("Local"), value: "")
                                        ]),
                                    SizedBox(height: 50),
                                    TextField(
                                        decoration: InputDecoration(labelText: "Name"),
                                        controller: _nameController),
                                    TextField(
                                        decoration: InputDecoration(labelText: "Description"),
                                        maxLines: null,
                                        controller: _descriptionController,
                                        minLines: 3)
                                  ])))),
                      Align(
                          alignment: Alignment.topCenter,
                          child: ColorPicker(onClick: (color) => print(color)))
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildTabBar() => TabBar(tabs: [
        Tab(text: "General", icon: Icon(PhosphorIcons.wrenchLight)),
        Tab(text: "Color", icon: Icon(PhosphorIcons.eyedropperLight))
      ]);
}
