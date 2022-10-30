import 'package:flow/cubits/settings.dart';
import 'package:shared/services/database.dart';

class SourcesService {
  final SettingsCubit settingsCubit;
  final DatabaseService local;

  SourcesService(this.settingsCubit, this.local);
}
