
# Ionic Build and Debugging: Android and iOS

## Build Android

ionic build --prod

ionic capacitor add android
- Error: Is Capacitor installed?

npm install @capacitor/core
npm install @capacitor/cli --save-dev

ionic capacitor add android

ionic capacitor copy android

cd android
./gradlew assembleDebug

- Error: > Could not read script '/home/albert/Documents/dev/ionic/ionic-loginsignup/film/android/capacitor.settings.gradle' as it does not exist

Fixed by: ionic capacitor sync android

- apk location
/home/albert/Documents/dev/ionic/ionic-loginsignup/film/android/app/build/outputs/apk/debug

- install on phone

My Note: Copy the apk and install. If cannot install, one reason could be appId, defined in *capacitor.config.json*. Another reason, might uninstll old version, sometimes, need restart the phone!

## Build iOS

ionic build --prod

npm i @ionic/cli???


### Error: css-loader error: Invalid version: "15.2-15.3"

- https://github.com/angular/angular-cli/issues/22606

```
npx browserslist

error from following: 
safari 15.2-15.3

```

- change *.browserslistrc* file at root level, final like following,

```
last 1 Chrome version
last 1 Firefox version
last 2 Edge major versions
last 2 Safari major versions
last 2 iOS major versions
Firefox ESR
not IE 11 # Angular supports IE 11 only as an opt-in. To opt-in, remove the 'not' prefix on this line.
not dead
# not IE 9-11
# not ios_saf 15.2-15.3
not safari 15.2-15.3

```

Following commands for executing Xcode build, watch the video tutorial you will understand more.
```
ionic capacitor add ios
ionic capacitor open ios <--------------- this will open xcode and then we can click *run*
```


### Other Errors On macOS

```
npm install -g ionic

ionic build --prod

albert@Alberts-iMac apple % ionic capacitor add ios
> capacitor add ios
[error] Could not find the ios platform.
        You must install it in your project first, e.g. w/ npm install @capacitor/ios

npm install @capacitor/ios

[error] CocoaPods is not installed.

sudo gem uninstall cocoapods && sudo gem install cocoapods

ionic capacitor open ios

- error: springboard quit unexpectedly

cd "C:\Program Files\Oracle\VirtualBox\"
VBoxManage setextradata "MacOS" VBoxInternal/CPUM/IsaExts/AVX 0
VBoxManage setextradata "MacOS" VBoxInternal/CPUM/IsaExts/AVX2 0

```

### cocoapods

- This is the simplest

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install cocoapods

- Through gem

1. First open your terminal

2. Then update your gem file with command

sudo gem install -n /usr/local/bin cocoapods
3. Then give your project path

cd /your project path
4. Touch the podifle

touch podfile
5. Open your podfile

open -e podfile
6. It will open a podfile like a text edit. Then set your target. For example if you want to set up Google maps then your podfile should be like

use_frameworks!
target 'yourProjectName' do
    pod 'GoogleMaps'
end
7. Then install the pod

pod install


## Debug ionic app in android studio

- Run the app in Android Studio
- Open the Chrome browser and navigate to the URL chrome://inspect/#devices. Your connected Android device should show up in the list of Remote Targets.
- Click "inspect" link under the device


## Debug ionic app in xcode
- Ref:

https://ionicframework.com/docs/troubleshooting/debugging

iOS and Safari​

Safari can be used to debug an Ionic app on a connected iOS device or iOS simulator.

First, on the iOS device, enable Web Inspector from Settings > Safari > Advanced. ???? may be diff from devices and emulator

Next, open Safari on a Mac then enable Show Develop menu in menu bar under Safari > Preferences > Advanced.

Run the iOS simulator or connect your iOS device to your Mac, then run the Ionic app that you want to debug.

Within Safari, select Develop in the toolbar. In the dropdown menu options, you should see the name of your device and app. Hover over the app name and click on localhost. This will open a new window with the Safari Developer Tools - use them to inspect and debug the Ionic app running on your device.

To Be Dev

## Other

### If Android Studio, Device Manager is not opening

Go to Project Structure, most likely, there is no SDK configured!

- if still cannot open Device Manager

I still have the same problem with the Bumblebee version, but for now you can use the "Search Everywhere"(you can access "Search Everywhere" by pressing double shift) and type in "Virtual Device Manager" then it will works. This is a temporary solution for now.

- Android Studio, android studio android app no module

First of all, use AS to open *android* folder, e.g, /home/albert/Documents/dev/ionic/ionic-loginsignup/apple/android
Second, make sure, file *build.gradle* is in root folder
If still not showing, then, File, Sync Project with Gradle Files ...
Now, the app should be able to be run on Emulator.


