
# MacOS Install Java
## 20220211:

### Install java 1.8 and java 11

```
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install OpenJDK

brew search java

brew install openjdk


Verify it's installed:

$(brew --prefix openjdk)/bin/java --version
Verify it's for the arm64 hardware:

file $(brew --prefix openjdk)/bin/java     
# /opt/homebrew/opt/openjdk/bin/java: Mach-O 64-bit executable arm64


brew install openjdk@11

(brew --prefix openjdk@11)/bin/java

```

This also works for java 11 without any problem *brew install openjdk@11* and file $*(brew --prefix openjdk@11)/bin/java* - Apple MacBook Pro 2021 - M1 Pro (10 Cores) - using homebrew is for me the preferable option over other approaches 

```
brew install openjdk@8

For the system Java wrappers to find this JDK, symlink it with
  sudo ln -sfn /usr/local/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk

openjdk@8 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.

If you need to have openjdk@8 first in your PATH, run:
  echo 'export PATH="/usr/local/opt/openjdk@8/bin:$PATH"' >> ~/.zshrc

For compilers to find openjdk@8 you may need to set:
  export CPPFLAGS="-I/usr/local/opt/openjdk@8/include"

==> Summary
🍺  /usr/local/Cellar/openjdk@8/1.8.0+312: 782 files, 193MB
==> Running `brew cleanup openjdk@8`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
==> Caveats
==> openjdk@8
For the system Java wrappers to find this JDK, symlink it with
  sudo ln -sfn /usr/local/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk

openjdk@8 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.

If you need to have openjdk@8 first in your PATH, run:
  echo 'export PATH="/usr/local/opt/openjdk@8/bin:$PATH"' >> ~/.zshrc
```


```
brew install openjdk@11

For the system Java wrappers to find this JDK, symlink it with
  sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk

openjdk@11 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.

If you need to have openjdk@11 first in your PATH, run:
  echo 'export PATH="/usr/local/opt/openjdk@11/bin:$PATH"' >> ~/.zshrc

```

### Switch around

```
- /usr/libexec/java_home -V

albert@Alberts-iMac Java % /usr/libexec/java_home -V
Matching Java Virtual Machines (2):
    11.0.12 (x86_64) "Homebrew" - "OpenJDK 11.0.12" /usr/local/Cellar/openjdk@11/11.0.12/libexec/openjdk.jdk/Contents/Home
    1.8.0_312 (x86_64) "Homebrew" - "OpenJDK 8" /usr/local/Cellar/openjdk@8/1.8.0+312/libexec/openjdk.jdk/Contents/Home
/usr/local/Cellar/openjdk@11/11.0.12/libexec/openjdk.jdk/Contents/Home

- ls -lsa /Library/Java/JavaVirtualMachines

albert@Alberts-iMac Java % ls -lsa /Library/Java/JavaVirtualMachines
total 0
0 drwxr-xr-x  4 root  wheel  128 Feb 11 11:46 .
0 drwxr-xr-x  4 root  wheel  128 Jan  1  2020 ..
0 lrwxr-xr-x  1 root  wheel   45 Feb 11 11:46 openjdk-11.jdk -> /usr/local/opt/openjdk@11/libexec/openjdk.jdk
0 lrwxr-xr-x  1 root  wheel   44 Feb 11 11:33 openjdk-8.jdk -> /usr/local/opt/openjdk@8/libexec/openjdk.jdk

--- /usr/libexec/java_home -v1.8

source ~/.zshrc

```

- .zshrc function for switching around

```

export PATH="$PATH:/Users/albert/Documents"
export PATH="$PATH:/Users/albert/Documents/programs"

alias arun=". cdto.sh "

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

jdk() {
      version=$1
      unset JAVA_HOME;
      export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
      java -version
}
```




## Before 2022

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




