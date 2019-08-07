
# Mac OS, on VMWare Player

## Git on Mac

- Xcode is with Apple Git


- Download git for Mac, .dmg file, drag into Applications, open with Installer!

- Open a new Terminal, git clone ...

- git config --global core.autocrlf true

## install Nodejs

### mac npm install angular cli permission denied

- sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

https://stackoverflow.com/questions/48255269/cant-install-angular-cli-on-mac

i faced similar issue while installing angular-cli on Mac Mojave.

Correct installation steps are:

Install npm using package manager.
above step sets the directory owner of /usr/local/lib/node_modules/ to root.
execute below command to set the owner to your user:
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

npm install -g @angular/cli (avoid using sudo)


- Logs:

Alberts-Mac:/ albert$ sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
Password:
Alberts-Mac:/ albert$ npm install -g @angular/cli@7.2.2


### ionic ocoapods is not installed when: ionic capacitor add ios

https://stackoverflow.com/questions/49347889/on-mac-system-cocoapods-was-not-found-while-doing-ionic-add-or-remove-pho

- You cannot run CocoaPods as root.

To install push you must first install cocoapods.

Follow these steps on your terminal in the Ionic project directory.

First remove what you tried to install

ionic plugin remove phonegap-plugin-push
Next install cocoapods

sudo gem install cocoapods
Then you need to sync the cocoapods repo

pod setup # (run as normal user not as root)
This may take a while

Finally install push

ionic plugin add phonegap-plugin-push --variable SENDER_ID="XXXXXXX"

- ?? 
ionic plugin add phonegap-plugin-push --variable SENDER_ID="oopsmails@gmail.com"

```
Alberts-Mac:angular-ionic-recipe albert$ 
Alberts-Mac:angular-ionic-recipe albert$ ionic plugin add phonegap-plugin-push --variable SENDER_ID="oopsmails@gmail.com"
[ERROR] Unable to find command: plugin add phonegap-plugin-push
        SENDER_ID=oopsmails@gmail.com
```


Then change ownership of folders required

chmod -R 777 /usr/etc/
So basically you come out of sudo -i then run as normal osx user

### xcode failed to create provisioning profile no devices registered

- can configure a simulator device and just click Run!

At the top of the Xcode window, from left to right, after the Run and the Stop buttons, there is another button which displays the tooltip "Set the active scheme" when you hover the mouse over it.

This button lets you choose a simulator. But once your device is plugged in it also let you select that device. Once you select your device, the problem disappears.

Note to those using Xcode to run code developed for Google's Flutter: You probably must also select Product > Run in Xcode, before you are able to go the device to trust the certificate, under the device's General > Device Management.



