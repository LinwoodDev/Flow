import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lib5/lib5.dart';
import 'package:shared/converters/ical.dart';
import 'package:shared/models/cached.dart';
import 'package:shared/models/event/database.dart';
import 'package:shared/models/event/item/database.dart';
import 'package:shared/models/event/item/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/extra.dart';
import 'package:shared/services/database.dart';
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
    request.headers['Authorization'] = _getAuthHeader();
    final response = await client.send(request);
    final xmlDocument =
        XmlDocument.parse(await response.stream.bytesToString());
    // Get /d:multistatus/d:response/d:propstat/d:prop/cal:calendar-data
    final data =
        xmlDocument.getElement("d:multistatus")?.findElements("d:response") ??
            [];
    final converter = ICalConverter();
    for (var element in data) {
      final href = element.getElement("d:href")?.innerText;
      final prop = element.getElement("d:propstat")?.getElement("d:prop");
      if (href == null) continue;
      final text = prop?.getElement("cal:calendar-data")?.innerText;
      if (text == null) continue;
      final etag = prop?.getElement("d:getetag")?.innerText;
      if (etag == null) continue;
      converter.read(
          text.split('\n'),
          Event(
                  name: href.substring(href.lastIndexOf('/') + 1),
                  id: createUniqueMultihash())
              .addExtra(ExtraProperties.calDav(etag: etag, path: href)));
    }
    if (converter.data != null) import(converter.data!);
  }

  String _getAuthHeader() =>
      'Basic ${base64Encode(utf8.encode('${remoteStorage.username}:$password'))}';

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
    var object = item.eventId ?? createUniqueMultihash();
    if (await remote.event.getEvent(object) == null) {
      object = (await remote.event.createEvent(Event(
            name: item.name,
            description: item.description,
            id: object,
          )))
              ?.id ??
          object;
    }
    final result =
        await super.createCalendarItem(item.copyWith(eventId: object));
    await _sendUpdatedCalendarObject(result);
    return result;
  }

  @override
  Future<bool> deleteCalendarItem(Multihash id) async {
    final item = await getCalendarItem(id);
    final result = await super.deleteCalendarItem(id);
    await _sendUpdatedCalendarObject(item);
    return result;
  }

  Future<void> _sendUpdatedCalendarObject(CalendarItem? item) async {
    if (item?.eventId == null) return;
    final authority = remote.remoteStorage.uri.replace(path: '').toString();
    final items = (await getCalendarItems(
      eventId: item!.eventId,
    ))
        .map((e) => e.source)
        .toList();
    if (items.isEmpty) {
      await remote.addRequest(
        APIRequest(
          method: 'DELETE',
          authority: authority,
          path: '${item.eventId}.ics',
          headers: {'Authorization': remote._getAuthHeader()},
        ),
      );
      return;
    }
    final event = await remote.event.getEvent(item.eventId!);
    final body =
        ICalConverter(CachedData(items: items)).write(event).join('\n');
    final extra = event?.extraProperties;
    if (extra is! CalDavExtraProperties) return;
    await remote.addRequest(
      APIRequest(
        method: 'PUT',
        authority: authority,
        body: body,
        path: '${extra.path}.ics',
        headers: {
          'Content-Type': 'text/calendar; charset=utf-8',
          'Authorization': remote._getAuthHeader(),
        },
      ),
    );
  }
}
