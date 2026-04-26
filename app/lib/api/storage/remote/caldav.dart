import 'dart:async';
import 'dart:convert';

import 'package:flow_api/models/event/service.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/models/note/database.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flow_api/models/note/service.dart';
import 'package:flow_api/models/resource/model.dart';
import 'package:flow_api/models/resource/service.dart';
import 'package:flow_api/models/user/model.dart';
import 'package:flow_api/services/source.dart';
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
    event = EventCalDavRemoteService(this);
    calendarItem = CalendarItemCalDavRemoteService(this);
    note = NoteCalDavRemoteService(this);
    eventNote = EventNoteCalDavConnector(this, local.eventNote);
    eventResource = EventResourceCalDavConnector(this, local.eventResource);
    eventUser = EventModelCalDavConnector(this, local.eventUser);
    eventGroup = EventModelCalDavConnector(this, local.eventGroup);
    calendarItemNote = CalendarItemNoteCalDavConnector(
      this,
      local.calendarItemNote,
    );
    calendarItemResource = CalendarItemResourceCalDavConnector(
      this,
      local.calendarItemResource,
    );
    calendarItemUser = CalendarItemModelCalDavConnector(
      this,
      local.calendarItemUser,
    );
    calendarItemGroup = CalendarItemModelCalDavConnector(
      this,
      local.calendarItemGroup,
    );
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
  late final EventCalDavRemoteService event;
  @override
  late final CalendarItemCalDavRemoteService calendarItem;
  @override
  late final NoteCalDavRemoteService note;
  @override
  late final NoteConnector<Event> eventNote;
  @override
  late final NoteConnector<CalendarItem> calendarItemNote;
  @override
  late final ResourceConnector<Event> eventResource;
  @override
  late final ResourceConnector<CalendarItem> calendarItemResource;
  @override
  late final ModelConnector<User, Event> eventUser;
  @override
  late final ModelConnector<Group, Event> eventGroup;
  @override
  late final ModelConnector<User, CalendarItem> calendarItemUser;
  @override
  late final ModelConnector<Group, CalendarItem> calendarItemGroup;

  @override
  get labelNote => local.labelNote;
  @override
  get userNote => local.userNote;
  @override
  get groupNote => local.groupNote;
  @override
  get resource => local.resource;
  @override
  get userResource => local.userResource;
  @override
  get groupResource => local.groupResource;
  @override
  get group => local.group;
  @override
  get user => local.user;
  @override
  get label => local.label;
  @override
  get userGroup => local.userGroup;
  @override
  get userNotebook => local.userNotebook;
  @override
  get groupNotebook => local.groupNotebook;
  @override
  get userLabel => local.userLabel;
  @override
  get groupLabel => local.groupLabel;
}

class EventModelCalDavConnector<I> extends ModelConnector<I, Event> {
  final CalDavRemoteService remote;
  final ModelConnector<I, Event> service;

  EventModelCalDavConnector(this.remote, this.service);

  @override
  FutureOr<void> clear() => service.clear();

  @override
  Future<void> connect(Uint8List connectId, Uint8List itemId) async {
    await service.connect(connectId, itemId);
    await _sendUpdatedCalendarObject(remote, connectId);
  }

  @override
  Future<void> disconnect(Uint8List connectId, Uint8List itemId) async {
    await service.disconnect(connectId, itemId);
    await _sendUpdatedCalendarObject(remote, connectId);
  }

  @override
  Future<List<Event>> getConnected(
    Uint8List itemId, {
    int offset = 0,
    int limit = 50,
  }) => service.getConnected(itemId, offset: offset, limit: limit);

  @override
  Future<List<I>> getItems(
    Uint8List connectId, {
    int offset = 0,
    int limit = 50,
  }) => service.getItems(connectId, offset: offset, limit: limit);

  @override
  FutureOr<bool> isConnected(Uint8List connectId, Uint8List itemId) =>
      service.isConnected(connectId, itemId);
}

class EventNoteCalDavConnector extends EventModelCalDavConnector<Note>
    implements NoteConnector<Event> {
  final NoteConnector<Event> noteService;

  EventNoteCalDavConnector(CalDavRemoteService remote, this.noteService)
    : super(remote, noteService);

  @override
  FutureOr<bool?> notesDone(Uint8List connectId) =>
      noteService.notesDone(connectId);
}

class EventResourceCalDavConnector extends EventModelCalDavConnector<Resource>
    implements ResourceConnector<Event> {
  EventResourceCalDavConnector(
    super.remote,
    ResourceConnector<Event> super.service,
  );
}

class CalendarItemModelCalDavConnector<I>
    extends ModelConnector<I, CalendarItem> {
  final CalDavRemoteService remote;
  final ModelConnector<I, CalendarItem> service;

  CalendarItemModelCalDavConnector(this.remote, this.service);

  @override
  FutureOr<void> clear() => service.clear();

  @override
  Future<void> connect(Uint8List connectId, Uint8List itemId) async {
    await service.connect(connectId, itemId);
    await _sendUpdatedCalendarItemObject(remote, connectId);
  }

  @override
  Future<void> disconnect(Uint8List connectId, Uint8List itemId) async {
    await service.disconnect(connectId, itemId);
    await _sendUpdatedCalendarItemObject(remote, connectId);
  }

  @override
  Future<List<CalendarItem>> getConnected(
    Uint8List itemId, {
    int offset = 0,
    int limit = 50,
  }) => service.getConnected(itemId, offset: offset, limit: limit);

  @override
  Future<List<I>> getItems(
    Uint8List connectId, {
    int offset = 0,
    int limit = 50,
  }) => service.getItems(connectId, offset: offset, limit: limit);

  @override
  FutureOr<bool> isConnected(Uint8List connectId, Uint8List itemId) =>
      service.isConnected(connectId, itemId);
}

class CalendarItemNoteCalDavConnector
    extends CalendarItemModelCalDavConnector<Note>
    implements NoteConnector<CalendarItem> {
  final NoteConnector<CalendarItem> noteService;

  CalendarItemNoteCalDavConnector(CalDavRemoteService remote, this.noteService)
    : super(remote, noteService);

  @override
  FutureOr<bool?> notesDone(Uint8List connectId) =>
      noteService.notesDone(connectId);
}

class CalendarItemResourceCalDavConnector
    extends CalendarItemModelCalDavConnector<Resource>
    implements ResourceConnector<CalendarItem> {
  CalendarItemResourceCalDavConnector(
    super.remote,
    ResourceConnector<CalendarItem> super.service,
  );
}

class EventCalDavRemoteService extends EventService {
  final CalDavRemoteService remote;

  EventCalDavRemoteService(this.remote);

  EventDatabaseService get service => remote.local.event;

  @override
  Future<void> clear() => service.clear();

  @override
  Future<Event?> createEvent(Event event) async {
    final result = await service.createEvent(event);
    final id = result?.id;
    if (id != null) {
      await _sendUpdatedCalendarObject(remote, id);
    }
    return result;
  }

  @override
  Future<bool> deleteEvent(Uint8List id) async {
    final event = await service.getEvent(id);
    final result = await service.deleteEvent(id);
    if (result) {
      await _deleteCalendarObject(remote, id, event);
    }
    return result;
  }

  @override
  Future<Event?> getEvent(Uint8List id) => service.getEvent(id);

  @override
  Future<List<Event>> getEvents({
    Uint8List? groupId,
    List<Uint8List>? resourceIds,
    int offset = 0,
    int limit = 50,
    String search = '',
  }) => service.getEvents(
    groupId: groupId,
    resourceIds: resourceIds,
    offset: offset,
    limit: limit,
    search: search,
  );

  @override
  Future<bool> updateEvent(Event event) async {
    final result = await service.updateEvent(event);
    final id = event.id;
    if (result && id != null) {
      await _sendUpdatedCalendarObject(remote, id);
    }
    return result;
  }
}

class NoteCalDavRemoteService extends NoteDatabaseServiceLinker {
  final CalDavRemoteService remote;
  NoteCalDavRemoteService(this.remote) : super(remote.local.note);

  @override
  Future<Note?> createNote(Note note) async {
    var notebookId = note.notebookId;
    if (notebookId != null &&
        await remote.note.getNotebook(notebookId) == null) {
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

Future<void> _sendUpdatedCalendarObject(
  CalDavRemoteService remote,
  Uint8List id,
) async {
  final items = (await remote.calendarItem.getCalendarItems(
    eventId: id,
  )).map((e) => e.source).toList();
  final notes = await remote.note.getNotes(notebook: id, limit: 1000000);
  final event = await remote.event.getEvent(id);

  if (event == null && items.isEmpty && notes.isEmpty) {
    await _deleteCalendarObject(remote, id);
    return;
  }
  final body = ICalConverter(
    CachedData(items: items, notes: notes),
  ).write(event).join('\r\n');
  await remote.addRequest(
    APIRequest(
      method: 'PUT',
      authority: _calDavAuthority(remote),
      body: body,
      path: _calendarObjectPath(remote, id, event),
      headers: {
        'Content-Type': 'text/calendar; charset=utf-8',
        'Authorization': remote._getAuthHeader(),
      },
    ),
  );
}

Future<void> _sendUpdatedCalendarItemObject(
  CalDavRemoteService remote,
  Uint8List id,
) async {
  final item = await remote.calendarItem.getCalendarItem(id);
  final eventId = item?.eventId;
  if (eventId != null) {
    await _sendUpdatedCalendarObject(remote, eventId);
  }
}

Future<void> _deleteCalendarObject(
  CalDavRemoteService remote,
  Uint8List id, [
  Event? event,
]) async {
  await remote.addRequest(
    APIRequest(
      method: 'DELETE',
      authority: _calDavAuthority(remote),
      path: _calendarObjectPath(remote, id, event),
      headers: {'Authorization': remote._getAuthHeader()},
    ),
  );
}

String _calDavAuthority(CalDavRemoteService remote) {
  final uri = remote.remoteStorage.uri;
  return uri.replace(path: '', query: '', fragment: '').toString();
}

String _calendarObjectPath(
  CalDavRemoteService remote,
  Uint8List id, [
  Event? event,
]) {
  final extra = event?.extraProperties;
  if (extra is CalDavExtraProperties && extra.path.isNotEmpty) {
    return extra.path;
  }
  final collection = remote.remoteStorage.uri.path;
  final filename = '${base64UrlEncode(id)}.ics';
  return collection.endsWith('/')
      ? '$collection$filename'
      : '$collection/$filename';
}
