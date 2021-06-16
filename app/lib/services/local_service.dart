import 'package:flow_app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:shared/team.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class LocalService extends ApiService {
  final Database db;
  static const String teamsStoreName = 'teams';
  final teamsStore = intMapStoreFactory.store(teamsStoreName);
  LocalService(this.db);

  static Future<LocalService> create() async {
    if (kIsWeb) {
      var factory = databaseFactoryWeb;

      // Open the database
      var db = await factory.openDatabase('test');
      return LocalService(db);
    } else {
      // get the application documents directory
      var dir = await getApplicationDocumentsDirectory();
// make sure it exists
      await dir.create(recursive: true);
// build the database path
      var dbPath = join(dir.path, 'linwood_flow.db');
// open the database
      var db = await databaseFactoryIo.openDatabase(dbPath);
      return LocalService(db);
    }
  }

  @override
  Future<void> createTeam(Team team) => teamsStore.add(db, team.toJson());

  @override
  Future<List<Team>> fetchTeams() =>
      teamsStore.find(db).then((value) => value.map((e) => Team.fromJson(e.value)).toList());
}
