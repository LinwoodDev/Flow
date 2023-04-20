cd ../app
flutter build web
cd ../server
cp ../app/build/web/* static
echo "{\"servers\": {\"default\": {\"url\": \"/\"}}}" > static/assets/data/config.json
dart_frog build