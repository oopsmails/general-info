
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




