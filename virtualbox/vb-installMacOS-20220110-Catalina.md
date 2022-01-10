# Install MacOS Catalina on Virtual Box

## Download Image

https://techsprobe.com/download-iso-file-of-macos-catalina-10-15-virtual-images/


macOS Catalina 10.15.5 Final ISO (19F101) – Latest Version

http://www.mediafire.com/file/2mwxpooe0da6z3n/Catalina_10.15.5.iso/file


## Run following on Windows

```
cd C:\Program Files\Oracle\VirtualBox

VBoxManage modifyvm "MacOS" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac19,1"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Mac-AA95B1DDAB278B95"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1

```
- This will fix "stuck" error ...

```
VBoxManage modifyvm "MacOS" --cpu-profile "Intel Core i7-6700K"
```

- This will set display resolution

```
VBoxManage setextradata "MacOS" VBoxInternal2/EfiGraphicsResolution 1920x1080
```

## Create VM MacOS in Virtual Box

## VirtualBox mac os install guest additions

### Run VBoxDarwinAdditions.pkg failed.

### Using this instruction

https://github.com/geerlingguy/macos-virtualbox-vm/issues/79

#### Disable Gatekeeper

1. Be sure to exit System Preferences on your Mac.
2. Open a Terminal
3. Enter the command sudo spctl --master-disable.

Source: How to open apps from unidentified developers on Mac in macOS Catalina

#### Check Gatekeeper is disabled
1. Click on System Preferences on your Mac Dock.
2. Choose Security & Privacy.
3. Look at Allow apps download from:, it should be set to Anywhere. If it is, you are done.
4. If not, click the lock icon at the bottom left of the screen.
5. Choose the Anywhere option under Allow apps downloaded from. Prior to making the change, this option wasn't available.
6. Click the unlocked lock again to keep the change.

#### Disable SIP (System Integrity Protection)

1. Restart your computer in Recovery mode.
2. Launch *Terminal* from the *Utilities* menu. **Note**: from the menu above, not in the popup win.
3. Run the command `csrutil disable` .
4. Restart your computer.

I tried pressing F12, F8 and even ESC key in order to configure VirtualBox to boot into the EFI shell but was not able to do so. In the end, this comment from issue 46 had the solution:

1. In your VM's terminal enter the following command to reboot in *recovery* mode:
*sudo nvram recovery-boot-mode=unused && sudo shutdown -r now*
2. Once in recovery mode open a terminal in Utilities->Terminal.
3. Run the commands you want like:
```
csrutil disable
spctl kext-consent add VB5E2TV963
```
(note the last command is explained in steps below)

4. Enter the following command to exit recovery mode:
*nvram -d recovery-boot-mode && shutdown -r now*
5. And you'll get back into normal macOS.

#### Check SIP is disabled
You can verify that SIP is disabled with the command:
`csrutil status`

which should display:
*System Integrity Protection status: disabled..*

#### Allow Oracle identifier for kext

1. Restart your computer in Recovery mode. Refer to previous section to know how to do this.
2. Launch Terminal from the Utilities menu.
3. Run the command spctl kext-consent add VB5E2TV963 .
4. Restart your computer.

VB5E2TV963 is the code for oracle.

Source: Install problem 10.14.5 vBox 6.0

#### Change ownership and permissions on filesystem

Enable writing to */System/Library/Extensions/*.

In your VM's terminal enter the following commands:

```
sudo mount -uw /
sudo chown :admin /System/Library/Extensions/
sudo chmod 775 /System/Library/Extensions/
```

Source: Guest Additions not installing on macOS 10.15 Catalina guests

#### Install Guest Additions
At this point, the installation of Guest Addition should succeed. Proceed with normal installation instructions.

1. On VirtualBox emulation window, click on Devices menu.
2. Select Insert Guest Additions CD image....
3. In your VM, click on the new CD image on the desktop.
4. Click on VBoxDarwinAdditions.pkg.
5. Follow the instructions on screen.
6. A reboot is required after the installation.

#### Check clipboard sharing is working
Check that clipboard is shared between the host and the guest.

1. On VirtualBox emulation window, click on Devices menu.
2. Select menu Shared Clipboard, Bidirectional.
3. In your VM, open a terminal.
4. Select text.
5. Right-click on the selected text and select Copy.
6. On your host, open a note taking appplication.
7. Right-click and select Paste.

#### Revert disabled security features
- Enable Gatekeeper

1. Be sure to exit System Preferences on your Mac.
2. Open a Terminal
3. Enter the command sudo spctl --master-enable.

- Enable SIP

1. Restart your computer in Recovery mode.
2. Launch Terminal from the Utilities menu.
3. Run the command csrutil enable .
4. Restart your computer.















