

# Virtual Box IP

https://www.howtogeek.com/122641/how-to-forward-ports-to-a-virtual-machine-and-use-it-as-a-server/


## Selecting Bridged Networking

With the NAT network type, your host operating system performs network address translation. The virtual machine shares your host computer’s IP address and won’t receive any incoming traffic. You can use bridged networking mode instead — in bridged mode, the virtual machine will appear as a separate device on your network and have its own IP address.

To change a virtual machine’s network type in VirtualBox, right-click a virtual machine and select Settings. If you can’t click Settings, you’ll need to power off the virtual machine before making these change.

image

Select the Bridged adapter network mode in the Network settings section and click OK. For more information about each type of network mode, consult the Introduction to networking modes section in VirtualBox’s manual.

image

The process is similar in VMware applications. First, right-click a powered off virtual machine and select Virtual Machine Settings.

image

Select the Network Adapter virtual hardware device, select the Bridged network connection type, and click OK.

image

## Forwarding Ports to a Virtual Machine

If you prefer to use NAT network mode for some reason, you can also forward ports through the virtual machine’s NAT. Note that only one of these steps is necessary – you don’t have to forward ports if you enabled bridged networking above.

At one point, you had to use the VBoxManage command to forward ports in VirtualBox, but VirtualBox now contains a simple graphical port-forwarding window. If you need to set up port forwarding with the VBoxManage command instead of using the graphical interface, you’ll find instructions for doing so in VirtualBox’s manual.

To forward ports in VirtualBox, first open a virtual machine’s settings window by selecting the Settings option in the menu.

image

Select the Network pane in the virtual machine’s configuration window, expand the Advanced section, and click the Port Forwarding button. Note that this button is only active if you’re using a NAT network type – you only need to forward ports if you’re using a NAT.

image

Use VirtualBox’s Port Forwarding Rules window to forward ports. You don’t have to specify any IP addresses – those two fields are optional.

Note: While you don’t have to enter any IP details, leaving the Host IP box blank will make VirtualBox listen on 0.0.0.0—in other words, it will accept all traffic from the local network and forward it to your virtual machine. Enter 127.0.0.1 in the Host IP box and VirtualBox will only accept traffic originating on your computer—in other words, on the host operating system.

image

If you’re using VMware, you’ll need to use the Virtual Network Editor (vmnetcfg) application to do this. VMware Workstation users can select Edit –> Virtual Network Editor to open it.

Unfortunately, this utility is not included with VMware Player. There are methods for installing it yourself by extracting the vmnetcfg.exe file from the VMware Player installer, but I couldn’t locate the vmnetcfg.exe utility in the latest version of VMware Player, VMware Player 5.0 – it may no longer be included in the installer. If you’re using VMware Player, you can still use bridged networking mode to make your server accessible.


## /etc/hosts file

## How to Increase Disk Size of Your Existing Virtual Machines in VirtualBox

- using cmd

VBoxManage.exe modifyhd "C:\vb-repo\mint20\mint20.vdi" --resize 102400

VBoxManage.exe modifyhd "C:\vb-repo\mint20\mint20-disk001.vdi" --resize 102400

- Use disk manage app, GParted Live ISO, to resize disk under linux.

see, https://www.pragmaticlinux.com/2020/09/how-to-increase-the-disk-size-in-a-virtualbox-virtual-machine/



- The following does NOT work!

How to Increase Disk Size of Your Existing Virtual Machines in VirtualBox

Last updated April 17, 2021 By Dimitrios 

Method 1: Using the Virtual Media Manager in VirtualBox
VirtualBox 6 added a graphical option for resizing virtual disks. You can find it at the file tab of VirtualBox home page.

Go to File->Virtual Media Manager, properties. Then, increase the size

