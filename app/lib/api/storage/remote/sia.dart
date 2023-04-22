import 'dart:async';

import 'model.dart';
import 'service.dart';

class SiaRemoteService extends RemoteService<SiaStorage> {
  SiaRemoteService(super.remoteStorage, super.local, super.password);

  @override
  Future<void> sync() {
    // TODO: implement sync
    throw UnimplementedError();
  }
}
