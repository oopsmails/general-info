

https://stackoverflow.com/questions/61875699/how-to-install-java-on-a-mac


https://docs.oracle.com/en/java/javase/11/install/installation-jdk-macos.html#GUID-C5F0BF25-3487-4F33-9275-7000C8E1C58C



Determining the Default JDK Version on macOS
When starting a Java application through the command line, the system uses the default JDK.

There can be multiple JDKs installed on the macOS system.
You can determine which version of the JDK is the default by entering java -version in a Terminal window. If the installed version is 11 Interim 0, Update 0, and Patch 0, then you see a string that includes the text 11. For example:

Copy$  java -version
java version "11"
Java(TM) SE Runtime Environment (build 11)
Java HotSpot(TM) 64-Bit Server VM (build 23.2-b04, mixed mode)
To run a different version of Java, either specify the full path, or use the java_home tool. For example:

$ /usr/libexec/java_home -v 11 --exec javac -version

Installing the JDK on macOS
To install the JDK on macOS:
Download the JDK .dmg file, jdk-11.interim.update.patch-macosx-x64.dmg.
Before the file can be downloaded, you must accept the license agreement.

From either the browser Downloads window or from the file browser, double-click the .dmg file to start it.
A Finder window appears that contains an icon of an open box and the name of the .pkg file.
Double-click the JDK 11.pkg icon to start the installation application.
The installation application displays the Introduction window.
Click Continue.
The Installation Type window appears.
Click Install.
A window appears that displays the message: Installer is trying to install new software. Enter your password to allow this.
Enter the Administrator user name and password and click Install Software.
The software is installed and a confirmation window is displayed.
After the software is installed, you can delete the .dmg file if you want to save disk space.
Uninstalling the JDK on macOS
To uninstall the JDK on macOS:
You must have Administrator privileges.
Note:Do not attempt to uninstall Java by removing the Java tools from /usr/bin. This directory is part of the system software and any changes will be reset by Apple the next time that you perform an update of the OS.
Go to /Library/Java/JavaVirtualMachines.
Remove the directory whose name matches the following format by executing the rm command as a root user or by using the sudo tool:
/Library/Java/JavaVirtualMachines/jdk-interim.update.patch.jdk
For example, to uninstall 11 Interim 0 Update 0 Patch 0:

$ rm -rf jdk-11.jdk

Installation FAQ on macOS Platform




