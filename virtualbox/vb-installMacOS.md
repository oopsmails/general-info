# Install MacOS Catalina on Virtual Box

https://techsviewer.com/install-macos-10-15-catalina-on-virtualbox-on-windows-pc/


## Make a Catalina Bootable Installer Image

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


## 

After using Dist Utility, Erase ...

Then, back to main menu, Install macOS Catalina on your VirtualBox Disk.










