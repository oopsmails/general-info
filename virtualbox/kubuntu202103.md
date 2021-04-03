
# Kubuntu: 202103

## WebSphere location

/opt/ibm/WebSphere/AppServer/

## Change root password

## Setup Display

- if problem, see github/general-info/virtualbox/kubuntu202103-ProblemAndFix.md

## Add Shared folder

- add as following, make it permenent

C:\sharing

sharing

/home/albert/Documents/sharing

- add current user "admin" to vboxsf group

`su root`

password as root

usermod -a -G vboxsf admin

- logout and login again, now the shared folder is accessible.


## Change hostname

`sudo hostnamectl set-hostname kubntu20`

## sudo apt update


## Install Softwares

### Chrome

- Download deb, save file and double click to run

### vs code

- Download deb, save file and double click to run

- Config: title: long, open new: window size inherit, folder in new window, explorer sort: alphabetical

- see General\VsCode.md

## Install Docker CE

- see github/general-info/virtualbox/kubuntu202103-installDockerCE.md

## Install docker-compose

`sudo apt install docker-compose`

## Run Docker Kafka

docker-compose -f /home/albert/Documents/sharing/docker-compose-wurstmeister.yaml up -d

