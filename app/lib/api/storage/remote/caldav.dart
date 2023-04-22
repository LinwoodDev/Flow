import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared/converters/ical.dart';
import 'package:shared/models/cached.dart';
import 'package:shared/models/event/database.dart';
import 'package:shared/models/event/item/database.dart';
import 'package:shared/models/event/item/model.dart';
import 'package:xml/xml.dart';

import '../../../models/request.dart';
import 'model.dart';
import 'service.dart';

class CalDavRemoteService extends RemoteService<CalDavStorage> {
  CalDavRemoteService(super.remoteStorage, super.local, super.password) {
    calendarItem = CalendarItemCalDavRemoteService(this);
  }

  @override
  Future<void> synchronize() async {
    await super.synchronize();
    final client = http.Client();
    final request = http.Request('REPORT', Uri.parse(remoteStorage.url));
    request.headers['Depth'] = '1';
    request.headers['Content-Type'] = 'application/xml; charset=utf-8';
    request.body = '''
<?xml version="1.0" encoding="utf-8" ?>
<C:calendar-query xmlns:D="DAV:"
                  xmlns:C="urn:ietf:params:xml:ns:caldav">
  <D:prop>
    <D:getetag/>
    <C:calendar-data/>
  </D:prop>
  <C:filter>
    <C:comp-filter name="VCALENDAR">
      <C:comp-filter name="VEVENT"/>
      <C:comp-filter name="VTODO"/>
    </C:comp-filter>
  </C:filter>
</C:calendar-query>
''';
    // Add auth basic
    request.headers['Authorization'] =
        'Basic ${base64Encode(utf8.encode('${remoteStorage.username}:$password'))}';
    final response = await client.send(request);
    final xmlDocument =
        XmlDocument.parse(await response.stream.bytesToString());
    // Get /d:multistatus/d:response/d:propstat/d:prop/cal:calendar-data
    final data = xmlDocument
            .getElement("d:multistatus")
            ?.findElements("d:response")
            .expand((e) => e.findElements("d:propstat"))
            .expand((e) => e.findElements("d:prop"))
            .expand((e) => e.findElements("cal:calendar-data")) ??
        [];
    final converter = ICalConverter();
    for (var element in data) {
      final text = element.innerText;
      converter.read(text.split('\n'), remoteStorage.identifier);
    }
    if (converter.data != null) import(converter.data!);
  }

  @override
  late final CalendarItemCalDavRemoteService calendarItem;
  @override
  EventDatabaseService get event => local.event;
}

class CalendarItemCalDavRemoteService
    extends CalendarItemDatabaseServiceLinker {
  final CalDavRemoteService remote;
  CalendarItemCalDavRemoteService(this.remote)
      : super(remote.local.calendarItem);

  @override
  Future<CalendarItem?> createCalendarItem(CalendarItem item) async {
    await remote.addRequest(
      APIRequest(
        method: 'PUT',
        authority: remote.remoteStorage.url,
        body: ICalConverter(CachedData(items: [item])).write().join('\n'),
        path: '',
      ),
    );
    return await super.createCalendarItem(item);
  }

  @override
  Future<bool> deleteCalendarItem(int id) async {
    await remote.addRequest(
      APIRequest(
        method: 'DELETE',
        authority: remote.remoteStorage.url,
        path: '',
      ),
    );
    return await super.deleteCalendarItem(id);
  }
}
