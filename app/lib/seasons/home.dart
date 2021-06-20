import 'package:flow_app/services/api_service.dart';
import 'package:flow_app/services/local_service.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/season.dart';

import 'details.dart';

class SeasonsPage extends StatefulWidget {
  @override
  _SeasonsPageState createState() => _SeasonsPageState();
}

class _SeasonsPageState extends State<SeasonsPage> {
  Season? selected = null;
  late ApiService service;
  late Stream<List<Season>> seasonStream;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>();
    seasonStream = service.onSeasons();
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.seasons,
        pageTitle: "Seasons",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                if (isDesktop) ...[
                  Expanded(flex: 2, child: SeasonPage(isDesktop: isDesktop, id: selected?.id)),
                  VerticalDivider()
                ],
                Expanded(
                    flex: 3,
                    child: Scaffold(
                        floatingActionButton: FloatingActionButton.extended(
                            label: Text("Create season"),
                            icon: Icon(PhosphorIcons.plusLight),
                            onPressed: () => isDesktop
                                ? setState(() => selected = null)
                                : Modular.to.pushNamed("/seasons/create")),
                        body: Scrollbar(
                            child: SingleChildScrollView(
                                child: StreamBuilder<List<Season>>(
                                    stream: seasonStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) return Text("Error ${snapshot.error}");
                                      if (snapshot.connectionState == ConnectionState.waiting ||
                                          !snapshot.hasData)
                                        return Center(child: CircularProgressIndicator());
                                      var seasons = snapshot.data!;
                                      return Column(
                                          children: List.generate(seasons.length, (index) {
                                        var season = seasons[index];
                                        return Dismissible(
                                          key: Key(season.id!.toString()),
                                          onDismissed: (direction) {
                                            service.deleteSeason(season.id!);
                                          },
                                          background: Container(color: Colors.red),
                                          child: ListTile(
                                              title: Text(season.name),
                                              selected: selected?.id == season.id,
                                              onTap: () => isDesktop
                                                  ? setState(() => selected = season)
                                                  : Modular.to.pushNamed(Uri(pathSegments: [
                                                      "",
                                                      "seasons",
                                                      "details"
                                                    ], queryParameters: {
                                                      "id": season.id.toString()
                                                    }).toString())),
                                        );
                                      }));
                                    })))))
              ]);
        }));
  }
}
