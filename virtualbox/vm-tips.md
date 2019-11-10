
- vmbox vdi change uuid

VBoxManage internalcommands sethduuid "/home/user/VirtualBox VMs/drupal/drupal.vhd"

- if machine uuid also "in use"

run VBoxManage internalcommands sethduuid "VDI/VMDK file" twice (the first time is just to conveniently generate an UUID, you could use any other UUID generation method instead)

open the .vbox file in a text editor

replace the UUID found in Machine uuid="{...}" with the UUID you got when you ran sethduuid the first time

replace the UUID found in HardDisk uuid="{...}" and in Image uuid="{}" (towards the end) with the UUID you got when you ran sethduuid the second time

my hint: need to change the uuid(s) in VirtualBox.xml

C:\Users\<username>\.VirtualBox\VirtualBox.xml




