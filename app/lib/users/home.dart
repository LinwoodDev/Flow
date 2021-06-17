import 'package:flow_app/services/api_service.dart';
import 'package:flow_app/services/local_service.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/user.dart';

import 'details.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  User? selected = null;
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
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 3,
              child: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                    label: Text("Create user"),
                    icon: Icon(PhosphorIcons.plusLight),
                    onPressed: () => isDesktop
                        ? setState(() => selected = null)
                        : Modular.to.pushNamed("/users/create")),
                body: Scrollbar(
                    child: SingleChildScrollView(
                        child: StreamBuilder<List<User>>(
                            stream: userStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) return Text("Error ${snapshot.error}");
                              if (snapshot.connectionState == ConnectionState.waiting ||
                                  !snapshot.hasData)
                                return Center(child: CircularProgressIndicator());
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
                                                  pathSegments: ["", "events", "details"],
                                                  queryParameters: {"id": index.toString()})
                                              .toString())),
                                );
                              }));
                            }))),
              ),
            ),
            if (isDesktop) ...[
              VerticalDivider(),
              Expanded(
                  flex: 2, child: UserPage(user: selected, isDesktop: isDesktop, id: selected?.id))
            ]
          ]);
        }));
  }
}
