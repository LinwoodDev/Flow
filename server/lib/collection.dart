import 'package:isar/isar.dart';
import 'package:shared/models/event.dart';
import 'package:shared/models/server.dart';
import 'package:shared/models/user.dart';

@ExternalCollection(User)
@ExternalCollection(Server)
@ExternalCollection(Event)
class ServerCollectionRegistry {}
