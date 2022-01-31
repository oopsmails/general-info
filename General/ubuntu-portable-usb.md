
# Install Ubuntu on USB Stike

- Ref:

https://www.youtube.com/watch?v=cHF1ByFKtZo

Install Ubuntu 20.04 On LIVE USB / SSD With Persistent Storage (Plug & Play)


## Steps: Ubuntu

### Download Ubuntu LTS Desktop ISO

Ubuntu - https://ubuntu.com/

### Download Rufus

Rufus - https://rufus.ie/

- What if rufus is not showing my External ssd???

Solution: If RUFUS doesn't show your external ssd try ALT+F, below you will see  a message like "Hard disk detection" is ON/OFF.............It has stolen me a big amount of minutes

### Run after installation

```
sudo apt update && sudo apt upgrade -y 

sudo add-apt-repository universe 

sudo add-apt-repository multiverse
```

## Softwares


### Virtual Box

- Ref:

https://www.itzgeek.com/post/how-to-install-virtualbox-on-ubuntu-20-04/


- Install Virtual Box

```
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian focal contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

sudo apt update

sudo apt install -y virtualbox-6.1

sudo systemctl status vboxdrv ----------> checking


Output:

● vboxdrv.service - VirtualBox Linux kernel module
   Loaded: loaded (/usr/lib/virtualbox/vboxdrv.sh; enabled; vendor preset: enabled)
   Active: active (exited) since Thu 2020-05-28 17:53:15 EST; 1min ago
  Process: 1416 ExecStart=/usr/lib/virtualbox/vboxdrv.sh start (code=exited, status=0/SUCCESS)

May 28 17:54:42 ubuntu2004 systemd[1]: Starting VirtualBox Linux kernel module...
May 28 17:54:42 ubuntu2004 vboxdrv.sh[1416]: vboxdrv.sh: Starting VirtualBox services.
May 28 17:54:42 ubuntu2004 vboxdrv.sh[1421]: Starting VirtualBox services.
May 28 17:54:42 ubuntu2004 vboxdrv.sh[1438]: VirtualBox services started.
May 28 17:54:42 ubuntu2004 systemd[1]: Started VirtualBox Linux kernel module.


```

- Install VirtualBox Extension Pack

1. Download Oracle VM VirtualBox Extension Pack

2. Graphical Mode  
To install the extension pack, go to VirtualBox >> Preference >> Extensions >> browse for extension pack by clicking on the + icon.

Oracle_VM_VirtualBox_Extension_Pack-6.1.32.vbox-extpack


sudo apt-get remove --purge virtualbox


- NOTE:

removing previous version installed by useing *apt-get*


sudo apt-get autoremove 'virtualbox*'


### Virtual Box, Failed

- Ref:

https://phoenixnap.com/kb/install-virtualbox-on-ubuntu

Option 1: Install VirtualBox from Ubuntu Repositories


The easiest way to install VirtualBox is by using the official Ubuntu repositories.

1. Open a terminal, and enter the following to update the repository:

sudo apt-get update

2. Download and install VirtualBox by running:

sudo apt-get install virtualbox

```
DKMS: install completed.
```


3. Next, install the VirtualBox Extension Pack:

sudo apt-get install virtualbox-ext-pack


```
The file will be downloaded into /usr/share/virtualbox-ext-pack
License accepted.
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Successfully installed "Oracle VM VirtualBox Extension Pack"
```




