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

sudo apt install timeshift

### Git

```
sudo apt install git

git -v

git config --global user.name "JohnDoe"

# Verify that the username has been updated by running the first command again:

git config --global --get user.name

```

### Chrome

Installed from Ubuntu Software, all fine.

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

## Error

### Failed to load module "canberra-gtk-module", when running 'arun here'

sudo apt-get install libcanberra-gtk-module
