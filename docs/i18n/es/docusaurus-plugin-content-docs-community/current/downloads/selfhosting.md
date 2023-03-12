---
title: "Selfhosting"
sidebar_position: 5
---

![Versión estable](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Versión de lanzamiento nocturno](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Es muy fácil alojar su propio servidor web de flujo.

## Servidor simple

Instala flutter y construye la aplicación utilizando:

```bash
app cd
pub flutter get
web build flutter
```

Todos los archivos están en el directorio `app/build/web`.

## Doctor

Clona el repositorio y construye el `Dockerfile` usando: `docker build -t linwood-flow`. Iniciar el servidor usando: `docker run -p 8080:8080 -d linwood-flow`.
