---
title: "Linux"
sidebar_position: 3
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.tsx';
```

![Versione di rilascio stabile](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Versione di rilascio notturno](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

:::note

Si prega di utilizzare la versione flatpak se possibile. Altrimenti è necessario installare `libsecret-1-dev` e `libjsoncpp-dev`.

:::

## Binari

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabile</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/Flow/releases/download/stable/linwood-flow-linux.tar.gz">
        Portatile
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/Flow/releases/download/stable/linwood-flow-linux.deb">
        DEB
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/Flow/releases/download/stable/linwood-flow-linux.AppImage">
        AppImage
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Notte</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/Flow/releases/download/nightly/linwood-flow-linux.tar.gz">
        Portatile
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/Flow/releases/download/nightly/linwood-flow-linux.deb">
        DEB
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/Flow/releases/download/nightly/linwood-flow-linux.AppImage">
        AppImage
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Leggi di più sulla versione notturna di Flow [qui](/nightly).
