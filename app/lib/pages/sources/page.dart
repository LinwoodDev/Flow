import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow/pages/sources/dialog.dart';
import 'package:flow/visualizer/sync.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../api/storage/sources.dart';
import 'local.dart';

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).sources,
      actions: [
        StreamBuilder<SyncStatus>(
            stream: context.read<SourcesService>().syncStatus,
            builder: (context, snapshot) {
              return IconButton(
                icon: Icon(snapshot.data.getIcon()),
                onPressed: () =>
                    context.read<SourcesService>().synchronize(true),
              );
            }),
      ],
      body: SingleChildScrollView(
        child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).local),
                  leading: const Icon(Icons.computer_outlined),
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => const LocalSourceDialog()),
                ),
                BlocBuilder<SettingsCubit, FlowSettings>(
                    builder: (context, state) {
                  final remotes = List<RemoteStorage>.from(state.remotes);
                  return StatefulBuilder(
                    builder: (context, setState) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: remotes.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final remote = remotes[index];
                        return Dismissible(
                          key: ValueKey(remote),
                          onDismissed: (_) {
                            setState(() => remotes.removeAt(index));
                            context
                                .read<SourcesService>()
                                .removeRemote(remote.toFilename());
                          },
                          child: ListTile(
                            title: Text(remote.displayName),
                            leading: Icon(
                                remote.map(calDav: (_) => Icons.web_outlined)),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ]),
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
            context: context, builder: (context) => const AddSourceDialog()),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}
