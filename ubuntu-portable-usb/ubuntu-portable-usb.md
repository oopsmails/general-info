# Install Ubuntu on USB Stike

- Ref:

NOT using

https://www.youtube.com/watch?v=cHF1ByFKtZo

Install Ubuntu 20.04 On LIVE USB / SSD With Persistent Storage (Plug & Play)

- Ref: This is the BEST!

https://itsfoss.com/intsall-ubuntu-on-usb/

## Steps: Ubuntu

### Download Ubuntu LTS Desktop ISO, Part 1: Create a live Ubuntu USB

Ubuntu - https://ubuntu.com/

### Download Rufus

Rufus - https://rufus.ie/

- What if rufus is not showing my External ssd???

Solution: If RUFUS doesn't show your external ssd try ALT+F, below you will see a message like "Hard disk detection" is ON/OFF.............It has stolen me a big amount of minutes

### Installation: Key points

- Step 2: Disable ESP flags from the ESP partition
  Press the Windows key and type Gparted. This will open the Gparted partition manager which is (usually) already present on the Ubuntu ISO.

In Gparted, make sure that you have selected the system's disk. Look for the partition of around 100-500 MB in size and flagged as ESP. Right click on this partition and select 'Manage Flags':

#### Summary, in Gpartedwill

- Should see "Windows SSD", 'Manage Flags', it should show esp and boot flags. If there are more flags set, take a screenshot so that you can revert to the same set of flags after the installation is complete.

Deselecting the flags usually adds a msftdata flag and you can leave it like that. Changes take into effect immediately.

- Great! Now your live system does not see the ESP partition and thus the existing boot settings of the computer. Now is the time to start installing Ubuntu on the other USB.

- Then start installation, on "Installation Type" page, select **Something Else** ...

ubuntu-portable-usb-01.png

- Make the first partition as ESP for the bootloader. This is used for OS Boot Manager (?), around 500M

ubuntu-portable-usb-02.png

- Select the remaining free space and create root with Ext4 filesystem. You may also create root, swap and home but I suggest keeping everything under root including swap (thanks to swapfile).

This is the REAL bootable Ubuntu

ubuntu-portable-usb-03.png

- Double all on External USB and innstall ubuntu on Ext4 partition.

ubuntu-portable-usb-04.png

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

- Install VirtualBox Extension Pack, v6.xx

1. Download Oracle VM VirtualBox Extension Pack

2. Graphical Mode  
   To install the extension pack, go to VirtualBox >> Preference >> Extensions >> browse for extension pack by clicking on the + icon.

Oracle_VM_VirtualBox_Extension_Pack-6.1.32.vbox-extpack

sudo apt-get remove --purge virtualbox

- For v7.xx, 20240114

Step 3: Open your Oracle VM VirtualBox Manager. Go to File > Tools > Extension Pack Manager.

- NOTE:

removing previous version installed by useing _apt-get_

sudo apt-get autoremove 'virtualbox\*'

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

## Issues Notes

- install portable ubuntu on usb from windows

https://askubuntu.com/questions/1217832/how-to-create-a-full-install-of-ubuntu-20-04-to-usb-device-step-by-step

- VB error

https://askubuntu.com/questions/900794/virtualbox-rtr3initex-failed-with-rc-1912-rc-1912

---- Good to remove

sudo apt-get autoremove 'virtualbox\*'

---- Not used
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get install nvidia-375 nvidia-settings

- ubuntu black screen before login

For my HP, boot order, don't put "USB ..." as first, instead, make "OS boot manager" on top!!!

----- Not used but could be useful

https://itsfoss.community/t/black-screen-when-trying-to-login/4738/19

Did you make some changes to settings lately? Maybe your desktop somehow got corrupted.

One way to handle is to reinstall GNOME desktop.

On the login screen, use Ctrl+Alt+F1 or Ctrl+Alt+f2, Ctrl+Alt+f5 or a combination of Fn key like this.

One of these shortcuts will take you to terminal screen. You can login using your username and password.

And then reinstall the gnome desktop using this command:

sudo apt install --reinstall ubuntu-gnome-desktop

---

There are several ways to remedy this:

Check your ~/.config/monitor.xml settings and change any value occurring between <Scale> tags back to 1. Then save and reboot. This didn't work for me though although I have seen others report success.
Reset the fractional scaling setting to off by executing
gsettings reset org.gnome.mutter experimental-features

---

At the login screen, bring up the terminal using one of the key combinations mentioned in this thread (ctrl+alt+f2 worked for me). Login via the terminal and install the nvidia driver version 4.5.0:

sudo apt install nvidia-driver-450

Reboot your machine and login via the GUI. The screen may go blank for a while but it should come back up soon after.
