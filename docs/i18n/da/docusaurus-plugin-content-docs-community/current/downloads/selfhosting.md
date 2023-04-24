---
title: "Selfhosting"
sidebar_position: 5
---

![Stabil version](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Det er meget nemt at være vært for din egen flow webserver.

## Simpel server

Installér flutter og opbyg app'en med:

```bash
cd app
flutter pub få
flutter build web
```

Alle filerne er i mappen `app/build/web`.

## Docker

Klon lageret og opbyg `Dockerfilen` vha. `docker build -t linwood-flow`. Start serveren med: `docker run -p 8080:8080 -d linwood-flow`.
