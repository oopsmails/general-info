# Install MacOS Catalina on Virtual Box

## 20210327: Reload on Lenovo Small, Cataline

### Import from backup
- import Appliance from backup, D:\MacOS.ova
- Run those commands


### Problems Resolved

- Key board not working, solved by 
    - open settings
    - user interface
    - input drop down
    - uncheck and check again the keyboard checkbox
    - click OK

- Chrome icon changed, solved by
    - Open Finder, go to Applications, locate Google Chrome, then right click and choose Get Info. enter image description here
    - Click on the icon at the top left enter image description here
    - Press Cmd+C and then Cmd+V (Copy then Paste), it may ask your pw to make changes.
    - Exit get info window, and restart google chrome. It should be back to normal.

- Shared folder problem
    - Looks like have to use Finders :: Go :: Connect to Server, even installed Guest, /Volumes/VBox_GAs_6.1.18/VBoxDarwinAdditions.pkg


## Install from Beginning

### Ref 1

https://techsviewer.com/install-macos-10-15-catalina-on-virtualbox-on-windows-pc/

C:\Program Files\Oracle\VirtualBox\VBoxManage.exe

VBoxManage modifyvm "MacOS" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage modifyvm "MacOS" --cpu-profile "Intel Core i7-6700K"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1


### Ref 2


************************************************************************************************************************************************

                            LINUX NOX

************************************************************************************************************************************************
******Follow this links to download MAC OS virtual disk image*******

************************************************************************************************
*                                                                                              *
* 1.https://www.intoguide.com/download-macos-catalina-iso-file-latest-version/                 *
* 2.https://www.intoguide.com/download-macos-10-15-catalina-vmdk-files-virtual-machine-image/  *
* 3.https://techsviewer.com/category/mac/                                                      *
*                                                                                              *
* 4.Subscribe LINUX NOX :-                                                                     *
*   https://www.youtube.com/channel/UClBS00lvW8g7IBN-0fBC6qQ                                   *
*                                                                                              *
************************************************************************************************


====> Steps,


https://www.youtube.com/watch?v=Eb7R-dxznrg


VBoxManage.exe modifyvm "Mac OS" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage setextradata "Mac OS" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
VBoxManage setextradata "Mac OS" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "Mac OS" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
VBoxManage setextradata "Mac OS" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "Mac OS" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1


- Create New VM "Mac OS"
- From existing Hard Drive, pointing to the downloaded "macOS Catalina Virtual Disk Image.vmdk"
- Configure System, memory, CPU, Display, etc.
- Run cmd, as Administrater, and then run the commands above
- Start the VM

====> Mouse:

https://www.wikigain.com/fix-mouse-keyboard-stuck-macos-mojave-virtualbox/

Open VirtualBox then go to the VM (macOS Mojave) Settings and from the USB tab, select USB 3.0 (xHCI) Controller. Next, click on Add button then list your mouse and keyboard under USB Device Filters.


====> Display:

VBoxManage setextradata "Mac OS" VBoxInternal2/EfiGraphicsResolution 1920x1080




***********> Mac OS.ova, can be imported!!!


smb://192.168.56.1



macos word alternative



### Make a Catalina Bootable Installer Image

https://techsviewer.com/how-to-download-full-macos-catalina-installer-and-mojave/

- Use existing mac OS in VMWare, go to App Store, search "Catalina", click on get ....
- `macOS Catalina.App` is in Application folder

Alberts-Mac:ionic-loginsignup albert$ hdiutil create -o /tmp/Catalina -size 8500m -volname Catalina -layout SPUD -fs HFS+J
created: /tmp/Catalina.dmg
Alberts-Mac:ionic-loginsignup albert$ hdiutil attach /tmp/Catalina.dmg -noverify -mountpoint /Volumes/Catalina
/dev/disk3          	Apple_partition_scheme         	
/dev/disk3s1        	Apple_partition_map            	
/dev/disk3s2        	Apple_HFS                      	/Volumes/Catalina
Alberts-Mac:ionic-loginsignup albert$ sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/Catalina --nointeraction
Password:
Erasing disk: 0%... 10%... 20%... 30%... 100%
Copying to disk: 0%... 10%... 20%... 30%... 40%... 50%... 60%... 70%... 80%... 90%... 100%
Making disk bootable...
Copying boot files...
Install media now available at "/Volumes/Install macOS Catalina"
Alberts-Mac:ionic-loginsignup albert$ hdiutil detach /volumes/Install\ macOS\ Catalina
"disk3" ejected.
Alberts-Mac:ionic-loginsignup albert$ hdiutil convert /tmp/Catalina.dmg -format UDTO -o ~/Desktop/Catalina.cdr
Reading Driver Descriptor Map (DDM : 0)…
Reading Apple (Apple_partition_map : 1)…
Reading  (Apple_Free : 2)…
Reading disk image (Apple_HFS : 3)…
....................................................................................................................................................................................
Elapsed Time:  1m 55.651s
Speed: 73.5Mbytes/sec
Savings: 0.0%
created: /Users/albert/Desktop/Catalina.cdr
Alberts-Mac:ionic-loginsignup albert$ mv ~/Desktop/Catalina.cdr ~/Desktop/Catalina.iso


## Other

After using Dist Utility, Erase ...

Then, back to main menu, Install macOS Catalina on your VirtualBox Disk.










