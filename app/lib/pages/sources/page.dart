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
import 'details.dart';

import 'counts.dart';

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final sources = context.read<SourcesService>();
    return FlowNavigation(
      title: l10n.sources,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.sources, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(l10n.sourcesDescription, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 24),
                StreamBuilder<SyncState>(
                  stream: sources.syncState,
                  initialData: sources.syncState.value,
                  builder: (context, snapshot) {
                    final state = snapshot.data!;
                    final syncing = state.status == SyncStatus.syncing;
                    final lastSync = state.lastSuccessfulSync;
                    return Card.filled(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                PhosphorIcon(
                                  state.status.icon(PhosphorIconsStyle.light),
                                  color: state.failures.isEmpty
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.error,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    state.status.getLocalizedName(context),
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              lastSync == null
                                  ? l10n.neverSynced
                                  : l10n.lastSuccessfulSync(
                                      DateFormat.yMd(l10n.localeName)
                                          .add_Hm()
                                          .format(lastSync),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                FilledButton.tonalIcon(
                                  onPressed: syncing
                                      ? null
                                      : () async {
                                          final result = await sources
                                              .synchronize(true);
                                          if (context.mounted &&
                                              result.failures.isNotEmpty) {
                                            await _showSyncFailures(
                                              context,
                                              result.failures,
                                            );
                                          }
                                        },
                                  icon: syncing
                                      ? const SizedBox.square(
                                          dimension: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const PhosphorIcon(
                                          PhosphorIconsLight.arrowsClockwise,
                                        ),
                                  label: Text(
                                    syncing ? l10n.syncing : l10n.syncNow,
                                  ),
                                ),
                                if (state.failures.isNotEmpty)
                                  TextButton.icon(
                                    onPressed: () => _showSyncFailures(
                                      context,
                                      state.failures,
                                    ),
                                    icon: const PhosphorIcon(
                                      PhosphorIconsLight.warningCircle,
                                    ),
                                    label: Text(l10n.sourceDetails),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Card.outlined(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(l10n.local),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.localSourceDescription),
                        const SizedBox(height: 6),
                        const SourceItemCounts(),
                      ],
                    ),
                    leading: const PhosphorIcon(PhosphorIconsLight.laptop),
                    trailing: const PhosphorIcon(
                      PhosphorIconsLight.caretRight,
                      size: 18,
                    ),
                    onTap: () => showDialog<void>(
                      context: context,
                      builder: (context) => const LocalSourceDialog(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(l10n.connectedSources, style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                BlocBuilder<SettingsCubit, FlowSettings>(
                  builder: (context, state) {
                    if (state.remotes.isEmpty) {
                      return Card.outlined(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              PhosphorIcon(
                                PhosphorIconsLight.cloud,
                                size: 36,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                l10n.noConnectedSources,
                                style: theme.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.noConnectedSourcesDescription,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: state.remotes
                          .map(
                            (remote) => Card.outlined(
                              margin: const EdgeInsets.only(bottom: 8),
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                title: Text(
                                  remote.displayName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${remote.getLocalizedName(context)}${remote.isReadOnly ? ' · ${l10n.readOnly}' : ''}',
                                    ),
                                    const SizedBox(height: 6),
                                    SourceItemCounts(source: remote.identifier),
                                  ],
                                ),
                                leading: PhosphorIcon(
                                  remote.icon(PhosphorIconsStyle.light),
                                ),
                                onTap: () => showDialog<void>(
                                  context: context,
                                  builder: (context) =>
                                      SourceDetailsDialog(source: remote),
                                ),
                                trailing: IconButton(
                                  tooltip: l10n.removeSource(
                                    remote.displayName,
                                  ),
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.trash,
                                  ),
                                  onPressed: () =>
                                      _removeSource(context, remote),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog<void>(
          context: context,
          builder: (context) => const AddSourceDialog(),
        ),
        label: Text(l10n.addSource),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }

  Future<void> _removeSource(BuildContext context, RemoteStorage remote) async {
    final confirmed = await confirmDelete(
      context,
      title: AppLocalizations.of(context).removeSource(remote.displayName),
      message: AppLocalizations.of(context)
          .removeSourceDescription(remote.displayName),
    );
    if (!confirmed || !context.mounted) return;
    try {
      await context.read<SourcesService>().removeRemote(remote.toFilename());
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).deleteFailed)),
        );
    }
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
