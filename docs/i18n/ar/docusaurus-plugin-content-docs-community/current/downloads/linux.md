---
title: "Linux"
sidebar_position: 3
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.tsx';
```

![إصدار الإصدار المستقر](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![إصدار الإصدار الليلي](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

::note

الرجاء استخدام إصدار الفلاتر إن أمكن. وإلا تحتاج إلى تثبيت `libsecret-1-dev` و `libjsoncpp-dev`.

:::

## ثنائيات

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">اسطبل</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/stable/linwood-flow-linux.tar.gz">
        محمول
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/stable/linwood-flow-linux.deb">
        ديب
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
  <button className="button button--outline button--danger button--lg">ليلي</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/nightly/linwood-flow-linux.tar.gz">
        محمول
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/Flow/releases/download/nightly/linwood-flow-linux.deb">
        ديب
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

اقرأ المزيد عن الإصدار الليلي من التدفق [هنا](/nightly).
