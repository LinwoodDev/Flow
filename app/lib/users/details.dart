import 'package:flow_app/services/api_service.dart';
import 'package:flow_app/services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/user.dart';

typedef OnUserChanged = void Function(int? id);

class UserPage extends StatefulWidget {
  final int? id;
  final bool isDesktop;

  const UserPage({Key? key, this.id, this.isDesktop = false}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _displayNameController = TextEditingController();
  late final TextEditingController _bioController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late ApiService service;

  @override
  void initState() {
    super.initState();
    service = GetIt.I.get<LocalService>();
  }

  @override
  void didUpdateWidget(UserPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    service = GetIt.I.get<LocalService>();
  }

  String? server = "";

  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? _buildView(null)
        : StreamBuilder<User?>(
            stream: service.onUser(widget.id!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return _buildView(snapshot.data);
            });
  }

  Widget _buildView(User? user) {
    var create = user == null;
    _nameController.text = user?.name ?? "";
    _bioController.text = user?.bio ?? "";
    _displayNameController.text = user?.displayName ?? "";
    _emailController.text = user?.email ?? "";
    var userState = user?.state ?? UserState.fake;
    return Scaffold(
        appBar: AppBar(title: Text(create ? "Create user" : user!.name), actions: [
          if (widget.isDesktop)
            IconButton(
                onPressed: () => Modular.to.pushNamed(widget.id == null
                    ? "/users/create"
                    : Uri(
                        pathSegments: ["", "users", "details"],
                        queryParameters: {"id": widget.id.toString()}).toString()),
                icon: const Icon(PhosphorIcons.arrowSquareOutLight))
        ]),
        floatingActionButton: FloatingActionButton(
            heroTag: "user-check",
            child: const Icon(PhosphorIcons.checkLight),
            onPressed: () {
              if (create) {
                service.createUser(User(_nameController.text,
                    bio: _bioController.text,
                    displayName: _displayNameController.text,
                    email: _emailController.text));
                if (widget.isDesktop) {
                  _nameController.clear();
                  _bioController.clear();
                  _displayNameController.clear();
                  _emailController.clear();
                }
              } else {
                service.updateUser(user!.copyWith(
                    name: _nameController.text,
                    bio: _bioController.text,
                    displayName: _displayNameController.text,
                    email: _emailController.text));
              }
              if (Modular.to.canPop() && !widget.isDesktop) Modular.to.pop();
            }),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          padding: const EdgeInsets.all(8.0),
                          constraints: const BoxConstraints(maxWidth: 800),
                          child: Column(children: [
                            const SizedBox(height: 50),
                            DropdownButtonFormField<String>(
                                value: server,
                                decoration: const InputDecoration(
                                    labelText: "Server", border: OutlineInputBorder()),
                                onChanged: (value) => setState(() => server = value),
                                items: [
                                  ...Hive.box<String>('servers')
                                      .values
                                      .map((e) => DropdownMenuItem(child: Text(e), value: e)),
                                  const DropdownMenuItem(child: Text("Local"), value: "")
                                ]),
                            const SizedBox(height: 50),
                            TextField(
                                decoration: const InputDecoration(
                                    labelText: "Name",
                                    icon: Icon(PhosphorIcons.userLight),
                                    filled: true),
                                controller: _nameController),
                            const SizedBox(height: 20),
                            TextField(
                                decoration: const InputDecoration(
                                    labelText: "Display name",
                                    icon: Icon(PhosphorIcons.identificationCardLight),
                                    filled: true),
                                controller: _displayNameController),
                            const SizedBox(height: 20),
                            TextField(
                                decoration: const InputDecoration(
                                    labelText: "Email",
                                    icon: Icon(PhosphorIcons.envelopeLight),
                                    filled: true),
                                controller: _emailController),
                            const SizedBox(height: 20),
                            TextField(
                                decoration: const InputDecoration(
                                    labelText: "Biography",
                                    icon: Icon(PhosphorIcons.articleLight),
                                    border: OutlineInputBorder()),
                                maxLines: null,
                                controller: _bioController,
                                minLines: 3),
                            if (user != null) ...[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                              PopupMenuButton<UserState>(
                                  initialValue: userState,
                                  onSelected: (value) =>
                                      service.updateUser(user.copyWith(state: value)),
                                  itemBuilder: (context) => UserState.values
                                      .map(
                                          (e) => PopupMenuItem(child: Text(e.toString()), value: e))
                                      .toList(),
                                  child: ListTile(
                                      title: const Text("User state"),
                                      subtitle: Text(userState.toString()),
                                      leading: const Icon(PhosphorIcons.presentationLight))),
                              ListTile(
                                  leading: const Icon(PhosphorIcons.lockLight),
                                  title: const Text("Change password"),
                                  onTap: () {})
                            ]
                          ])))))
        ]));
  }
}
