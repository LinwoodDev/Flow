---
title: "Selfhosting"
sidebar_position: 5
---

![Σταθερή έκδοση έκδοση](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Νυχτερινή έκδοση έκδοσης](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2FFlow%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Είναι πολύ εύκολο να φιλοξενήσει τη δική σας ροή web server.

## Απλός διακομιστής

Εγκαταστήστε το flutter και δημιουργήστε την εφαρμογή χρησιμοποιώντας:

```bash
cd app
flutter pub get
flutter build web
```

Όλα τα αρχεία βρίσκονται στον κατάλογο `app/build/web`.

## Προσάρτηση

Κλωνοποιήστε το αποθετήριο και δημιουργήστε το `Dockerfile` χρησιμοποιώντας: `docker build -t linwood-flow`. Ξεκινήστε το διακομιστή χρησιμοποιώντας: `docker τρέχει -p 8080:8080 -d linwood-flow`.
