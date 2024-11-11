import 'dart:async';

import 'dart:typed_data';
import 'package:flow_api/services/source.dart';

import 'model.dart';

abstract class LabelService extends ModelService {
  FutureOr<List<Label>> getLabels({
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Label?> getLabel(Uint8List id);

  FutureOr<Label?> createLabel(Label label);

  FutureOr<bool> updateLabel(Label label);

  FutureOr<bool> deleteLabel(Uint8List id);
}
