
# ElementaryOS Tips

albert/albertalbert, root/albert, inituser/inituser

## Software installation

### Option 1

sudo apt-get update
sudo apt install code
sudo apt remove code

### Option 2, snap is always a good choice

sudo apt-get update
sudo apt install snapd
sudo snap install code --classic
sudo snap remove code

### Options 3

Just download zip or tar



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


## Elementary OS version

`lsb_release -a`

```
albert@eosvm:~/Documents/github/general-info$ lsb_release -a
No LSB modules are available.
Distributor ID:	elementary
Description:	elementary OS 5.1 Hera
Release:	5.1
Codename:	hera

albert@eosvm:~/Documents/github/general-info$ lsb_release -au
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 18.04.3 LTS
Release:	18.04
Codename:	bionic
```


## Enable snaps on elementary OS and install LibreOffic

```
sudo apt update
sudo apt install snapd
sudo snap install libreoffice
```

## Enable snaps on elementary OS and install Postman

```
sudo apt update
sudo apt install snapd
sudo snap install postman
```

## Install npm and nvm

https://linuxize.com/post/how-to-install-node-js-on-ubuntu-18.04/

### Installing Node.js and npm from NodeSource

#### The command will add the NodeSource signing key to your system, create an apt sources repository file, install all necessary packages and refresh the apt cache.

If you need to install another version, for example 14.x, just change setup_12.x with setup_14.x

`curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -`

#### Once the NodeSource repository is enabled, install Node.js and npm by typing:

`sudo apt install nodejs`

#### Verify that the Node.js and npm were successfully installed by printing their versions:

`node --version`

`npm --version`


### Installing Node.js and npm using NVM

#### Installing NVM (Node Version Manager) script
To download and install the nvm script run:

`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash`

The command above will clone the NVM repository from Github to the ~/.nvm directory

#### => Close and reopen your terminal to start using nvm or run the following to use it now:

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```


As the output above says, you should either close and reopen the terminal or run the commands to add the path to nvm script to the current shell session. You can do whatever is easier for you.

Once the script is in your PATH, verify that nvm was properly installed by typing:

`nvm --version`

#### Installing Node.js and npm
Now that the nvm is installed you can install the latest available version of Node.js, by typing:

`nvm install node`

`node --version`

#### Let’s install two more versions, the latest LTS version and version 8.10.0

`nvm install --lts`

`nvm install 8.10.0`

#### To list installed Node.js versions type:

`nvm ls`

#### You can change the currently active version with:

`nvm use 10.16.3`

Now using node v10.16.3 (npm v6.9.0)

#### If you want to change the default Node.js version use the following command:

`nvm alias default 10.16.3`

### Install Node.js and npm from the Ubuntu repository

Node.js and npm packages are available from the default Ubuntu 18.04 repositories.

At the time of writing, the version included in the Ubuntu repositories is v8.10.0 which is the previous TLS version.

To install nodejs and npm run the following commands:

`sudo apt update`

`sudo apt install nodejs npm`

The Node.js executable from the Ubuntu repositories is named nodejs instead of node because of a conflict with another package.

Verify the installation by executing:

`nodejs --version`

v8.10.0

### Install development tools

To be able to compile and install native add-ons from npm you need to install the development tools.

The following command will install all the necessary packages including the GCC compilers :

`sudo apt install build-essential`


### Uninstall Node.js
If for some reasons you want to uninstall Node.js and npm packages, you can use the following command:

`sudo apt remove nodejs npm`

### Install Docker CE

see /Docker/docker-install-ElementaryOS.md

### Install DBeaver

```
sudo apt update
sudo apt install snapd
sudo snap install dbeaver-ce
```

## Running Apps


### Docker:

#### MySQL

`docker run --name mysqldb -p 3306:3306 -v mysqldb:/var/lib/mysql -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=root -d mysql/mysql-server:latest`

##### Try to connect with DBeaver


##### error: dbeaver unable to load authentication plugin 'caching_sha2_password'. dbeaver

- This error comes up when the tool being used is not compatible with MySQL8, try updating to the latest version of MySQL Workbench for MySQL8

##### error: dbeaver community mysql8 Public Key Retrieval is not allowed

- Open "Connectioin Setting", "SSL", and then make sure "Allow Public Key Retrieval" checkbox is checked.

##### error: the trustAnchors parameter must be non-empty

- Open "Connectioin Setting", "SSL", and then disable "certificate validation" fixed the problem 


#### Kafka

- check ip addr

`ifconfig | grep inet`

```
albert@eosvm:~$ ifconfig |grep inet
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::42:7ff:fe0c:2d7  prefixlen 64  scopeid 0x20<link>
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::1baa:969d:605f:7901  prefixlen 64  scopeid 0x20<link>
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        inet6 fe80::f01c:37ff:fece:1c69  prefixlen 64  scopeid 0x20<link>
```



- run in detached mode:

`docker run --name kafka -d -p 2181:2181 -p 3030:3030 -p 8081-8083:8081-8083 -p 9581-9585:9581-9585 -p 9092:9092 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://172.17.255.255:9092 landoop/fast-data-dev:latest`

- re-run by name

`docker start kafka`

- stop container

`docker stop kafka`

#### mongodb

- Proceed to download the latest official Docker image for the MongoDB database:
sudo docker pull mongo

To download a specific version of MongoDB, use the same command appended with the version tag. For example:
sudo docker pull mongo:4.2.2

- mkdir 

+






## Other Small Tips

### enable ifconfig

```
albert@eosvm:~$ ifconfig | grep inet

Command 'ifconfig' not found, but can be installed with:

sudo apt install net-tools
```



### chrome keyring popup

-- rm ~/.local/share/keyrings/login.keyring

rm ~/.local/share/keyrings/*
Now open Chrome, if it asks you for your password, do not enter one choose Continue each time and ignore any warning.

### elementary os open folder double click

gsettings set io.elementary.files.preferences single-click false

### elementary os address bar show full path

`gsettings set org.gnome.nautilus.preferences always-use-location-entry true`

or

`dconf write /org/gnome/nautilus/preferences/always-use-location-entry true`

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

git config --global user.name "your username" <---- add to ~/.gitconfig, this is useful for commit in vscode

git config --global user.password "your password"




```
$ git config credential.helper store   <---- this is good
$ git push http://example.com/repo.git
Username: <type your username>
Password: <type your password>
[several days later]
$ git push http://example.com/repo.git

```

### elementary os dock settings

open Terminal,

`plank --preferences`


### elementary os remove doclets

just drag it to somewhere else.

#### How to delete group in Linux

- Delete a group named sales that exist on Linux, run: 
`sudo groupdel sales`

- Another option to remove a group called ftpuser in Linux, 

`sudo delgroup ftpusers`

- To view all group names on Linux, run: 

`cat /etc/group`

- Print the groups a user say albert is in: 

`groups albert`

- When adding a user to a group, it can be done with:

`usermod -a -G group user`

or

`gpasswd -a user group`

- Remove a user from a group

`gpasswd -d user group`



## Other Softwares

### shotcut

sudo apt update
sudo apt install snapd

sudo snap install shotcut --classic

### Spring Tool Suite: icon not showing correctly

- go to /home/[user]/.local/share/applications

- edit or add sts.desktop

```
[Desktop Entry]
Type=Application
Name=SpringToolSuite4
Icon=/home/albert/Documents/programs/sts-4.7.0.RELEASE/icon.xpm <----------------- make sure this is correct!
Exec=/home/albert/Documents/programs/sts-4.7.0.RELEASE/SpringToolSuite4
X-GNOME-FullName[en_CA]=SpringToolSuite4
Comment[en_CA]=Spring Tool Suite
NoDisplay=false
Path=
Terminal=false
X-GNOME-UsesNotifications=false
Categories=Development;
```




