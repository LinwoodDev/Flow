---
title: Selfhosting
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

It is very easy to host your own Flow web server.

## Jednoduchý server

Nainstalujte flutter a sestavte aplikaci pomocí:

```bash
cd app
flutter pub get
flutter build web
```

All the files are in the `app/build/web` directory.

## Dokovací modul

Clone the repository and build the `Dockerfile` using: `docker build -t linwood-flow`.
Start the server using: `docker run -p 8080:8080 -d linwood-flow`.
