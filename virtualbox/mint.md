
# MintOS

## General

- hotkey, right ctrl
- hotkey + c, switch displaying between Full mode and Scaled mode.
- Right Control + Home (by default), show vb menu.
- Full mode, can select show vb menu bar.

- root
    - During boot, press and hold Shift (for BIOS) or ESC (for UEFI). In my case, it is Shift.
    - Start with Recovery mode, then root terminal, run *passwd* to change root password


## Problem and Fix

### Resolution cannot keep after logout or restart

- Make sure VirtualBox Guest Additions is installed
- Switch around Full screen and make sure Auto-resize guest display is checked.

## Install

### Chorme

- download first
- sudo apt install ./google-chrome-stable_current_amd64.deb
- keyring,

rm ~/.local/share/keyrings/login.keyring

Now open Chrome, if it asks you for your password, do not enter one choose Continue each time and ignore any warning.

### vscode

### Enable snapd

- Ref:
https://snapcraft.io/install/intellij-idea-community/mint

- Snap is available for Linux Mint 18.2 (Sonya), Linux Mint 18.3 (Sylvia), Linux Mint 19 (Tara), Linux Mint 19.1 (Tessa) and the latest release, Linux Mint 20 (Ulyana). You can find out which version of Linux Mint you’re running by opening System info from the Preferences menu.

On Linux Mint 20, /etc/apt/preferences.d/nosnap.pref needs to be removed before Snap can be installed. This can be accomplished from the command line:

```
sudo rm /etc/apt/preferences.d/nosnap.pref
sudo apt update
```

- To install snap from the Software Manager application, search for snapd and click Install.

- Alternatively, snapd can be installed from the command line:

```
sudo apt update
sudo apt install snapd
```

Either restart your machine, or log out and in again, to complete the installation.

### intellij: Option 3 used, i.e, installed from Software Manager

- Option 1

```
cd Downloads
tar xvf 
sudo mv idea-IC-201.8538.32 /opt/idea
/opt/idea/bin/idea.sh
```

- Option 2
```
sudo snap install intellij-idea-community --classic
or

sudo snap install intellij-idea-community --classic --edge

```

- Option 3: install from Software Manager

### java

- sudo apt update
- sudo apt install default-jdk
- ... update-alternatives: using /usr/lib/jvm/java-11-openjdk-amd64/bin/jar to provide /usr/bin/jar (jar) in auto mode

### Meld: for like WinMerge or BeyondCompare

- installed from Software Manager






