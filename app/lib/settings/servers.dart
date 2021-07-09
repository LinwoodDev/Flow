import 'dart:convert';

import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccountsSettingsPage extends StatefulWidget {
  const AccountsSettingsPage({Key? key}) : super(key: key);
  @override
  _AccountsSettingsPageState createState() => _AccountsSettingsPageState();
}

class _AccountsSettingsPageState extends State<AccountsSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.servers,
        pageTitle: "Servers",
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Modular.to.pushNamed("/connect"),
            label: const Text("Add server"),
            icon: const Icon(PhosphorIcons.plusLight)),
        body: ValueListenableBuilder<Box<String>>(
            valueListenable: Hive.box<String>('servers').listenable(),
            builder: (context, box, _) => FutureBuilder<List<Map<String, dynamic>?>>(
                future: Future.wait(box.values.map((e) => http.get(Uri.parse(e)).then<Map<String, dynamic>?>((value) {
                      try {
                        return json.decode(value.body);
                      } catch (e) {
                        print("Decode Error: $e");
                        return null;
                      }
                    }).onError((e, stackTrace) {
                      print("Error $e");
                      return null;
                    }))),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                  var data = snapshot.data!;
                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (BuildContext context, int index) {
                      var current = data[index];
                      return Dismissible(
                        background: Container(color: Colors.red),
                        key: Key(box.getAt(index) ?? ""),
                        onDismissed: (direction) => box.deleteAt(index),
                        child: ListTile(
                            title: Text(current?['name'] ?? ""),
                            subtitle: Text(box.getAt(index) ?? ""),
                            trailing: IconButton(icon: const Icon(PhosphorIcons.signOutLight), onPressed: () {})),
                      );
                    },
                  );
                })));
  }
}
