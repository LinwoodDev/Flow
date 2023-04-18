---
title: "Selfhosting"
sidebar_position: 5
---

![Versão de lançamento estável](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Versão de lançamento noturna](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

É muito fácil hospedar seu próprio servidor web de fluxo.

## Servidor simples

Instale o flutter e construa o aplicativo usando:

```bash
aplicativo cd
lutador pub obter
compilação web
```

Notes os arquivos estão no diretório `app/build/web`.

## Atracador

Clone o repositório e crie o `arquivo Dockerfile` usando: `docker build -t linwood-flow`. Inicie o servidor usando: `docker run -p 8080:8080 -d linwood-flow`.
