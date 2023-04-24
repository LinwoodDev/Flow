---
title: "Selfhosting"
sidebar_position: 5
---

![Versione di rilascio stabile](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Versione di rilascio notturno](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

È molto facile ospitare il proprio server web di flusso.

## Server semplice

Installa flutter e crea l'app utilizzando:

```bash
cd app
flutter pub get
flutter build web
```

Tutti i file sono nella directory `app/build/web`.

## Docker

Clona il repository e crea il file Docker `` utilizzando: `docker build -t linwood-flow`. Avvia il server utilizzando: `docker run -p 8080:8080 -d linwood-flow`.
