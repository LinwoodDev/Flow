---
title: "Okna"
sidebar_position: 2
---

```mdx-code-block
importuj przycisk DownloadButton z '@site/src/components/DownloadButton.tsx';
```

![Stabilna wersja wydania](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Wersja Nightly](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Minimalne wymagania systemowe

* Okna 10 lub wyższe.

## Pliki binarne

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabilność</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/stable/linwood-flow-windows-setup.exe">
        Ustawienia
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/stable/linwood-flow-windows.zip">
        Przenośne
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nocny</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/nightly/linwood-flow-windows-setup.exe">
        Ustawienia
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/nightly/linwood-flow-windows.zip">
        Przenośne
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Dowiedz się więcej o nocnej wersji przepływu [tutaj](/nightly).
