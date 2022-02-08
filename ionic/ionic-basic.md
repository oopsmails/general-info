
# Ionic and Capacitor

## How to build an Android APK file without using Android Studio in a Capacitor project?

- Ref:

https://forum.ionicframework.com/t/how-to-build-an-android-apk-file-without-using-android-studio-in-a-capacitor-project/177814

### This will open Android Studio

```
"ios": "sudo ionic build && npx cap sync ios && npx cap open ios", 
"android": "sudo ionic build && npx cap sync android && npx cap open android",

```

### This is actually WORKING!

- for dev:
You need to add android first:

ionic capacitor add android 

ionic capacitor copy android && cd android && ./gradlew assembleDebug && cd ..

Then your apk will be at:

android/app/build/outputs/apk/debug/app-debug.apk
If you want to run on device directly from command line:

ionic capacitor copy android && cd android && ./gradlew assembleDebug && ./gradlew installDebug && cd ..

- Here is how to production build for Android:

cd android && 
./gradlew assembleRelease && 
cd app/build/outputs/apk/release &&
jarsigner -keystore YOUR_KEYSTORE_PATH -storepass YOUR_KEYSTORE_PASS app-release-unsigned.apk YOUR_KEYSTORE_ALIAS &&
zipalign 4 app-release-unsigned.apk app-release.apk

This will generate app-release.apk which should be good to go the play store (see android/app/build/outputs/apk/release folder).

https://docs.oracle.com/en/java/javase/14/docs/specs/man/jarsigner.html

You can find your keystore alias by running 

keytool -v -list -keystore YOUR_KEYSTORE_PATH

- Just a trick to know all the targets -

cd android 
gradlew app:tasks --all

This will out you all the tasks which can be called by gradlew without opening android studio.

Example for building app bundle

./gradlew bundleRelease



