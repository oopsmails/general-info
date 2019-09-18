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

--