import 'package:shared/models/user/service.dart';

import 'package:shared/models/todo/service.dart';

import 'package:shared/models/place/service.dart';

import 'package:shared/models/group/service.dart';

import 'package:shared/models/event/service.dart';

import 'service.dart';

class GoogleRemoteService extends RemoteService {
  GoogleRemoteService(super.baseUrl);

  @override
  // TODO: implement event
  EventService get event => throw UnimplementedError();

  @override
  // TODO: implement group
  GroupService get group => throw UnimplementedError();

  @override
  // TODO: implement place
  PlaceService get place => throw UnimplementedError();

  @override
  // TODO: implement todo
  TodoService get todo => throw UnimplementedError();

  @override
  // TODO: implement user
  UserService get user => throw UnimplementedError();

  @override
  // TODO: implement version
  String get version => throw UnimplementedError();
}
