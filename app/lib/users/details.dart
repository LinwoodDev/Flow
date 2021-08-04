import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/models/account.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/services/local/service.dart';

typedef OnUserChanged = void Function(int? id);

class UserPage extends StatefulWidget {
  final int? id;
  final bool isDesktop;
  final Account? account;

  const UserPage({Key? key, this.id, this.isDesktop = false, this.account})
      : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _displayNameController =
      TextEditingController();
  late final TextEditingController _bioController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late UsersApiService service;

  @override
  void initState() {
    super.initState();
    service = GetIt.I.get<LocalService>().users;
    account = widget.account;
  }

  @override
  void didUpdateWidget(UserPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    service = GetIt.I.get<LocalService>().users;
  }

  Account? account;

  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? _buildView(null)
        : StreamBuilder<User?>(
            stream: service.onUser(widget.id!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
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
        appBar:
            AppBar(title: Text(create ? "Create user" : user!.name), actions: [
          if (widget.isDesktop)
            IconButton(
                onPressed: () => Modular.to.push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) =>
                        UserPage(account: account, id: widget.id))),
                icon: const Icon(PhosphorIcons.arrowSquareOutLight))
        ]),
        floatingActionButton: FloatingActionButton(
            heroTag: "user-check",
            child: const Icon(PhosphorIcons.checkLight),
            onPressed: () async {
              if (create) {
                await service
                    .createUser(User(_nameController.text,
                        bio: _bioController.text,
                        displayName: _displayNameController.text,
                        email: _emailController.text,
                        password: _passwordController.text))
                    .then((value) {
                  if (widget.isDesktop) {
                    _nameController.clear();
                    _bioController.clear();
                    _displayNameController.clear();
                    _emailController.clear();
                    _passwordController.clear();
                  }
                }).catchError((e, stackTrace) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Error while creating an user"),
                            content: Text((e as InputException)
                                .errors
                                .map((e) => e.toString())
                                .join("\n")),
                            actions: [
                              TextButton(
                                  child: const Text("CLOSE"),
                                  onPressed: () => Modular.to.pop())
                            ],
                          ));
                }, test: (e) => e is InputException);
              } else {
                var updatedUser = user!.copyWith(
                    name: _nameController.text,
                    bio: _bioController.text,
                    displayName: _displayNameController.text,
                    email: _emailController.text);
                service.updateUser(updatedUser).then((value) {
                  if (account == Account.fromLocalUser(user)) {
                    setState(
                        () => account = Account.fromLocalUser(updatedUser));
                  }
                }).catchError((e, stackTrace) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Error while updating the user"),
                            content: Text((e as InputException)
                                .errors
                                .map((e) => e.toString())
                                .join("\n")),
                            actions: [
                              TextButton(
                                  child: const Text("CLOSE"),
                                  onPressed: () => Modular.to.pop())
                            ],
                          ));
                }, test: (e) => e is InputException);
              }
              if (Modular.to.canPop() && !widget.isDesktop) Modular.to.pop();
            }),
        body: SingleChildScrollView(
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    padding: const EdgeInsets.all(16.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(children: [
                      const SizedBox(height: 50),
                      Builder(builder: (context) {
                        return StreamBuilder<List<User>>(
                            stream: service.onUsers(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              }
                              if (!snapshot.hasData ||
                                  snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              var users = snapshot.data!;
                              return DropdownButtonFormField<Account>(
                                  value: account,
                                  decoration: const InputDecoration(
                                      labelText: "Account",
                                      border: OutlineInputBorder()),
                                  onChanged: (value) => account = value,
                                  items: [
                                    ...Hive.box('accounts').values.map((e) =>
                                        DropdownMenuItem(
                                            child: Text(e), value: e)),
                                    ...users
                                        .map((e) => Account.fromLocalUser(e))
                                        .map((e) => DropdownMenuItem(
                                            child: Text(e.toString()),
                                            value: e))
                                  ]);
                            });
                      }),
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
                      if (user == null) ...[
                        TextField(
                            decoration: const InputDecoration(
                                labelText: "Password",
                                icon: Icon(PhosphorIcons.lockLight),
                                filled: true),
                            controller: _passwordController),
                        const SizedBox(height: 20),
                      ],
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
                                .map((e) => PopupMenuItem(
                                    child: Text(e.toString()), value: e))
                                .toList(),
                            child: ListTile(
                                title: const Text("User state"),
                                subtitle: Text(userState.toString()),
                                leading: const Icon(
                                    PhosphorIcons.presentationLight))),
                        ListTile(
                            leading: const Icon(PhosphorIcons.lockLight),
                            title: const Text("Change password"),
                            onTap: () {})
                      ]
                    ])))));
  }
}
