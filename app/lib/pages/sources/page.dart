import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow/pages/sources/dialog.dart';
import 'package:flow/visualizer/storage.dart';
import 'package:flow/visualizer/sync.dart';
import 'package:flow/widgets/confirm_delete.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/storage/sources.dart';
import 'local.dart';

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).sources,
      actions: [
        StreamBuilder<SyncState>(
          stream: context.read<SourcesService>().syncState,
          builder: (context, snapshot) {
            final state = snapshot.data;
            return IconButton(
              icon: PhosphorIcon(
                state?.status.icon(PhosphorIconsStyle.light) ??
                    PhosphorIcons.warningCircle(PhosphorIconsStyle.light),
              ),
              tooltip: state?.status.getLocalizedName(context),
              onPressed: () async {
                final result = await context.read<SourcesService>().synchronize(
                  true,
                );
                if (context.mounted && result.failures.isNotEmpty) {
                  await _showSyncFailures(context, result.failures);
                }
              },
            );
          },
        ),
      ],
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                StreamBuilder<SyncState>(
                  stream: context.read<SourcesService>().syncState,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    final lastSuccessfulSync = state?.lastSuccessfulSync;
                    return ListTile(
                      title: Text(
                        state?.status.getLocalizedName(context) ??
                            AppLocalizations.of(context).loading,
                      ),
                      subtitle: Text(
                        lastSuccessfulSync == null
                            ? AppLocalizations.of(context).neverSynced
                            : AppLocalizations.of(context).lastSuccessfulSync(
                                DateFormat.yMd(
                                  AppLocalizations.of(context).localeName,
                                ).add_Hm().format(lastSuccessfulSync),
                              ),
                      ),
                      leading: PhosphorIcon(
                        state?.status.icon(PhosphorIconsStyle.light) ??
                            PhosphorIcons.warningCircle(
                              PhosphorIconsStyle.light,
                            ),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  title: Text(AppLocalizations.of(context).local),
                  leading: const PhosphorIcon(PhosphorIconsLight.laptop),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const LocalSourceDialog(),
                  ),
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
                            confirmDismiss: (_) => confirmDelete(
                              context,
                              title: AppLocalizations.of(
                                context,
                              ).removeSource(remote.displayName),
                              message: AppLocalizations.of(
                                context,
                              ).removeSourceDescription(remote.displayName),
                            ),
                            onDismissed: (_) {
                              setState(() => remotes.removeAt(index));
                              context.read<SourcesService>().removeRemote(
                                remote.toFilename(),
                              );
                            },
                            child: ListTile(
                              title: Text(remote.displayName),
                              leading: PhosphorIcon(
                                remote.icon(PhosphorIconsStyle.light),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddSourceDialog(),
        ),
        label: Text(AppLocalizations.of(context).create),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }

  Future<void> _showSyncFailures(
    BuildContext context,
    List<SyncFailure> failures,
  ) => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context).error),
      content: SizedBox(
        width: 500,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: failures.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final failure = failures[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(failure.source),
              subtitle: SelectableText(failure.message),
              leading: const PhosphorIcon(PhosphorIconsLight.warningCircle),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).close),
        ),
      ],
    ),
  );
}
