import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared/models/user/service.dart';
import 'package:shared/models/place/service.dart';
import 'package:shared/models/group/service.dart';
import 'package:shared/converters/ical.dart';
import 'package:xml/xml.dart';

import 'model.dart';
import 'service.dart';

class SiaRemoteService extends RemoteService<SiaStorage> {
  SiaRemoteService(super.remoteStorage, super.local, super.password);

  @override
  PlaceService? get place => null;
  @override
  GroupService? get group => null;
  @override
  UserService? get user => null;

  @override
  Future<void> sync() async {
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
      converter.read(text.split('\n'));
    }
    if (converter.data != null) import(converter.data!);
  }
}
