
# How to Install macOS High Sierra on VMware on Windows

https://www.wikigain.com/install-macos-high-sierra-vmware-windows/

- Install VMware Player
VMware-player-15.1.0-13591040.exe

MacOS will NOT show when creating new Virtual Machine

- Run unlocker as Administrator, unlock VMware via Patch Tools

C:\vmware-repo\vmware-macOS-HighSierra\unlocker210\win-install.cmd

- Create & Edit New Virtual Machine

- Manage macOS High Sierra VMDK and Virtual Machine VMX file

add `smc.version = "0"` in newly created macOS 10.13.vmx

replace macOS 10.13.vmdk(12xxx KB), with the downloaded image file (6.x GB).

- Start the VM.


- Update to Catalina

https://techsviewer.com/how-to-install-macos-10-15-catalina-on-vmware-on-windows-pc/

