
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
- VirtualBox Guest Additions, may see some "errors", like, cannot change kernal etc., it is actually just warnings, can just ignore and go on.

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
- sudo apt install ./code_1.60.2-1632313585_amd64.deb
- Sync-ed using Github

### bash profile, Terminal, .profile file is NOT used in Elementary OS, should be $HOME/.bashrc

PATH="$HOME/Documents:$PATH"
PATH="$HOME/Documents/sharing:$PATH"
PATH="$HOME/Documents/programs:$PATH"

### java

- install openjdk, 

```

sudo apt install default-jre              # version 2:1.11-72, or
sudo apt install openjdk-11-jre-headless  # version 11.0.11+9-0ubuntu2~20.04
sudo apt install openjdk-16-jre-headless  # version 16.0.1+9-1~20.04
sudo apt install openjdk-8-jre-headless   # version 8u292-b10-0ubuntu1~20.04
sudo apt install openjdk-13-jre-headless  # version 13.0.7+5-0ubuntu1~20.04

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

`nvm install 12.18.3`

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

### Postman

https://www.how2shout.com/linux/how-to-install-postman-on-ubuntu-20-04-lts-linux/

- Using snap. Used for my Ubuntu20

`sudo snap install postman`

then go "Show Applications" and "Add to Favorites"

- Not using snap

Here we will see the steps to install Postman on Ubuntu 20.04 or 18.04 LTS Linux operating system. You can also use this guide for Linux Mint, CentOS, RHEL, Debian, and other Linux distros.

  - Download and install
  
  wget https://dl.pstmn.io/download/latest/linux64

  sudo tar -xvf linux64 -C /usr/bin

  export PATH=$PATH:/usr/bin/Postman

  run as "Postman"

  - Create Desktop & Launcher Shortcut

  sudo nano /usr/share/applications/Postman.desktop

  ```
  [Desktop Entry]
  Name=Postman API Tool
  GenericName=Postman
  Comment=Testing API
  Exec=/usr/bin/Postman/Postman
  Terminal=false
  X-MultipleArgs=false
  Type=Application
  Icon=/usr/bin/Postman/app/resources/app/assets/icon.png
  StartupWMClass=Postman
  StartupNotify=true

  ```

  - Save the file with Ctrl + O and Enter and close editor with Ctrl + X.

  - Copy the created shortcut to desktop as well:

  cp /usr/share/applications/Postman.desktop ~/Desktop/

  - Allow launching

  Right-click on the created shortcut of Postman on Desktop and select the “Allow launching” option.

### intellij

https://linuxconfig.org/how-to-install-intellij-idea-on-ubuntu-20-04-linux-desktop

```
$ sudo snap install intellij-idea-community --classic <-------------------- Used for my Ubuntu20
OR
$ sudo snap install intellij-idea-ultimate --classic
OR
$ sudo snap install intellij-idea-educational --classic


$ intellij-idea-community <-------------------- Used for my Ubuntu20
OR
$ intellij-idea-ultimate
OR
$ intellij-idea-educational

```
then go "Show Applications" and "Add to Favorites"


### Docker

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

see ubuntu20-installDocker.md

### Screen shot

Use existing
### Meld

- installed from Software Manager


