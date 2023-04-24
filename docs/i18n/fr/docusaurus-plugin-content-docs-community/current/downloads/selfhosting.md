---
title: "Selfhosting"
sidebar_position: 5
---

![Version de la version stable](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Version de la sortie nocturne](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Il est très facile d'héberger votre propre serveur web de flux.

## Serveur simple

Installez flotter et construisez l'application en utilisant :

```bash
cd app
flotter pub obtenir
flutter build web
```

Tous les fichiers se trouvent dans le répertoire `app/build/web`.

## Docker

Clonez le dépôt et construisez le `Dockerfile` en utilisant : `docker build -t linwood-flow`. Démarrez le serveur en utilisant : `docker run -p 8080:8080 -d linwood-flow`.
