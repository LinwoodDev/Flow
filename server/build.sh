cd ../app
flutter build web
cd ../server
cp ../app/build/web/* static -r
echo "{\"servers\": {\"default\": {\"url\": \"/\"}}}" > static/assets/data/config.json
dart_frog build