
# Red Had Enterprise Linux 8

## Installation

### RHEL8 iso

https://developers.redhat.com/products/rhel/download

rhel-8.4-x86_64-dvd.iso

### Install on Virtual Box

![20210605-vb-installRHEL](20210605-vb-installRHEL.PNG)

https://developers.redhat.com/rhel8/install-rhel8-vbox#overview

### Install Virtualbox Guest Additions

- Error: kernel header or kernel service is not running ...

https://access.redhat.com/discussions/4452161?tour=8

First, need to register RHEL by using Register Manager

Second, 

```
I encountered the same issue with RHEL 8.2 and Virtualbox 6.1.18 with similar message in the /var/log/vboxadd-install.log file as below:

Virtualbox Guest Additions: Kernel headers not found for target kernel 4.18.0-193.el8.x86_64. Please install them and execute /sbin/rcvboxadd_setup

You need to install Developer tools and elfutils-libelf-devel
sudo yum groupinstall "Development Tools"

sudo yum install kernel-devel elfutils-libelf-devel

Then reinstall the Virtualbox Guest Additions

More details can be found at: https://developers.redhat.com/rhel8/install-rhel8-vbox#install_updates
```

hostname: rhel8

### This is the final instruction followed!!!

https://developers.redhat.com/rhel8/install-rhel8-vbox#installation

- Select software to be installed
Click Software Selection under SOFTWARE.  We recommend that you:

Choose Workstation on the left under Base Environment
Then, choose Container Management, Development Tools, and Graphical Admin Tools. 
Note: Do not choose Server with a GUI as your base environment. There is a known issue that will prevent the graphical desktop from starting

- System Registration from the command line
sudo bash

yum repolist

Updating Subscription Management repositories.
Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)
Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)

### Install updates

sudo yum update

reboot

### Cockpit Web console

sudo systemctl enable --now cockpit.socket 

sudo firewall-cmd --add-port=9090/tcp

sudo firewall-cmd --permanent --add-port=9090/tcp

https://rhel8:9090/ 

### VirtualBox Guest Additions

- need to add user group first

```
groups

sudo usermod -a -G vboxsf albert
sudo usermod -a -G root albert
```

- before run Guest Additions

sudo yum groupinstall "Development Tools"

sudo yum install kernel-devel elfutils-libelf-devel

- install and reboot









