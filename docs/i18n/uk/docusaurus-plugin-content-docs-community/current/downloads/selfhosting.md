---
title: "Selfhosting"
sidebar_position: 5
---

![стабільна версія](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Нічна версія](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Це дуже легко провести власний веб-сервер.

## Простий сервер

Встановити flutter і побудувати програму за допомогою:

```bash
cd додаток
прошивати pub отримати
водостільний збірку
```

Всі файли в каталозі `app/build/web`.

## Докер

Клонуйте репозиторій і збудуйте `Dockerfile` , використовуючи: `docker build -t linwood-flow`. Запустити сервер за допомогою: `докер запускає -p 80:8080 -d linwood-flow`.
