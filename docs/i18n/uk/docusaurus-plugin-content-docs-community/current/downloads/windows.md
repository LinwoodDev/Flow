---
title: "Вікна"
sidebar_position: 2
---

```mdx-code-block
імпортувати кнопку завантаження з '@site/src/components/DownloadButton.tsx';
```

![стабільна версія](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Нічна версія](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Мінімальні вимоги системи

* Windows 10 або вище.

## Двійкові файли

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Стабільний</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/stable/linwood-flow-windows-setup.exe">
        Установка
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/stable/linwood-flow-windows.zip">
        Портативний
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Нічна</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/nightly/linwood-flow-windows-setup.exe">
        Установка
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/nightly/linwood-flow-windows.zip">
        Портативний
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Дізнайтеся більше про нічну версію Flow [тут](/nightly).
