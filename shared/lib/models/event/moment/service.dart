import 'dart:async';

import '../../../services/source.dart';
import '../../model.dart';
import '../model.dart';
import 'model.dart';

abstract class MomentService extends ModelService {
  FutureOr<Moment?> getMoment(int id);

  FutureOr<List<ConnectedModel<Moment, Event?>>> getMoments({
    List<EventStatus>? status,
    int offset = 0,
    int limit = 50,
    DateTime? start,
    DateTime? end,
    DateTime? date,
    String search = '',
    int? groupId,
    int? placeId,
    int? eventId,
  });

  FutureOr<Moment?> createMoment(Moment moment);

  FutureOr<bool> updateMoment(Moment moment);

  FutureOr<bool> deleteMoment(int id);
}
