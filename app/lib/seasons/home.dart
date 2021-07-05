import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/services/api_service.dart';
import 'package:shared/models/season.dart';
import 'package:shared/services/local_service.dart';

import 'details.dart';

class SeasonsPage extends StatefulWidget {
  const SeasonsPage({Key? key}) : super(key: key);

  @override
  _SeasonsPageState createState() => _SeasonsPageState();
}

class _SeasonsPageState extends State<SeasonsPage> {
  Season? selected;
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
        actions: [IconButton(onPressed: () {}, icon: const Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(crossAxisAlignment: CrossAxisAlignment.start, textDirection: TextDirection.rtl, children: [
            if (isDesktop) ...[
              Expanded(flex: 2, child: SeasonPage(isDesktop: isDesktop, id: selected?.id)),
              const VerticalDivider()
            ],
            Expanded(
                flex: 3,
                child: Scaffold(
                    floatingActionButton: selected == null && isDesktop
                        ? null
                        : FloatingActionButton.extended(
                            label: const Text("Create season"),
                            icon: const Icon(PhosphorIcons.plusLight),
                            onPressed: () =>
                                isDesktop ? setState(() => selected = null) : Modular.to.pushNamed("/seasons/create")),
                    body: Scrollbar(
                        child: SingleChildScrollView(
                            child: StreamBuilder<List<Season>>(
                                stream: seasonStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Error: ${snapshot.error}");
                                  }
                                  if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                                    return const Center(child: CircularProgressIndicator());
                                  }
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
                                              : Modular.to.pushNamed(Uri(
                                                  pathSegments: ["", "seasons", "details"],
                                                  queryParameters: {"id": season.id.toString()}).toString())),
                                    );
                                  }));
                                })))))
          ]);
        }));
  }
}
