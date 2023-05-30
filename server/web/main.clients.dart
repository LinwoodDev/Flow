// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/browser.dart';
import 'pages/admin.client.dart' deferred as i0;
import 'pages/app.client.dart' deferred as i1;

void main() {
  registerClients({
    'pages/admin': loadClient(
      i0.loadLibrary,
      (p) => i0.getComponentForParams(p),
    ),
    'pages/app': loadClient(
      i1.loadLibrary,
      (p) => i1.getComponentForParams(p),
    ),
  });
}
