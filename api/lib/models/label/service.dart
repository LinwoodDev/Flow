import 'dart:async';

import 'package:lib5/lib5.dart';
import 'package:flow_api/services/source.dart';

import 'model.dart';

abstract class LabelService extends ModelService {
  FutureOr<List<Label>> getLabels({
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Label?> getLabel(Multihash id);

  FutureOr<Label?> createLabel(Label label);

  FutureOr<bool> updateLabel(Label label);

  FutureOr<bool> deleteLabel(Multihash id);
}
