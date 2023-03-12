---
title: "Selfhosting"
sidebar_position: 5
---

![稳定发布版本](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![每晚发布版本](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

您自己的流网络服务器的主机非常简单。

## 简单服务器

安装流体并使用以下方式构建应用：

```bash
cd app
flotter pub get
flotter building web
```

所有文件都在 `app/build/web` 目录中。

## 停靠栏

复制仓库并使用 `Dockerfile` 使用： `docker building -t linwood-flow` 启动服务器使用： `停靠运行-p 8080:8080 -d linwood-flow`。
