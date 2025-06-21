---
title: "Costruisci il tuo"
---

1. Installare git e flutter (beta)
2. Clona il repository
3. Vai alla directory dell'app
4. Utilizzare lo strumento flutter per compilare l'applicazione
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
      after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. I file compilati sono nella directory di compilazione
