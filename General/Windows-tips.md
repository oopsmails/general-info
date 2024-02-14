# Windows Tips

## General

### windows not recognizing linux usb

- On Windows

```
cmd :::> diskpart

DISKPART> list disk

  Disk ###  Status         Size     Free     Dyn  Gpt
  --------  -------------  -------  -------  ---  ---
  Disk 0    Online          476 GB      0 B        *
  Disk 1    Online         7633 MB  7631 MB

DISKPART> select disk 1

Disk 1 is now the selected disk.

DISKPART> clean

DiskPart succeeded in cleaning the disk.

DISKPART> create partition primary

DiskPart succeeded in creating the specified partition.

DISKPART> active

DiskPart marked the current partition as active.

DISKPART> select partition 1

Partition 1 is now the selected partition.

DISKPART> format fs=fat32

wait for 100 persent ... then ready to go!

```

- On Linux

search around, e.g, "linux disk partition", or using mkusb ....

### windows 10 bluetooth check the pin and try connecting again

Use Divice Pariing Wizard:

Start -> Run -> devicepairingwizard

### Git Bash profile

put cdto.sh to /c/abc

C:\Program Files\Git\etc\profile

PATH="/c/abc:${PATH}"
export PATH

### Show all opening apps on all desktops

Settings :: System :: Multitasking :: Desktop

On the taskbar, show all the open windows, drop down
Show all open windows when I press Alt + Tab

### Windows keeps adding Xbox icon to the taskbar

Windows Key+R and write %userprofile%\AppData\Local\Microsoft\Windows\Shell.

Edit the file named LayoutModification.xml.

Delete the following line that has the terms taskbar and Microsoft.Xbox.App

or "MSI Center" icon.

### why I installed input simplified chinese but it is traditional chinese?

The Simplified Chinese Microsoft Pinyin IME is capable of both simplified and traditional characters. When you install it, it will be set for simplified characters. It is set up to toggle between simplified and traditional with the keybinding ctrl shift F
