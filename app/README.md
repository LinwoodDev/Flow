# Flow app

Use the Flutter version pinned in `pubspec.yaml`. The `api` and `tools` folders
are separate Dart packages; CI checks all three.

```bash
flutter pub get
flutter run --flavor development
```

Android, Linux, and Windows builds select `production` or `nightly` with
`--flavor`. Desktop build output includes the flavor in its path, for example
`build/linux/x64/nightly/release/bundle` and
`build/windows/x64/nightly/runner/Release`.

Before packaging nightly Linux, MSIX, macOS, or iOS builds, apply their native
branding from the repository root:

```bash
dart run tools/apply_branding.dart nightly linux
```

Replace `linux` with `windows`, `macos`, or `ios`. This modifies packaging
sources and icons; start production packaging from a clean checkout. macOS,
iOS, and web builds use `--dart-define=flavor=nightly` for Dart branding. Web
nightly builds also copy `web_nightly/.` into `web/` before compilation.

Android uses AGP's built-in Kotlin and retains core-library desugaring for
calendar and notification plugins. The SDK compatibility workaround in
`android/gradle.properties` follows Butterfly until Flutter's bundled Kotlin
version check is corrected.

## Android 16 KB page sizes

From the repository root, check release APKs and Play bundles:

```bash
dart pub get -C tools
dart run tools/check_android_page_sizes.dart app/build/app/outputs/flutter-apk/app-arm64-v8a-nightly-release.apk
```

The checker validates every 64-bit ELF LOAD segment, uncompressed APK library
alignment, and AAB native-library packaging configuration. CI checks universal
APKs, split APKs, legacy APKs, and the Play bundle.

## Validation

```bash
flutter analyze --fatal-infos
flutter test
dart run build_runner build
```

The API and tools suites run with `dart test` from their package directories.
Build documentation with `pnpm install --frozen-lockfile && pnpm build` in
`docs`; its manifest pins pnpm. TypeScript remains on version 6 because the
current Astro checker does not declare TypeScript 7 support.

The app uses the newest compatible dependency versions. `connectivity_plus`
stays on 7.3.1 because its newer Linux dependencies conflict with the notification
plugin's `dbus` constraint. `equatable` stays on version 2 because
`flutter_timezone` requires it. Upgrade these when their upstream constraints
allow it.
