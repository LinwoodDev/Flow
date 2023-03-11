FLUTTER_VERSION=$(cat ../FLUTTER_VERSION)
if [ "$FLOW_NIGHTLY" = "true" ];
then 
    cp -r web_nightly/** web
fi
if cd flutter
then 
    git pull
    cd ..
else
    git clone https://github.com/flutter/flutter.git -b $FLUTTER_VERSION
fi
flutter/bin/flutter config --enable-web
if [ "$FLOW_NIGHTLY" = "true" ]
then
    flutter/bin/flutter build web --release --web-renderer canvaskit --dart-define=FLUTTER_WEB_USE_SKIA=true --dart-define=FLUTTER_WEB_CANVASKIT_URL=/canvaskit/ --dart-define=flavor=nightly
else
    flutter/bin/flutter build web --release --web-renderer canvaskit --dart-define=FLUTTER_WEB_USE_SKIA=true --dart-define=FLUTTER_WEB_CANVASKIT_URL=/canvaskit/ --dart-define=flavor=production
fi
