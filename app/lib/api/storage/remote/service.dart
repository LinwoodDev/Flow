import 'package:flow/api/storage/remote/caldav.dart';
import 'package:flow/api/storage/remote/model.dart';
import 'package:shared/models/event/service.dart';
import 'package:shared/models/group/service.dart';
import 'package:shared/models/place/service.dart';
import 'package:shared/models/note/service.dart';
import 'package:shared/models/user/service.dart';
import 'package:shared/services/database.dart';
import 'package:shared/services/source.dart';

abstract class RemoteService<T extends RemoteStorage> extends SourceService {
  final DatabaseService local;
  final T remoteStorage;
  final String? password;

  RemoteService(this.remoteStorage, this.local, this.password);

  factory RemoteService.fromStorage(
      T storage, DatabaseService local, String? password) {
    return storage.map(
      calDav: (value) =>
          CalDavRemoteService(value, local, password) as RemoteService<T>,
    );
  }

  @override
  EventService? get event => local.event;
  @override
  NoteService? get note => local.note;
  @override
  PlaceService? get place => local.place;
  @override
  GroupService? get group => local.group;
  @override
  UserService? get user => local.user;

  Future<void> sync();
}
