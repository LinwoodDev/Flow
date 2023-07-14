import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flow_api/converters/ical.dart';
import 'package:flow_api/models/event/database.dart';
import 'package:flow_api/models/event/item/database.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/services/database.dart';

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
