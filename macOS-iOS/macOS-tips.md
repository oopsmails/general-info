## Bash profile:

add path
Sample /Users/albert/.bash_profile

```
export PATH="$PATH:/Users/albert/Documents"
export PATH="$PATH:/Users/albert/Documents/albert"
export PATH="$PATH:/Users/albert/Documents/programs"


export JAVA_HOME_8=$(/usr/libexec/java_home -v1.8)
export JAVA_HOME_11=$(/usr/libexec/java_home -v11)
export JAVA_HOME_14=$(/usr/libexec/java_home -v14)

alias java8='export JAVA_HOME=$JAVA_HOME_8'
alias java11='export JAVA_HOME=$JAVA_HOME_11'
alias java14='export JAVA_HOME=$JAVA_HOME_14'

java11
```

## Java location
/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home


## Quick Lock Screen
Control+Command+Q

## How do I change the direction of my mouse on my Mac?
To change the scroll direction for your Mac's trackpad, click the Apple menu → click System Preferences → click Scroll & Zoom → toggle the Natural scroll direction on or off.

## MacOS screen capture

Command-Shift-3: whole screen
Command-Shift-4: area

## How to Fix NET::ERR_CERT_DATE_INVALID Error in Google Chrome?

Time Zone and Date, Time not set properly!


## The Quickest Way to Show/Hide Hidden Files
Since the release of macOS Sierra, when in Finder, it is now possible to use the shortcut:

CMD + SHIFT + .

## Finder

View, show path bar, drag and drop root folder to Favorites

## Terminal:

In Terminal, select something and then within the same Terminal window

paste using Shift-Command-V

or: paste using the middle mouse button

Use: Command-c and Comment-v


## Previous Mojave version: Create a “Copy Path” Service for the Right-Click Menu

http://osxdaily.com/2013/06/19/copy-file-folder-path-mac-os-x/

- Launch Automator and create a new “Service”
- Use the search function to look for “Copy to Clipboard” and drag that into the right side panel of the Service
- Set ‘Service receives selected’ to “files or folders” and ‘in’ to “Finder” as shown in the screen shot below
- Save the Service with a name like “Copy Path”

## Mojave: "Copy file path" command in Finder context menu

All you need to do to copy any items path name directly to the clipboard from anywhere in the file system:

- Navigate to the file or folder you wish to copy the path for Right-click (or Control+Click, or a Two-Finger click on trackpads) on the file or folder in the Mac Finder
- While in the right-click menu, hold down the OPTION key to reveal the “Copy (item name) as Pathname” option, it replaces the standard Copy option Once selected, the file or folders path is now in the clipboard, ready to be pasted anywhere
The copied pathname is always the complete path, it’s not relative.


## Using an Automator App to Create a Blank Text File in Any Folder

https://www.maketecheasier.com/create-blank-text-file-mac/

--> try this
https://apple.stackexchange.com/questions/84309/how-to-create-a-text-file-in-a-folder



## If I created a service using Automator, how can I delete it if I no longer want it?

In the Finder, press ⌘⇧G to Go to Folder.

Type "~/Library/Services"

Find the service you no longer want

Drag it to the Trash

--

==================

## add path
/Users/admin/.bash_profile

/Users/admin/Documents/Albert
/Users/admin/Documents/Albert
/Users/admin/Documents/Albert/github/general-info-master

echo "$PATH"
OR
printf "%s\n" $PATH


## Java
/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home


## Quick Lock Screen
Control+Command+Q


## The Quickest Way to Show/Hide Hidden Files
Since the release of macOS Sierra, when in Finder, it is now possible to use the shortcut:

CMD + SHIFT 

CMD + SHIFT + . // to toggle in Mojave

## Terminal: Copy and Paste

In Terminal, select something and then within the same Terminal window

paste using Shift-Command-V

or: paste using the middle mouse button

Use: Command-c and Comment-v


## Terminal: customerize
macos terminal default window size
https://apple.stackexchange.com/questions/173753/how-can-i-set-the-default-width-height-and-position-of-my-mac-terminal-app

Terminal > Preferences > Profiles


## Create a “Copy Path” Service for the Right-Click Menu

http://osxdaily.com/2013/06/19/copy-file-folder-path-mac-os-x/

- Launch Automator and create a new “Service”
- Use the search function to look for “Copy to Clipboard” and drag that into the right side panel of the Service
- Set ‘Service receives selected’ to “files or folders” and ‘in’ to “Finder” as shown in the screen shot below
- Save the Service with a name like “Copy Path”


## Using an Automator App to Create a Blank Text File in Any Folder

https://www.maketecheasier.com/create-blank-text-file-mac/

--> try this
https://apple.stackexchange.com/questions/84309/how-to-create-a-text-file-in-a-folder



## If I created a service using Automator, how can I delete it if I no longer want it?

In the Finder, press ⌘⇧G to Go to Folder.

Type "~/Library/Services"

Find the service you no longer want

Drag it to the Trash

----------------

===============================

## when npm install, get "xcode-select: error: tool 'xcodebuild' requires Xcode"

Xcode->Preferences->Locations->command line tools

screenshot

Select the option: Xcode 8.x

## macos terminal using zsh not bash

### show shells

cat /etc/shells

### switching

chsh -s /bin/bash

chsh -s /bin/zsh

## How do I install Java on Mac OSX allowing version switching?

### old:
https://stackoverflow.com/questions/52524112/how-do-i-install-java-on-mac-osx-allowing-version-switching

note: These solutions work for various versions of Java including Java 11 and the new Java 12, and for any other previous Java version covered by the listed version managers. This includes alternative JDK's from OpenJDK, Oracle, IBM, Azul, Amazon Correto, Graal and more. Easily work with Java 7, Java 8, Java 9, Java 10, Java 11, Java 12, and even early access Java 13!

You have a few options of how to do the installation as well as manage JDK switching. Installation can be done by Homebrew, SDKMAN, Jabba, or a manual install. Switching can be done by JEnv, SDKMAN, Jabba, or manually by setting JAVA_HOME. All of these are described below.


--> Install manually from OpenJDK download page:
Download OpenJDK for Mac OSX from http://jdk.java.net/

Unarchive the OpenJDK tar, and place the resulting folder (i.e. jdk-12.jdk) into your /Library/Java/JavaVirtualMachines/ folder since this is the standard and expected location of JDK installs. You can also install anywhere you want in reality.


### new:

https://mkyong.com/java/how-to-install-java-on-mac-osx/

Install Homebrew and update it.

$ brew update
1.2 Add adoptopenjdk/openjdk.

$ brew tap adoptopenjdk/openjdk
1.3 Find all available JDK.

$ brew search jdk


brew cask install adoptopenjdk8
brew cask install adoptopenjdk9
brew cask install adoptopenjdk10
brew cask install adoptopenjdk11
brew cask install adoptopenjdk12
brew cask install adoptopenjdk13
This example will install Java 8 and 11 for testing.

$ brew cask install adoptopenjdk8
$ brew cask install adoptopenjdk11
1.5 Where Java is installed? /usr/libexec/java_home -V

$ /usr/libexec/java_home -V

1.6 Test it, by default, Mac takes the highest version.

$ java -version

$ vim ~/.bash_profile
~/.bash_profile
export JAVA_HOME_8=$(/usr/libexec/java_home -v1.8)
export JAVA_HOME_11=$(/usr/libexec/java_home -v11)
export JAVA_HOME_14=$(/usr/libexec/java_home -v14)

```
albert@Alberts-iMac JavaVirtualMachines % /usr/libexec/java_home -V
Matching Java Virtual Machines (3):
    14.0.1, x86_64:	"OpenJDK 14.0.1"	/Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home
    11.0.7, x86_64:	"AdoptOpenJDK 11"	/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
    1.8.0_252, x86_64:	"AdoptOpenJDK 8"	/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
```


### Switching versions manually
The Java executable is a wrapper that will use whatever JDK is configured in JAVA_HOME, so you can change that to also change which JDK is in use.

For example, if you installed or untar'd JDK 12 to /Library/Java/JavaVirtualMachines/jdk-12.jdk if it is the highest version number it should already be the default, if not you could simply set:

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-12.jdk/Contents/Home
And now whatever Java executable is in the path will see this and use the correct JDK.

Using the /usr/libexec/java_home utility as previously described helps you to create aliases or to run commands to change Java versions by identifying the locations of different JDK installations. For example, creating shell aliases in your .profile or .bash_profile to change JAVA_HOME for you:

export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_9_HOME=$(/usr/libexec/java_home -v9)
export JAVA_10_HOME=$(/usr/libexec/java_home -v10)
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
export JAVA_12_HOME=$(/usr/libexec/java_home -v12)

alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java9='export JAVA_HOME=$JAVA_9_HOME'
alias java10='export JAVA_HOME=$JAVA_10_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java12='export JAVA_HOME=$JAVA_12_HOME'

### default to Java 12
java12
Then to change versions, just use the alias.

java8
java -version
java version "1.8.0_144"

Of course, setting JAVA_HOME manually works too!

### macOS, change java jdk at system level

https://stackoverflow.com/questions/21964709/how-to-set-or-change-the-default-java-jdk-version-on-os-x

This answer is an attempt to address: how to control java version system-wide (not just in currently running shell) when several versions of JDK are installed for development purposes on macOS El Capitan or newer (Sierra, High Sierra, Mojave). As far as I can tell, none of the current answers do that (*).

As a developer, I use several JDKs, and I want to switch from one to the other easily. Usually I have the latest stable one for general use, and others for tests. But I don't want the system (e.g. when I start my IDE) to use the latest "early access" version I have for now. I want to control system's default, and that should be latest stable.

The following approach works with Java 7 to 12 at least (early access at the time of this writing), with Oracle JDK or OpenJDK (including builds by AdoptOpenJDK produced after mid-October 2018).

Solution without 3rd party tools:
leave all JDKs at their default location, under /Library/Java/JavaVirtualMachines. The system will pick the highest version by default.
To exclude a JDK from being picked by default, rename its Contents/Info.plist to Info.plist.disabled. That JDK can still be used when $JAVA_HOME points to it, or explicitly referenced in a script or configuration. It will simply be ignored by system's java command.
System launcher will use the JDK with highest version among those that have an Info.plist file.

When working in a shell with alternate JDK, pick your method among existing answers (jenv, or custom aliases/scripts around /usr/libexec/java_home, etc).

## Find eclipse.ini on macOS

Go to "Application", right click on "Eclipse", "Show package content", 

/Applications/Eclipse-neon.app/Contents/Eclipse/eclipse.ini


## Hide and Minimize All Mac Windows with Command + Option + H + M

To minimize the current window, press Command-M. To minimize all windows of the app in focus, press Command-Option-M. Or you can press Command-H which hides the application. Command-H will minimize your apps one by one, but it won't work on the last open one.


## When using java12<lombok.version>1.18.4</lombok.version>
---------------------
https://elm.cangdu.org/v1/captchas

POST
header:Host: elm.cangdu.org
Connection: keep-alive
Content-Length: 2
Accept: application/json
Origin: https://elm.cangdu.org
User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1
Sec-Fetch-Mode: cors
Content-Type:application/json
Sec-Fetch-Site: same-origin
Referer: https://elm.cangdu.org/v1/captchas
Accept-Encoding: gzip, deflate, br
Accept-Language: en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7
Cookie: cap=6202

body: {}
-----------------------
==> macos sleep time
On your Mac, chooseApplemenu > System Preferences, then click Energy Saver.

==> WIFI password,
How to show a Wi-FipasswordonmacOS. Step 1: Type Keychain Access into Spotlight search ( ) at the top-right menu bar. Step 2: In the sidebar, make sure you click onPasswords, then search for the network you want thepasswordfor and double click on it.

==>macbook black dot under icon
Press these three keys together: Option, Command, and Esc (Escape).

-----------------


## windows keyboard on mac

http://osxdaily.com/2018/01/31/use-windows-pc-keyboard-mac-remap-option-command-keys/

Keyboard:

Click the dropdown next to “OPTION Key” and select “Command”
Click the dropdown next to “COMMAND Key” and select “Option”

Then, use Alt+Shift+., to toggle Show/Hide Hidden Files

## Find your IP Address via the Mac OS X Terminal

ifconfig |grep inet

## file sharing:

Choose Apple menu > System Preferences, then click Sharing.

Select the File Sharing checkbox.

smb://192.168.62.128
afp://192.168.62.128

In Finder menu, GO, Connect to server, 
smb://192.168.0.16

## in virtual box

Settings, login items, +, sharing, or drag and drop it in as login items


## 

-------------------
google map api angular example

Google api key: oopsapp: AIzaSyBg3j3nlyL7j3O3Jv8FHS6xUSLoHLOK-v4
https://medium.com/@jkeung/integrating-google-maps-api-w-angular-7-e7672396ce2d


















