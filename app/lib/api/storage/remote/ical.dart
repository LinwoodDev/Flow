import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared/converters/ical.dart';
import 'package:shared/models/event/database.dart';
import 'package:shared/models/event/item/database.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/services/database.dart';

import 'model.dart';
import 'service.dart';

class IcalRemoteService extends RemoteService<ICalStorage> {
  IcalRemoteService(super.remoteStorage, super.local, super.password);

  @override
  Future<void> synchronize() async {
    await super.synchronize();
    final uri = remoteStorage.uri;
    final response = await http.get(uri, headers: {
      'Authorization': _getAuthHeader(),
    });
    final converter = ICalConverter();
    final name = remoteStorage.uri.host;
    converter.read(response.body.split('\n'),
        Event(name: name, id: createUniqueMultihash()));
    if (converter.data != null) import(converter.data!);
  }

  String _getAuthHeader() =>
      'Basic ${base64Encode(utf8.encode('${remoteStorage.username}:$password'))}';

  @override
  CalendarItemDatabaseService get calendarItem => local.calendarItem;
  @override
  EventDatabaseService get event => local.event;
}
