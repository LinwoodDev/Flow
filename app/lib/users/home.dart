import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/services/local_service.dart';

import 'details.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  User? selected;
  late ApiService service;
  late Stream<List<User>> userStream;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>();
    userStream = service.onUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.users,
        pageTitle: "Users",
        actions: [IconButton(onPressed: () {}, icon: const Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(crossAxisAlignment: CrossAxisAlignment.start, textDirection: TextDirection.rtl, children: [
            if (isDesktop) ...[
              Expanded(flex: 2, child: UserPage(isDesktop: isDesktop, id: selected?.id)),
              const VerticalDivider()
            ],
            Expanded(
                flex: 3,
                child: Scaffold(
                    floatingActionButton: selected == null && isDesktop
                        ? null
                        : FloatingActionButton.extended(
                            label: const Text("Create user"),
                            icon: const Icon(PhosphorIcons.plusLight),
                            onPressed: () =>
                                isDesktop ? setState(() => selected = null) : Modular.to.pushNamed("/users/create")),
                    body: Scrollbar(
                        child: SingleChildScrollView(
                            child: StreamBuilder<List<User>>(
                                stream: userStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Error: ${snapshot.error}");
                                  }
                                  if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  var users = snapshot.data!;
                                  return Column(
                                      children: List.generate(users.length, (index) {
                                    var user = users[index];
                                    return Dismissible(
                                      key: Key(user.id!.toString()),
                                      onDismissed: (direction) {
                                        service.deleteUser(user.id!);
                                      },
                                      background: Container(color: Colors.red),
                                      child: ListTile(
                                          title: Text(user.name),
                                          selected: selected?.id == user.id,
                                          onTap: () => isDesktop
                                              ? setState(() => selected = user)
                                              : Modular.to.pushNamed(Uri(
                                                  pathSegments: ["", "users", "details"],
                                                  queryParameters: {"id": user.id.toString()}).toString())),
                                    );
                                  }));
                                })))))
          ]);
        }));
  }
}
