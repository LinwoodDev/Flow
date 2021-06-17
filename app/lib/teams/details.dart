import 'package:flow_app/services/api_service.dart';
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
  late ApiService service;
  Color color = Colors.white;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    service = GetIt.I.get<LocalService>();
  }

  @override
  void didUpdateWidget(TeamPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    service = GetIt.I.get<LocalService>();
  }

  String? server = "";
  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? _buildView(null)
        : StreamBuilder<Team?>(
            stream: service.onTeam(widget.id!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error ${snapshot.error}");
              if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              return _buildView(snapshot.data);
            });
  }

  Widget _buildView(Team? team) {
    var create = team == null;
    _nameController.text = team != null ? team.name : "";
    _descriptionController.text = team != null ? team.description : "";
    color = team?.color != null ? Color(team!.color!) : Colors.white;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar:
                AppBar(title: Text(create ? "Create team" : team!.name), bottom: _buildTabBar()),
            floatingActionButton: FloatingActionButton(
                heroTag: "team-check",
                child: Icon(PhosphorIcons.checkLight),
                onPressed: () {
                  if (create) {
                    service.createTeam(Team(_nameController.text,
                        description: _descriptionController.text, color: color.value));
                    if (widget.isDesktop) {
                      _nameController.text = "";
                      _descriptionController.text = "";
                      setState(() => color = Colors.white);
                    }
                  } else
                    service.updateTeam(team!.copyWith(
                        name: _nameController.text,
                        color: color.value,
                        description: _descriptionController.text));
                  if (Modular.to.canPop() && !widget.isDesktop) Modular.to.pop();
                }),
            body: Column(children: [
              if (widget.isDesktop)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                      onPressed: () => Modular.to.pushNamed(widget.id == null
                          ? "/teams/create"
                          : Uri(
                              pathSegments: ["", "teams", "details"],
                              queryParameters: {"id": widget.id.toString()}).toString()),
                      icon: Icon(PhosphorIcons.arrowSquareOutLight),
                      label: Text("OPEN IN NEW WINDOW")),
                ),
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
                                    ...Hive.box<String>('servers')
                                        .values
                                        .map((e) => DropdownMenuItem(child: Text(e), value: e)),
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
                    child: ColorPicker(initialColor: color, onClick: (value) => color = value))
              ]))
            ])));
  }

  PreferredSizeWidget _buildTabBar() => TabBar(tabs: [
        Tab(text: "General", icon: Icon(PhosphorIcons.wrenchLight)),
        Tab(text: "Color", icon: Icon(PhosphorIcons.eyedropperLight))
      ]);
}
