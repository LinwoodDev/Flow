---
title: "Selfhosting"
sidebar_position: 5
---

![Versiune stabilă de lansare](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Versiune lansare nocturnă](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Este foarte ușor să îți găzduiești propriul server de flux.

## Server simplu

Instalați flutter și construiți aplicația folosind:

```bash
cd app
flutter pub obţine
flutter build web
```

Toate fișierele sunt în directorul `app/build/web`.

## Doctor

Clonează depozitul și construiește fișierul `Dockerfile` folosind: `docker construiește -t linwood-flow`. Pornește serverul folosind: `docker run -p 8080:8080 -d linwood-flow`.
