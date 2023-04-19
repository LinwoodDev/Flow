# flow_server

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

An example application built with dart_frog

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

## Running

Install dependencies:

```bash
dart pub global activate dart_frog
dart pub get
```

Build webdev:

```bash
dart run webdev build --output=static
```

Serve dev server:

```bash
dart_frog dev
```

Build production:

```bash
dart_frog build
```

Serve production:

```bash
cd build
docker build -t flow_server .
docker run -p 8080:8080 flow_server
```
