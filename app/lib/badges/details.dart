import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/account.dart';
import 'package:shared/models/badge.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/services/local_service.dart';

class BadgePage extends StatefulWidget {
  final int? id;
  final bool isDesktop;

  const BadgePage({Key? key, this.id, this.isDesktop = false})
      : super(key: key);

  @override
  _BadgePageState createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
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

  Account? account;

  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? _buildView(null)
        : StreamBuilder<Badge?>(
            stream: service.onBadge(widget.id!),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
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
            child: const Icon(PhosphorIcons.checkLight),
            onPressed: () {
              if (create) {
                service.createBadge(Badge(_nameController.text,
                    description: _descriptionController.text));
                if (widget.isDesktop) {
                  _nameController.clear();
                  _descriptionController.clear();
                }
              } else {
                service.updateBadge(badge!.copyWith(
                    name: _nameController.text,
                    description: _descriptionController.text));
              }
              if (Modular.to.canPop() && !widget.isDesktop) Modular.to.pop();
            }),
        body: Column(children: [
          if (widget.isDesktop)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                  onPressed: () => Modular.to.pushNamed(widget.id == null
                      ? "/badges/create"
                      : Uri(
                              pathSegments: ["", "badges", "details"],
                              queryParameters: {"id": widget.id.toString()})
                          .toString()),
                  icon: const Icon(PhosphorIcons.arrowSquareOutLight),
                  label: const Text("OPEN IN NEW WINDOW")),
            ),
          Expanded(
              child: SingleChildScrollView(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
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
                                          ...Hive.box('accounts').values.map(
                                              (e) => DropdownMenuItem(
                                                  child: Text(e), value: e)),
                                          ...users
                                              .map((e) =>
                                                  Account.fromLocalUser(e))
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
                                    icon: Icon(PhosphorIcons.calendarLight)),
                                controller: _nameController),
                            TextField(
                                decoration: const InputDecoration(
                                    labelText: "Description",
                                    icon: Icon(PhosphorIcons.articleLight)),
                                maxLines: null,
                                controller: _descriptionController,
                                minLines: 3)
                          ])))))
        ]));
  }
}
