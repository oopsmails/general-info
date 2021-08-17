
# Ubuntu

## General

- hotkey, right ctrl
- hotkey + c, switch displaying between Full mode and Scaled mode.
- Right Control + Home (by default), show vb menu.
- Full mode, can select show vb menu bar.

- root
    - During boot, press and hold Shift (for BIOS) or ESC (for UEFI). In my case, it is Shift.
    - Start with Recovery mode, then root terminal, run *passwd* to change root password


## Problem and Fix

### Resolution cannot keep after logout or restart

- Make sure VirtualBox Guest Additions is installed
- Switch around Full screen and make sure Auto-resize guest display is checked.

### ubuntu show full path in address bar

gsettings set org.gnome.nautilus.preferences always-use-location-entry true

- off,

gsettings set org.gnome.nautilus.preferences always-use-location-entry false

## Install

### Chorme

- download first
- sudo apt install ./google-chrome-stable_current_amd64.deb
- keyring,

rm ~/.local/share/keyrings/login.keyring

Now open Chrome, if it asks you for your password, do not enter one choose Continue each time and ignore any warning.

- if certificate error or connect not secure ...

run `google-chrome --ignore-certificates-error`

### Terminal

open the terminal, select Edit->Profile Preferences -> General tab and change the values for columns and rows after where it says Initial terminal size: 138x35.

### Shared Folder

- Need to insert Guest Additional CD, then install it. Otherwise, there is no content
c:\sharing
sharing
/home/albert/Documents/sharing

### vs code

- download and installed
- Sync-ed using Github

### bash profile, Terminal, .profile file is NOT used in Elementary OS, should be $HOME/.bashrc

PATH="$HOME/Documents:$PATH"
PATH="$HOME/Documents/sharing:$PATH"
PATH="$HOME/Documents/programs:$PATH"

### java

- install openjdk, 

```
sudo apt update

sudo apt install default-jdk # This will install OpenJDK 11

sudo apt install openjdk-8-jdk

sudo apt install openjdk-14-jdk


sudo update-alternatives --config java # This can switch around versions


  0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      auto mode
  1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      manual mode
* 2            /usr/lib/jvm/java-14-oracle/bin/java             1091      manual mode
  3            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode


```

sudo apt remove openjdk-14-jdk

- add to bash profile

export JAVA_HOME_8=$(/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -v1.8)
export JAVA_HOME_11=$(/usr/lib/jvm/java-11-openjdk-amd64/bin/java -v11)
export JAVA_HOME_14=$(/usr/lib/jvm/java-14-openjdk-amd64/bin/java -v14)

alias java8='export JAVA_HOME=$JAVA_HOME_8'
alias java11='export JAVA_HOME=$JAVA_HOME_11'
alias java14='export JAVA_HOME=$JAVA_HOME_14'

### nvm

- ref:

https://tecadmin.net/how-to-install-nvm-on-ubuntu-20-04/

`sudo apt install curl`

- This is NOT working, see ElementaryOS.md, 

Using: 
`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash`

not use!
`curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash `

The nvm installer script creates environment entry to login script of the current user. You can either logout and login again to load the environment or execute the below command to do the same.

`source ~/.profile`

actually,
`source ~/.bashrc`

`nvm install node`
To install a specific version of node:

`nvm install 12.18.`3

You can use the following command to list installed versions of node for the current user.

`nvm ls`

With this command, you can find the available node.js version for the installation.

`nvm ls-remote`

You can also select a different version for the current session. The selected version will be the currently active version for the current shell only.

`nvm use 12.18.3`

To find the default Node version set for the current user, type:

`nvm run default --version`

You can run a Node script with the desired version of node.js using the below command:

`nvm exec 12.18.3 server.js`










