
# Kubuntu: 202103

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


## Install Softwares

### Chrome

- Download deb, save file and double click to run

### vs code

## apt update

- Problem:

Err:1 http://packages.microsoft.com/repos/code stable InRelease
  Could not connect to 127.0.0.1:3128 (127.0.0.1). - connect (111: Connection refused)
Err:2 http://ca.archive.ubuntu.com/ubuntu focal InRelease

Solution:

check /etc/apt/apt.conf, if there is Acquire proxy, comment those out.

## Install Docker CE

- see github/general-info/virtualbox/kubuntu202103-installDockerCE.md

## Install docker-compose

`sudo apt  install docker-compose`

## Run Docker Kafka

docker-compose -f /home/albert/Documents/sharing/docker-compose-wurstmeister.yaml up -d

