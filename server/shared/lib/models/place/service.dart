import 'dart:async';

import 'package:lib5/lib5.dart';
import 'package:shared/services/source.dart';

import 'model.dart';

abstract class PlaceService extends ModelService {
  FutureOr<List<Place>> getPlaces({
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Place?> getPlace(Multihash id);

  FutureOr<Place?> createPlace(Place place);

  FutureOr<bool> updatePlace(Place place);

  FutureOr<bool> deletePlace(Multihash id);
}
