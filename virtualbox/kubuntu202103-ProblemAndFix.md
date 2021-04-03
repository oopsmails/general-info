
# Kubuntu: 202103

## Display only 800*600, need to 1640*864

### install Extension Guest

- insert Guest

- run inside kubuntu

sudo ./VBoxLinuxAdditions.run

### if still cannot keep Display resolution

- Task bar is at wrong place, i.e, not at the bottom ... try Full Screen and the Scaled mode

- Selected VBoxSVGA instead of VMSVGA, even could showing with error, just change it!!!

- Switch around view :: Scaled mode and Auto resize guest ...

## apt update

- Problem:

Err:1 http://packages.microsoft.com/repos/code stable InRelease
  Could not connect to 127.0.0.1:3128 (127.0.0.1). - connect (111: Connection refused)
Err:2 http://ca.archive.ubuntu.com/ubuntu focal InRelease

Solution:

check /etc/apt/apt.conf, if there is Acquire proxy, comment those out.


## Disable KDE Wallet when opening Chrome

### System Settings :: KDE Service, disable it

### - Ref: https://superuser.com/questions/994551/disable-kwallet-popups-from-chrome

You can completely disable the KWallet backend by adding the following command-line flag to Chrome: --password-store=basic

For instance (if you're using Ubuntu's Chromium build), edit /etc/chromium-browser/default (system-wide) or ~/.chromium-browser.init (per-user) and add the flag to CHROMIUM_FLAGS. E.g.:

```
# Default settings for chromium-browser. This file is sourced by /bin/sh from
# /usr/bin/chromium-browser

# Options to pass to chromium-browser
CHROMIUM_FLAGS="--password-store=basic"

```

- If you're using ArchLinux's Chromium build, edit **~/.config/chromium-flags.conf** and add:

`--password-store=basic`

- **This one working in Kubuntu 20.04**, I couldn't find a similar place on fedora, but I found **/opt/google/chrome/google-chrome** and added --password-store=basic to the exec command at the bottom of the script. Seems to work. Thanks very much! – jozxyqk Nov 3 '15 at 11:23

- On Debian Jessie (8) I installed this file to **/etc/chromium.d/no-kwallet** 

- For vivaldi in /opt/vivaldi/vivaldi. – Zitrax May 3 '19 at 9:52 



