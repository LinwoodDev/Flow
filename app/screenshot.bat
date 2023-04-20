flutter build apk --flavor production --debug
cd android
./gradlew app:assembleAndroidTest
bundle exec fastlane screengrab