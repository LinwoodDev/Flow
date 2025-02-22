import 'dart:async';

import 'dart:typed_data';
import 'package:flow_api/services/source.dart';

import 'model.dart';

abstract class ResourceService extends ModelService {
  FutureOr<List<Resource>> getResources({
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Resource?> getResource(Uint8List id);

  FutureOr<Resource?> createResource(Resource resource);

  FutureOr<bool> updateResource(Resource resource);

  FutureOr<bool> deleteResource(Uint8List id);
}

abstract class ResourceConnector<T> extends ModelConnector<Resource, T> {}
