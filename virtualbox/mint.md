
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

