
# ElementaryOS Tips

## Java

### OpenJDK:

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


### Installing Oracle Java: !!!!! NOT working anymore !!!!!!

#### Install the dependencies necessary to add a new repository :

sudo apt install software-properties-common

#### Enable the Linux Uprising PPA by running the following commands:

sudo add-apt-repository ppa:linuxuprising/java

#### Once the repository is added, update the packages list and install the oracle-java11-installer package by typing:

sudo apt update
sudo apt install oracle-java11-installer


## Terminal, .profile file is NOT used in Elementary OS, should be $HOME/.bashrc


PATH="$HOME/Documents:$PATH"
PATH="$HOME/Documents/sharing:$PATH"
PATH="$HOME/Documents/programs:$PATH"

export JAVA_HOME_8=$(/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -v1.8)
export JAVA_HOME_11=$(/usr/lib/jvm/java-11-openjdk-amd64/bin/java -v11)
export JAVA_HOME_14=$(/usr/lib/jvm/java-14-openjdk-amd64/bin/java -v14)

alias java8='export JAVA_HOME=$JAVA_HOME_8'
alias java11='export JAVA_HOME=$JAVA_HOME_11'
alias java14='export JAVA_HOME=$JAVA_HOME_14'



## Enable snaps on elementary OS and install LibreOffic

sudo apt update
sudo apt install snapd
sudo snap install libreoffice


## Other Small Tips


### chrome keyring popup

-- rm ~/.local/share/keyrings/login.keyring

rm ~/.local/share/keyrings/*
Now open Chrome, if it asks you for your password, do not enter one choose Continue each time and ignore any warning.

### elementary os open folder double click

gsettings set io.elementary.files.preferences single-click false

## Find application information (location and execution name) in AppEditor

### sudo ibm installation manager

root@xxvm:/opt/IBM/InstallationManager/eclipse# ./launcher

### sudo uninstall IBM Install Manager
root@xxvm:/var/ibm/InstallationManager/uninstall# ./uninstall
Gtk-Message: 22:36:41.944: Failed to load module "pantheon-filechooser-module"


### Change user name
sudo usermod -l newUsername oldUsername

### Add user to group

```
groups

sudo usermod -a -G vboxsf albert
```

### Git configure global user name and passowrd

git config --global user.name "your username"

git config --global user.password "your password"


### elementary os dock settings

open Terminal,

`plank --preferences`




