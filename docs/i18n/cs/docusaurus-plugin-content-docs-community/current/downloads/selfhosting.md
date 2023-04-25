---
title: "Selfhosting"
sidebar_position: 5
---

![Stabilní verze vydání](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release verze](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Je velmi snadné hostit vlastní tokový webový server.

## Jednoduchý server

Nainstalujte flutter a sestavte aplikaci pomocí:

```bash
cd aplikace
flutter hospoda získat
web pro sestavení flutteru
```

Všechny soubory jsou v adresáři `app/build/web`.

## Dokovací modul

Klonovat úložiště a vytvořit soubor `Dockerfile` pomocí `docker build -t linwood-flow`. Spusťte server pomocí: `dokovací běh -p 80:8080 -d linwood-flow`.
