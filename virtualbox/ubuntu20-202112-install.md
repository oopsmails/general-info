
# Ubuntu

## VB create ubuntu

- Download ubuntu iso image
https://ubuntu.com/download/desktop


- Create Virtual Machine in VB

As linux ubuntu 64 bits  
Change the vdi location!!! 
Insert in iso  
Enable 3D accelerate  

- Start and install ubuntu
- install updates and VB Guest Addition, restart
- Hotkey, right ctrl + home, select "Scaled Mode", also, make sure Menu is showing
- View, make sure Auto-resize guest display is checked. Then, test around display by resizing window.
- Restart, to change root password. Shift ??+ Esc, recovery mode, advanced options, drop root ..., passwd ...
- Restart, terminal, 160x40
- Make a snapshot and realy to install softwares
- Shared Folder: 

```
C:\sharing
sharing
/home/albert/Documents/sharing

initially, showing owner as root

groups

sudo usermod -a -G vboxsf albert
sudo usermod -a -G root albert

restart vm, will be ... (different from mint, as vboxsf group)

drwxrwxrwx 1 root root 24576 Dec  1 16:46 sharing

```

## General

- multiple workspaces

If you are using the default Ubuntu Gnome desktop, simply click on the "Activities" button in the top left, and then mouse over to the right edge of your screen. You will see all active workspaces plus one empty one. To create new workspaces simply drag a window to an empty one, or to the space between two existing workspaces, and a new workspace will be created. There will always been one empty workspace more than the ones you are actively using. Or, using Ctrl + Alt + UP/DOWN to navigate around.

## Problem and Fix

### Resolution cannot keep after logout or restart

- Make sure VirtualBox Guest Additions is installed
- Switch around Full screen and make sure Auto-resize guest display is checked.
- VirtualBox Guest Additions, may see some "errors", like, cannot change kernal etc., it is actually just warnings, can just ignore and go on.

### ubuntu show full path in address bar

gsettings set org.gnome.nautilus.preferences always-use-location-entry true

- off,

gsettings set org.gnome.nautilus.preferences always-use-location-entry false

- if off, use Ctrl + L to swith to address for copying

## Install

### Chorme

- download first
- sudo apt install ./google-chrome-stable_current_amd64.deb
- keyring, if first popup, just Continue without input anything twice, then should be ok. If popup again after close, then do following,

rm ~/.local/share/keyrings/login.keyring

Now open Chrome, if it asks you for your password, do not enter one choose Continue each time and ignore any warning.

- if certificate error or connect not secure ...

run `google-chrome --ignore-certificates-error`

### Terminal

open the terminal, select Edit->Profile Preferences -> General tab and change the values for columns and rows after where it says Initial terminal size: 160x40.

### Need install Git before VS Code

sudo apt update
sudo apt install git

git --version

### VS Code

- download and installed
- sudo apt install ./code_1.60.2-1632313585_amd64.deb
- Sync-ed using Github
- If after opening general-info, seeing all file as "modified" in VS Code git, then run `git config --global core.autocrlf input` and should be fine after restart

### bash profile, Terminal, $HOME/.bashrc

PATH="$HOME/Documents:$PATH"
PATH="$HOME/Documents/programs:$PATH"
PATH="$HOME/Documents/sharing:$PATH"

### java

- install openjdk, 
openjdk-headless (like jre) < openjdk < openjdk-devel

```
sudo apt update

## sudo apt install default-jdk # This will install OpenJDK 11

sudo apt install openjdk-11-jdk
sudo apt install openjdk-8-jdk

sudo apt install openjdk-14-jdk // not available
sudo apt install openjdk-15-jdk // not available

update-java-alternatives --list
sudo update-alternatives --config java # This can switch around versions


  0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      auto mode
  1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      manual mode
* 2            /usr/lib/jvm/java-14-oracle/bin/java             1091      manual mode
  3            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode

```

sudo apt remove openjdk-14-jdk

- add to bash profile

```
# Java Alias
alias java8='source /home/albert/Documents/programs/java8.sh'
alias java11='source /home/albert/Documents/programs/java11.sh'
```

- Notes
  - scripts need with LF, not CRLF
  - update-java-alternatives might not work anymore, use update-alternatives
  - use *-set instead* of *-config java* in scripts to avoid using *echo*
  - java version names need to be complaint to *update-java-alternatives --list*
  - java 8 is actually pointing to jre?? use is anyways.

### nvm adn node

- ref:

https://tecadmin.net/how-to-install-nvm-on-ubuntu-20-04/

```
sudo apt install curl`

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

source ~/.bashrc

-- nvm install node

nvm install v16.13.1


nvm ls

nvm ls-remote

nvm use v16.13.1

To find the default Node version set for the current user, type:

nvm run default --version

You can run a Node script with the desired version of node.js using the below command:

nvm exec v16.13.1 server.js

```

### Postman

- install using "Ubuntu Software"
- "Show Applications", search postman, right click to add to Favorite
- if cannot import from *sharing* folder, then just copy the file, *Spring-boot-mock-backend.postman_collection.json* to */home/albert/Documents/dev*, then should be ok. May be due to CRLF/LF.
- create Desktop shortcut, and right click "Allow Lauching"

```
~/Desktop/postman.desktop

[Desktop Entry]
Name=postman
Name=Postman
Exec=/snap/bin/postman
Icon=/snap/postman/149/usr/share/postman/icons/icon_128x128.png
Categories=Utility
Terminal=false
Type=Application

```

### intellij

- install using "Ubuntu Software"
- "Show Applications", search postman, right click to add to Favorite

### Docker: 20211204 here

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

see ubuntu20-installDocker.md

### Screen shot

Use existing
### Meld

- installed from Software Manager

## Tips

- if using vpn, then Network, Bridged Adapter might be a good choice.
- if using port forwarding, then switch to NAT.
- File, add root directory in Bookmark, Other Location, in address bar, "Computer", drop down, add to Bookmarks.

### keytool

```
cd /usr/lib/jvm/java-1.11.0-openjdk-amd64/bin

sudo keytool -import -file "/home/<path-to-certs>/certs/abcd.crt" -alias "policyabcd" -keystore "/usr/lib/jvm/java-1.11.0-openjdk-amd64/lib/security/cacerts"
```


### Monitor startup apps

- list any services launched at startup by opening Terminal and running the command:

service --status-all 
- To stop a running service, enter the command:

- sudo service <name> stop
To remove an existing program from Ubuntu open Terminal and run:

- sudo apt-get remove <program name>




