---
title: "Bireysel barındırma"
sidebar_position: 5
---

![Kararlı sürüm](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly sürüm](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

It is very easy to host your own flow web server.

## Basit sunucu

Flutter'ı yükleyin ve aşağıdakileri kullanarak uygulamayı oluşturun:

```bash
cd app
flutter pub get
flutter build web
```

Bütün klasörler `app/build/web` yolu içerisindedir.

## Docker

Depoyu klonlayın ve şunu kullanarak `Dockerfile`'ı oluşturun: `docker build -t linwood-flow`. Sunucuyu şunu kullanarak başlatın: `docker run -p 8080:8080 -d linwood-flow`.
