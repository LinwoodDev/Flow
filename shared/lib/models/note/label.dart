import 'package:shared/models/label/model.dart';

import 'package:shared/models/note/database.dart';

class LabelNoteDatabaseConnector extends NoteDatabaseConnector<Label> {
  @override
  String get connectedIdName => "itemId";

  @override
  String get connectedTableName => "labels";

  @override
  String get tableName => "labelNotes";
}
