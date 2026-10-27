---
title: "Build your own"
---

1. Install Git and the Flutter version specified in `app/pubspec.yaml`.
2. Clone the repository and navigate to the `app` directory.
3. Use Flutter to compile the application:
   * `flutter build apk --flavor production`
   * `flutter build appbundle --flavor production`
   * `flutter build web --wasm --release --no-web-resources-cdn`
   * `flutter build linux --flavor production`
   * `flutter build windows --flavor production`
   * `flutter build macos --release`
   * `flutter build ios --release --no-codesign`
4. The compiled files are in `app/build/`.

## Offline builds

The shared packaging helper separates preparing dependencies online from building
with local dependencies. Run these commands from the repository root:

```sh
# Network access is needed, including for an initial release build.
dart pub get -C tools --enforce-lockfile
dart tools/build_offline.dart prepare --platform linux --flavor production

# Disable networking, keeping loopback available for local build tools.
dart tools/build_offline.dart build --platform linux
```

Install the pinned Flutter SDK and the native tools for your target:

| `--platform` | Build host | Additional prerequisites | Output under `app/build/` |
| --- | --- | --- | --- |
| `android` | Linux, Windows, or macOS | Java and Android SDK with accepted licenses | `app/outputs/flutter-apk/app-<flavor>-release.apk` |
| `linux` | Linux | CMake, Ninja, Clang, GTK, libsecret and libjsoncpp development libraries | `linux/<arch>/<flavor>/release/bundle/` |
| `windows` | Windows | Visual Studio's Flutter desktop build tools, including ATL | `windows/<arch>/<flavor>/runner/Release/` |
| `macos` | macOS | Xcode and the project's Apple dependency tooling | `macos/Build/Products/Release/flow.app` |
| `ios` | macOS | Xcode and the project's Apple dependency tooling | `ios/iphoneos/Runner.app` (unsigned) |
| `web` | Linux, Windows, or macOS | Flutter's web toolchain | `web/`, including the generated offline service worker |

If omitted, `--platform` defaults to the host OS. The flavor defaults to
`production`; use `--flavor nightly` for nightly builds. The build command remembers
the prepared flavor, architectures and additional `--dart-define=KEY=VALUE` values.
Changing these, lockfiles, or build configuration requires preparing again.
The build command also accepts `--analyze-size` and `--code-size-directory`.

Android includes ARMv7, ARM64 and x86_64 by default. Select a smaller build with
`--target-platform android-arm64`. Linux and Windows default to the host
architecture; Linux also accepts an explicit matching target such as
`--target-platform linux-arm64`. macOS prepares both Intel and Apple Silicon
targets, and iOS builds for ARM64 devices without code signing.

Dependencies are stored in `.offline-build/<platform>`, including a private Pub
cache, Android's Gradle cache, and hashed copies of downloaded native SQLite
libraries. SQLite downloads are restored after clean builds; compiled outputs are
rebuilt. Use `--cache-dir /path/to/cache` on both commands to change the cache location.

Keep the cache, checkout, `tools/.dart_tool`, and helper dependencies on the same
machine between steps. Flutter and native SDK components and tool caches remain
in their installed locations. Apple builds also need their prepared CocoaPods or
Swift package dependencies. Invoke the Dart script directly as shown so Dart does
not automatically resolve helper dependencies during the offline step.

Offline builds use Pub's `--offline --enforce-lockfile` and Gradle's offline mode.
Missing or modified prepared inputs cause the build to fail. To detect unexpected
network requests from SDKs or native build tools, disable networking while allowing
loopback. CI does this for Android, Linux and web; Windows and Apple builds use
offline dependency resolution with their prepared native tool caches.

CI uses UTC and the Git commit timestamp for both helper builds and direct
packaging steps. Windows and Linux ARM64 runners use the pinned Flutter Git tag
when a native SDK archive is unavailable; other runners use the stable SDK
archive. MSIX packaging uses the same prepared Windows build dependencies.
Release builds are allowed to finish when another run is queued.

## Reproducible builds

Use a fixed source timestamp and unsigned artifacts for independent comparisons:

```sh
dart tools/build_offline.dart prepare --platform linux --flavor production --unsigned
dart tools/build_offline.dart verify --platform linux
```

`verify` compares two clean offline release builds and their portable archives.
Reports are written to `.offline-build/<platform>/reproducibility/` and differences
cause a failure. `SOURCE_DATE_EPOCH` (or `--source-date-epoch`) defaults to the Git
commit timestamp. Set it explicitly for source archives without Git history.

Release ZIP and tar.gz files use sorted entries and fixed timestamps and preserve
permissions and symlinks. Android supports `--unsigned` without a signing key;
macOS can disable signing too. Signing, installers, store packages and upstream
SQLite binaries need separate validation. A successful comparison covers the two
builds on that host and checkout.

## Web offline loading

The helper generates an app-managed service worker after each web build. It
caches local renderers and application assets, including SQLite's Wasm files.
For a manual Flutter web build, generate it before deployment:

```sh
dart pub get -C tools --enforce-lockfile
cd app
flutter build web --wasm --release --no-web-resources-cdn
dart ../tools/build_web_service_worker.dart
```

Nightly web builds should first copy `app/web_nightly/` over `app/web/` and pass
`--dart-define=flavor=nightly`. Docker and the web deployment workflow do this
automatically. Offline loading becomes available after a successful online visit
in a browser that supports service workers over HTTPS or localhost.
