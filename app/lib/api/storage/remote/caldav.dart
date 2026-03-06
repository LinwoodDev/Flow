import 'dart:async';
import 'dart:convert';

import 'package:flow_api/models/note/database.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:flow_api/converters/ical.dart';
import 'package:flow_api/models/cached.dart';
import 'package:flow_api/models/event/database.dart';
import 'package:flow_api/models/event/item/database.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/extra.dart';
import 'package:flow_api/services/database.dart';
import 'package:xml/xml.dart';

import '../../../models/request.dart';
import 'model.dart';
import 'service.dart';

class CalDavRemoteService extends RemoteService<CalDavStorage> {
  CalDavRemoteService(super.remoteStorage, super.local, super.password) {
    calendarItem = CalendarItemCalDavRemoteService(this);
    note = NoteCalDavRemoteService(this);
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
    final xmlDocument = XmlDocument.parse(
      await response.stream.bytesToString(),
    );
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
      final name = href.substring(href.lastIndexOf('/') + 1);
      final id = createUniqueUint8List();
      converter.read(
        text.split('\n'),
        event: Event(
          name: name,
          id: id,
        ).addExtra(CalDavExtraProperties(etag: etag, path: href)),
        notebook: Notebook(id: id, name: name),
      );
    }
    if (converter.data != null) import(converter.data!);
  }

  String _getAuthHeader() =>
      'Basic ${base64Encode(utf8.encode('${remoteStorage.username}:$password'))}';

  @override
  late final CalendarItemCalDavRemoteService calendarItem;
  @override
  late final NoteCalDavRemoteService note;
  @override
  EventDatabaseService get event => local.event;
}

class NoteCalDavRemoteService extends NoteDatabaseServiceLinker {
  final CalDavRemoteService remote;
  NoteCalDavRemoteService(this.remote) : super(remote.local.note);

  @override
  Future<Note?> createNote(Note note) async {
    var notebookId = note.notebookId;
    if (notebookId != null && await remote.note.getNotebook(notebookId) == null) {
      notebookId =
          (await remote.note.createNotebook(
            Notebook(name: note.name, id: notebookId),
          ))?.id ??
          notebookId;
    }
    final result = await super.createNote(
      note.copyWith(notebookId: notebookId),
    );
    if (notebookId != null) {
      await _sendUpdatedCalendarObject(remote, notebookId);
    }
    return result;
  }

  @override
  Future<bool> updateNote(Note note) async {
    final result = await super.updateNote(note);
    if (note.notebookId != null) {
      await _sendUpdatedCalendarObject(remote, note.notebookId!);
    }
    return result;
  }

  @override
  Future<bool> deleteNote(Uint8List id) async {
    final item = await getNote(id);
    final result = await super.deleteNote(id);
    if (item?.notebookId != null) {
      await _sendUpdatedCalendarObject(remote, item!.notebookId!);
    }
    return result;
  }
}

class CalendarItemCalDavRemoteService
    extends CalendarItemDatabaseServiceLinker {
  final CalDavRemoteService remote;
  CalendarItemCalDavRemoteService(this.remote)
    : super(remote.local.calendarItem);

  @override
  Future<CalendarItem?> createCalendarItem(CalendarItem item) async {
    var object = item.eventId ?? createUniqueUint8List();
    if (await remote.event.getEvent(object) == null) {
      object =
          (await remote.event.createEvent(
            Event(name: item.name, description: item.description, id: object),
          ))?.id ??
          object;
    }
    final result = await super.createCalendarItem(
      item.copyWith(eventId: object),
    );
    await _sendUpdatedCalendarObject(remote, object);
    return result;
  }

  @override
  Future<bool> updateCalendarItem(CalendarItem item) async {
    final result = await super.updateCalendarItem(item);
    if (item.eventId != null) {
      await _sendUpdatedCalendarObject(remote, item.eventId!);
    }
    return result;
  }

  @override
  Future<bool> deleteCalendarItem(Uint8List id) async {
    final item = await getCalendarItem(id);
    final result = await super.deleteCalendarItem(id);
    if (item?.eventId != null) {
      await _sendUpdatedCalendarObject(remote, item!.eventId!);
    }
    return result;
  }
}

Future<void> _sendUpdatedCalendarObject(CalDavRemoteService remote, Uint8List id) async {
  final authority = remote.remoteStorage.uri.replace(path: '').toString();
  final items = (await remote.calendarItem.getCalendarItems(
    eventId: id,
  )).map((e) => e.source).toList();
  final notes = await remote.note.getNotes(notebook: id, limit: 1000000);
  
  if (items.isEmpty && notes.isEmpty) {
    await remote.addRequest(
      APIRequest(
        method: 'DELETE',
        authority: authority,
        path: '$id.ics',
        headers: {'Authorization': remote._getAuthHeader()},
      ),
    );
    return;
  }
  final event = await remote.event.getEvent(id);
  final body = ICalConverter(
    CachedData(items: items, notes: notes),
  ).write(event).join('\r\n');
  final extra = event?.extraProperties;
  final path = extra is CalDavExtraProperties ? extra.path : '$id';
  await remote.addRequest(
    APIRequest(
      method: 'PUT',
      authority: authority,
      body: body,
      path: '$path.ics',
      headers: {
        'Content-Type': 'text/calendar; charset=utf-8',
        'Authorization': remote._getAuthHeader(),
      },
    ),
  );
}
