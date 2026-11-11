# Flow app

The Flutter application for Linwood Flow.

## Offline web builds

Build and generate the offline cache from the repository root:

```bash
dart pub get -C tools
cd app
flutter build web --wasm --release --no-web-resources-cdn
cd ..
dart run tools/build_web_service_worker.dart
```

Run the generator after all build files have been written, then deploy all of
`app/build/web` over HTTPS (localhost also works). The deployment workflow does
this for both stable and nightly. It replaces Flutter's cleanup stub at
`flutter_service_worker.js` with Butterfly's own worker. Custom output directories
can be passed as the generator's first argument; subpath hosting uses Flutter's
`--base-href` as usual.

After one online visit and successful cache installation, the app can reload
offline, including deep links, rendering engines, fonts, and bundled import
libraries. Local calendars stay in browser storage; remote sync and network imports
still need a connection. The first download caches the entire build, so leave
the app online until the worker activates (visible in browser developer tools).
New builds wait until all app tabs close before activating, preserving open
editing sessions. Serve the worker with revalidation enabled rather than
immutable caching. The worker only caches bundled files, never API responses.
