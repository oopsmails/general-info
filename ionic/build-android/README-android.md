
# Build for Android
I guess the majority of you is more interested in Android (also due to the absence of a Mac).

For Android, it’s a good idea to download the official environment Android Studio. This will help you to install the Android SDK which is needed now.

After installing Android Studio open it and inside the Wizard click Configure and pick SDK Manager.

This will bring you to a view where you can install an Android SDK – simply pick the newest one and install what you need!

ionic-crash-course-android-sdk

Now we can add the Android platform to our project just like we did before for iOS, so go to your command line and run:

```
ionic cordova platform add android
ionic cordova build android
```

This results in a new Android project inside the platforms folder. You can now either go ahead and import this project into Android Studio or directly install it to your Android device if it’s connected with USB.

Ionic already told us the path to the generated APK after the build command.

If you have followed the course so far, this should be:

```
/platforms/android/app/build/outputs/apk/debug/app-debug.apk
```

You can now use the Android Debug Bridge (ADB) to install it by running:

```
adb install platforms/android/app/build/outputs/apk/debug/app-debug.apk
```

This will install the App on your device and you got your first Ionic app in your hands!