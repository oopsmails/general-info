
# Virtual Box Issues

## vmbox vdi change uuid

VBoxManage internalcommands sethduuid "/home/user/VirtualBox VMs/drupal/drupal.vhd"

VBoxManage internalcommands sethduuid "/Users/user/Documents/vbs/xxxx-ws/xxxx-ws.vdi"

## if machine uuid also "in use"

run VBoxManage internalcommands sethduuid "VDI/VMDK file" twice (the first time is just to conveniently generate an UUID, you could use any other UUID generation method instead)

open the .vbox file in a text editor

replace the UUID found in Machine uuid="{...}" with the UUID you got when you ran sethduuid the first time

replace the UUID found in HardDisk uuid="{...}" and in Image uuid="{}" (towards the end) with the UUID you got when you ran sethduuid the second time

my hint: need to change the uuid(s) in VirtualBox.xml

C:\Users\<username>\.VirtualBox\VirtualBox.xml

## error: virtualbox memory could not be written

You can test this by disabling 3D acceleration for a while. 

## VirtualBox doesn't have Devices menu

You need to exit from scale mode (Right Ctrl + C, or maybe right Alt if there is no right Ctrl + C). Then 'Devices' menu will appear.

## Cannot start guest after Windows 10 update

Reinstall latest version. More, need to update Extension Pack as well.


## Install certificates

- Download .cer files being imported
- If it is .crt file, then can be renamed as .cer file
- sudo mkdir -p /usr/share/ca-certificates/aaaa
- sudo cp aaaa.cer /usr/share/ca-certificates/aaaa
- sudo cp bbbb.cer /usr/share/ca-certificates/aaaa
- sudo chmod 777 /usr/share/ca-certificates/aaaa/aaaa.cer
- sudo chmod 777 /usr/share/ca-certificates/aaaa/bbbb.cer
- sudo dpkg-reconfigure ca-certificates
- Using the GUI, Yes, select new certs and OK






