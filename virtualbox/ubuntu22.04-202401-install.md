# Ubuntu 22.04

## .bashrc

```
bashScripts="$HOME/Documents/programs/bashScripts"
# PATH="$HOME/Documents:$PATH"
# PATH="$HOME/Documents/sharing:$PATH"
PATH="$HOME/Documents/programs:$PATH"
PATH="$bashScripts:$PATH"


alias kubectl="minikube kubectl --"
alias d="docker "
alias dc="docker-compose "
alias arun=". cdto.sh "


# Java Alias
alias java8="source $bashScripts/java8.sh"
alias java11="source $bashScripts/java11.sh"
# alias java17="source $bashScripts/java17.sh"


```

## Softwares

### Timeshift

See ubuntu20.04-20221006-timeshift.md.

NO: sudo apt install timeshift
Yes: install from Ubuntu Software.

### Git

```
sudo apt install git

git -v

git config --global user.name "JohnDoe"

# Verify that the username has been updated by running the first command again:

git config --global --get user.name

```

### Chrome

Installed from google-chrome-stable_current_amd64.deb, manual local.

### VSCode

Installed from Ubuntu Software, all fine.

### NVM and Node

- Ref: https://tecadmin.net/install-nodejs-with-nvm/

sudo apt update && sudo apt install curl -y

curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

```

source ~/.bashrc

`nvm install 12.18.3`

`nvm install 16.13.1`

nvm list

### Java

- install openjdk,
  openjdk-headless (like jre) < openjdk < openjdk-devel

```
sudo apt update

## sudo apt install default-jdk # This will install OpenJDK 11

sudo apt install openjdk-11-jdk
sudo apt install openjdk-8-jdk

sudo update-java-alternatives --list
sudo update-alternatives --config java # This can switch around versions


  0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      auto mode
  1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      manual mode
* 2            /usr/lib/jvm/java-14-oracle/bin/java             1091      manual mode
  3            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode

```

- if remove, sudo apt remove openjdk-14-jdk

add alias
source ~/.bashrc

### intellij

sudo snap install intellij-idea-community --classic

### Terminal

160 x 40

### Chinese Input

- Ref: https://askubuntu.com/questions/1408873/ubuntu-22-04-chinese-simplified-pinyin-input-support

Note: These instructions are ONLY meant for vanilla Ubuntu and ONLY for 22.04 for basic pinyin input for simplified characters.

Ubuntu has never provided an easy, well-documented option for adding pinyin input support. However, to get basic pinyin support in 22.04 you can simply:

Open Settings, go to Region & Language -> Manage Installed Languages -> Install / Remove languages.
Select Chinese (Simplified). Make sure Keyboard Input method system has Ibus selected. Apply.
Reboot
Log back in, reopen Settings, go to Keyboard.
Click on the "+" sign under Input sources.
Select Chinese (China) and then Chinese (Intelligent Pinyin).

You should now have a little "en" (or whatever the language code of your Ubuntu install is) at the top right of your main screen which you can click on and get a list of available input methods, including Chinese (Intelligent pinyin). Open anything that can receive text (like gedit, openoffice, vim, FF,...) and try it out. You can also change between them with Super/Win + space.

Reboot to make sure it is still there after a reboot.

### unbutu shutdown shortcut

- Ref: https://amitness.com/2015/06/ubuntu-keyboard-shortcut/

Open a terminal and enter the following command. You will be asked for the password.
sudo chmod u+s /sbin/shutdown

Then goto System Settings > Keyboard and in the shortcuts tab, click Custom Shortcuts

Then click the “Add custom shortcut” button and a popup will open. In it add name as “Shutdown” and command as “shutdown -h now” . Then click add.

After adding, you will get a list of shortcuts as shown below. In that click shutdown and below it, there will be three unassigned. Click the first unassigned and it will change into “Pick an accelerator“. Then click Ctrl+Alt+K at the same time. This will be our shortcut for shutdown.

## Error

### Failed to load module "canberra-gtk-module", when running 'arun here'

sudo apt-get install libcanberra-gtk-module
