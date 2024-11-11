import 'dart:async';

import 'dart:typed_data';
import 'package:flow_api/services/source.dart';

import 'model.dart';

abstract class PlaceService extends ModelService {
  FutureOr<List<Place>> getPlaces({
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Place?> getPlace(Uint8List id);

  FutureOr<Place?> createPlace(Place place);

  FutureOr<bool> updatePlace(Place place);

  FutureOr<bool> deletePlace(Uint8List id);
}
