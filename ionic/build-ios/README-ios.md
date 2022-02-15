
# Build for iOS

Open the App Store on your Mac and search for “Xcode“. This is the native development environment for iOS developers and we can use it to try out our app on iOS devices.

Don’t worry, you don’t really have to learn how it works, a few buttons are enough to get us started there.

We also need 2 additional packages in order to build the app from the command line, so go ahead and install them now:

```
npm install -g ios-sim
npm install -g ios-deploy
```

After installing Xcode (which is free) you can run directly inside your Ionic project the command to build everything into a native project:

```
ionic cordova platform add ios
ionic cordova build ios
```

The first command needs to be called only once for a project, and it sets up the iOS platform for the project.

This might take a few moments and once done, you will find that inside the platforms folder you now got a iOS project.

To open the project in Xcode double click the ionicStarWarsApp.xcodeproj, which will bring up Xcode. If you click on the project on the left side the general view opens which should look like this:

ionic-crash-course-xcode


At the top left next to the run button you now see the name of your project and the currently selected simulator. You can now hit the run button to deploy your app to an iOS simulator and get the feeling of a native app!

If you want to deploy your app to your iPhone, you can connect it through USB and it will appear at the top of that list above the simulators.

Congratulations, you’ve now started, built and run your Ionic app on a native iOS device!


ionic cordova build ios


- Error: Source path does not exist: resources/ios/icon/icon-1024.png

npm i -g cordova-res

ionic cordova resources ios

ionic cordova build ios --verbose

- Error: Source path does not exist: resources/ios/icon/icon-small.png

ionic cordova resources -f

ionic cordova build ios --verbose


The current version of ionic resources function does not generate all versions, but some icons still exist in config.xml file from old commands.

You can remove all *<icon and <splash* from config.xml (backup file first) then
ionic cordova resources -f
the command will recreate icons and update config.xml with currently used icon/splash paths.

- Error in *ionic lib*: core.mjs:6484 ERROR TypeError: Cannot read properties of undefined (reading 'then')

Need to run in Emulator, undefined is from browser has no native plugins.

- Error: EmailComposer.getPlugin().getClients() is not a function.

ionic cordova plugin add cordova-plugin-email-composer

- Error: 4 duplicate symbols for architecture x86_64

This is because conflicts between *"cordova-plugin-email"* and *"cordova-plugin-email-composer"*!

*"cordova-plugin-email-composer"* should be used.

cordova plugin remove cordova-plugin-email --save

delete platform/ios

ionic cordova platform add ios

ionic cordova build ios --verbose

Then, re-run in xcode.

- Error: alert('email native client is NOT available!!!');

20220214: stopped here on iOS Emulator, maybe try on real device later. But, at least, native API method call is OK, e.g, 

```
this.emailComposer.hasClient().then((available: boolean) => {
```

- After each change

ionic cordova build ios and re-run in xcode.




