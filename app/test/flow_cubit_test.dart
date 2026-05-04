import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('setSources compares against every configured source', () async {
    SharedPreferences.setMockInitialValues({
      FlowSettings.remotesKey: [
        const ICalStorage(
          url: 'https://example.com/calendar.ics',
          username: 'user',
        ).toJson(),
      ],
    });
    final prefs = await SharedPreferences.getInstance();
    final settingsCubit = SettingsCubit(prefs);
    final cubit = FlowCubit(SourcesService(settingsCubit));
    final remote = settingsCubit.state.remotes.single.identifier;

    cubit.setSources(['']);
    expect(cubit.getCurrentSources(), ['']);

    cubit.setSources(['', remote]);
    expect(cubit.getCurrentSources(), ['', remote]);
  });
}
