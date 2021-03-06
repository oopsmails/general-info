
# Kubuntu: 202103

## Install Softwares

- Chrome
- vs code

## apt update

- Problem:

Err:1 http://packages.microsoft.com/repos/code stable InRelease
  Could not connect to 127.0.0.1:3128 (127.0.0.1). - connect (111: Connection refused)
Err:2 http://ca.archive.ubuntu.com/ubuntu focal InRelease

Solution:

check /etc/apt/apt.conf, if there is Acquire proxy, comment those out.

## Install Docker CE

- see github/general-info/virtualbox/kubuntu202103-installDockerCE.md

