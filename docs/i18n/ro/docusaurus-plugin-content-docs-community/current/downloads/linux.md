---
title: "Linux"
sidebar_position: 3
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.tsx';
```

![Versiune stabilă de lansare](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Versiune lansare nocturnă](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

:::note

Vă rugăm să folosiți versiunea netedă, dacă este posibil. Altfel trebuie să instalezi `libsecret-1-dev` și `libjsoncpp-dev`.

:::

## Binare

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabil</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/stable/linwood-flow-linux.tar.gz">
        Portabil
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/stable/linwood-flow-linux.deb">
        DEO
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/stable/linwood-flow-linux.AppImage">
        AppImage
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Noptez</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/nightly/linwood-flow-linux.tar.gz">
        Portabil
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/nightly/linwood-flow-linux.deb">
        DEO
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/nightly/linwood-flow-linux.AppImage">
        AppImage
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Citește mai multe despre versiunea nocturnă a fluxului [aici](/nightly).
