====> add path
/Users/admin/.bash_profile

/Users/admin/Documents/Albert
/Users/admin/Documents/Albert
/Users/admin/Documents/Albert/github/general-info-master

echo "$PATH"
OR
printf "%s\n" $PATH


====> Java
/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home


====> Quick Lock Screen
Control+Command+Q


====> MacOS screen capture

A.    Entire screen:

To capture the entire screen, press Command-Shift-3. The screen shot will be automatically saved as a PNG file on your desktop with the filename starting with “Picture” followed by a number, example Picture 1, Picture 2, and so on.
To copy the entire screen, press Command-Control-Shift-3. The screen shot will be placed on your clipboard for you to paste into another program like PowerPoint, Word, Photoshop, etc.

B.     Portion of the screen:

To capture a portion of the screen, press Command-Shift-4. A cross-hair cursor will appear and you can click and drag to select the area you wish to capture. When you release the mouse button, the screen shot will be automatically saved as a PNG file on your desktop following the same naming convention as explained on the first tip above.
To copy a portion of the screen to the clipboard, press Command-Control-Shift-4.  A cross-hair cursor will appear and you can click and drag to select the area you wish to capture. When you release the mouse button, you can paste the screen shot to another application.

C.    Specific application window:

To capture a specific application window, press and hold Command-Shift-4 then tap on the Spacebar. The cursor will change to a camera, and you can move it around the screen. As you move the cursor over an application window, the window will be highlighted. The entire window does not need to be visible for you to capture it. When you have the cursor over a window you want to capture, just click the mouse button and the screen shot will be saved as a PNG file on your desktop.
To copy a specific application window, press and hold Command-Control-Shift-4 then tap on the Spacebar. The cursor will change to a camera, which you can move around the screen. As you move the cursor over an application window, the window will be highlighted. The entire window does not need to be visible for you to capture it. When you have the cursor over a window you want to capture, just click the mouse button and you can paste the screen shot into another application.


====> The Quickest Way to Show/Hide Hidden Files
Since the release of macOS Sierra, when in Finder, it is now possible to use the shortcut:

CMD + SHIFT 

====> Terminal:

In Terminal, select something and then within the same Terminal window

paste using Shift-Command-V

or: paste using the middle mouse button


Use: Command-c and Comment-v


====> Previous Mojave version: Create a “Copy Path” Service for the Right-Click Menu

http://osxdaily.com/2013/06/19/copy-file-folder-path-mac-os-x/

- Launch Automator and create a new “Service”
- Use the search function to look for “Copy to Clipboard” and drag that into the right side panel of the Service
- Set ‘Service receives selected’ to “files or folders” and ‘in’ to “Finder” as shown in the screen shot below
- Save the Service with a name like “Copy Path”

====> Mojave: "Copy file path" command in Finder context menu

All you need to do to copy any items path name directly to the clipboard from anywhere in the file system:

- Navigate to the file or folder you wish to copy the path for Right-click (or Control+Click, or a Two-Finger click on trackpads) on the file or folder in the Mac Finder
- While in the right-click menu, hold down the OPTION key to reveal the “Copy (item name) as Pathname” option, it replaces the standard Copy option Once selected, the file or folders path is now in the clipboard, ready to be pasted anywhere
The copied pathname is always the complete path, it’s not relative.


====> Using an Automator App to Create a Blank Text File in Any Folder

https://www.maketecheasier.com/create-blank-text-file-mac/

--> try this
https://apple.stackexchange.com/questions/84309/how-to-create-a-text-file-in-a-folder





====> If I created a service using Automator, how can I delete it if I no longer want it?

In the Finder, press ⌘⇧G to Go to Folder.

Type "~/Library/Services"

Find the service you no longer want

Drag it to the Trash

--

==================

====> add path
/Users/admin/.bash_profile

/Users/admin/Documents/Albert
/Users/admin/Documents/Albert
/Users/admin/Documents/Albert/github/general-info-master

echo "$PATH"
OR
printf "%s\n" $PATH


====> Java
/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home


====> Quick Lock Screen
Control+Command+Q


====> MacOS screen capture

A.    Entire screen:

To capture the entire screen, press Command-Shift-3. The screen shot will be automatically saved as a PNG file on your desktop with the filename starting with “Picture” followed by a number, example Picture 1, Picture 2, and so on.
To copy the entire screen, press Command-Control-Shift-3. The screen shot will be placed on your clipboard for you to paste into another program like PowerPoint, Word, Photoshop, etc.

B.     Portion of the screen:

To capture a portion of the screen, press Command-Shift-4. A cross-hair cursor will appear and you can click and drag to select the area you wish to capture. When you release the mouse button, the screen shot will be automatically saved as a PNG file on your desktop following the same naming convention as explained on the first tip above.
To copy a portion of the screen to the clipboard, press Command-Control-Shift-4.  A cross-hair cursor will appear and you can click and drag to select the area you wish to capture. When you release the mouse button, you can paste the screen shot to another application.

C.    Specific application window:

To capture a specific application window, press and hold Command-Shift-4 then tap on the Spacebar. The cursor will change to a camera, and you can move it around the screen. As you move the cursor over an application window, the window will be highlighted. The entire window does not need to be visible for you to capture it. When you have the cursor over a window you want to capture, just click the mouse button and the screen shot will be saved as a PNG file on your desktop.
To copy a specific application window, press and hold Command-Control-Shift-4 then tap on the Spacebar. The cursor will change to a camera, which you can move around the screen. As you move the cursor over an application window, the window will be highlighted. The entire window does not need to be visible for you to capture it. When you have the cursor over a window you want to capture, just click the mouse button and you can paste the screen shot into another application.


====> The Quickest Way to Show/Hide Hidden Files
Since the release of macOS Sierra, when in Finder, it is now possible to use the shortcut:

CMD + SHIFT 

CMD + SHIFT + . // to toggle in Mojave

====> Terminal: Copy and Paste

In Terminal, select something and then within the same Terminal window

paste using Shift-Command-V

or: paste using the middle mouse button


Use: Command-c and Comment-v
====> Terminal: customerize
macos terminal default window size
https://apple.stackexchange.com/questions/173753/how-can-i-set-the-default-width-height-and-position-of-my-mac-terminal-app


Set your window how you would like it,Go to Window > Save Windows as Group... Enter a name next to Save As:Check "Use window group when Terminal starts"Click Save
One way to do it isSet your window how you would like it,Go to Window > Save Windows as Group... Enter a name next to Save As:Check "Use window group when Terminal starts"Click SaveHowever, after you have launched Terminal, if you chose Terminal > New Window you will still have to resize the window. This is most useful if you want to have multiple terminal windows open at launch.If you go to Terminal > Preferences > Profiles you can create a (or edit an existing) profile for a terminal window by column and row size which is available at the end of the terminal window title bar (Your screenshot shows a window 80 columns wide and 24 rows tall)You can then set that profile to the default by pushing the default button (if the default button is ghosted out that group is already the default): 
====> 


====> Create a “Copy Path” Service for the Right-Click Menu

http://osxdaily.com/2013/06/19/copy-file-folder-path-mac-os-x/

- Launch Automator and create a new “Service”
- Use the search function to look for “Copy to Clipboard” and drag that into the right side panel of the Service
- Set ‘Service receives selected’ to “files or folders” and ‘in’ to “Finder” as shown in the screen shot below
- Save the Service with a name like “Copy Path”


====> Using an Automator App to Create a Blank Text File in Any Folder

https://www.maketecheasier.com/create-blank-text-file-mac/

--> try this
https://apple.stackexchange.com/questions/84309/how-to-create-a-text-file-in-a-folder





====> If I created a service using Automator, how can I delete it if I no longer want it?

In the Finder, press ⌘⇧G to Go to Folder.

Type "~/Library/Services"

Find the service you no longer want

Drag it to the Trash

----------------

===============================

====> when npm install, get "xcode-select: error: tool 'xcodebuild' requires Xcode"

Xcode->Preferences->Locations->command line tools

screenshot

Select the option: Xcode 8.x


====> How do I install Java on Mac OSX allowing version switching?

https://stackoverflow.com/questions/52524112/how-do-i-install-java-on-mac-osx-allowing-version-switching

note: These solutions work for various versions of Java including Java 11 and the new Java 12, and for any other previous Java version covered by the listed version managers. This includes alternative JDK's from OpenJDK, Oracle, IBM, Azul, Amazon Correto, Graal and more. Easily work with Java 7, Java 8, Java 9, Java 10, Java 11, Java 12, and even early access Java 13!

You have a few options of how to do the installation as well as manage JDK switching. Installation can be done by Homebrew, SDKMAN, Jabba, or a manual install. Switching can be done by JEnv, SDKMAN, Jabba, or manually by setting JAVA_HOME. All of these are described below.


--> Install manually from OpenJDK download page:
Download OpenJDK for Mac OSX from http://jdk.java.net/

Unarchive the OpenJDK tar, and place the resulting folder (i.e. jdk-12.jdk) into your /Library/Java/JavaVirtualMachines/ folder since this is the standard and expected location of JDK installs. You can also install anywhere you want in reality.


--> Switching versions manually
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

# default to Java 12
java12
Then to change versions, just use the alias.

java8
java -version
java version "1.8.0_144"

Of course, setting JAVA_HOME manually works too!


====> Hide and Minimize All Mac Windows with Command + Option + H + M

To minimize the current window, press Command-M. To minimize all windows of the app in focus, press Command-Option-M. Or you can press Command-H which hides the application. Command-H will minimize your apps one by one, but it won't work on the last open one.


---------------------
used tar.gz
----
export PATH=$PATH:/Users/admin/Documents/Albert
export PATH=$PATH:/Users/admin/Documents/programs
alias xcode="open -a Xcode"

export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_9_HOME=$(/usr/libexec/java_home -v9)
export JAVA_12_HOME=$(/usr/libexec/java_home -v12)

alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java9='export JAVA_HOME=$JAVA_9_HOME'
alias java12='export JAVA_HOME=$JAVA_12_HOME'

# default to Java 8
java8

--------------------
--> When using java12<lombok.version>1.18.4</lombok.version>
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
On your Mac, choose Apple menu > System Preferences, then click Energy Saver. 

==> WIFI password,
How to show a Wi-Fi password on macOS. Step 1: Type Keychain Access into Spotlight search ( ) at the top-right menu bar. Step 2: In the sidebar, make sure you click on Passwords, then search for the network you want the password for and double click on it.

==> macbook black dot under icon
Press these three keys together: Option, Command, and Esc (Escape).

-----------------

====> Terminal: customerize
macos terminal default window size
https://apple.stackexchange.com/questions/173753/how-can-i-set-the-default-width-height-and-position-of-my-mac-terminal-app


Set your window how you would like it,Go to Window > Save Windows as Group... Enter a name next to Save As:Check "Use window group when Terminal starts"Click Save
One way to do it isSet your window how you would like it,Go to Window > Save Windows as Group... 

Enter a name next to Save As:Check "Use window group when Terminal starts"Click SaveHowever, after you have launched Terminal, if you chose Terminal > New Window you will still have to resize the window. This is most useful if you want to have multiple terminal windows open at launch.If you go to Terminal > Preferences > Profiles you can create a (or edit an existing) profile for a terminal window by column and row size which is available at the end of the terminal window title bar (Your screenshot shows a window 80 columns wide and 24 rows tall)You can then set that profile to the default by pushing the default button (if the default button is ghosted out that group is already the default): 


====> windows keyboard on mac

http://osxdaily.com/2018/01/31/use-windows-pc-keyboard-mac-remap-option-command-keys/

Keyboard:

Click the dropdown next to “OPTION Key” and select “Command”
Click the dropdown next to “COMMAND Key” and select “Option”

Then, use Alt+Shift+., to toggle Show/Hide Hidden Files

====> Find your IP Address via the Mac OS X Terminal

ifconfig |grep inet

====> file sharing:

Choose Apple menu > System Preferences, then click Sharing.

Select the File Sharing checkbox.

smb://192.168.62.128
afp://192.168.62.128

====> 



-------------------
google map api angular example

Google api key: oopsapp: AIzaSyBg3j3nlyL7j3O3Jv8FHS6xUSLoHLOK-v4
https://medium.com/@jkeung/integrating-google-maps-api-w-angular-7-e7672396ce2d


















