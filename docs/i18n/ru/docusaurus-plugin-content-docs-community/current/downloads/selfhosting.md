---
title: "Selfhosting"
sidebar_position: 5
---

![Стабильная версия релиза](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Ночной релиз версии](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Это очень легко разместить собственный веб-сервер потока.

## Простой сервер

Установите flutter и постройте приложение с помощью:

```bash
Приложение cd
flutter pub получить
flutter build web
```

Все файлы находятся в папке `app/build/web`.

## Докер

Клонируйте репозиторий и создайте `Dockerfile` с помощью: `docker build -t linwood-flow`. Запустите сервер используя `docker run -p 8080:8080 -d linwood-flow`.
