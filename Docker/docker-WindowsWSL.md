# Install Docker Desktop on Windows

## Before Install

### Check if Vertualization is enabled

Task Manager ::> left hand side Performance ::> see if Vertualization is Enabled

If not, then go BIOS to enable it

### Check if Windows Subsystem for Linux is enabled

search "Windows Features", chek the checkbox to enable it

## Download Installer and Install

Docker Desktop Installer.exe

## Power Shell, Open as Admin

wsl --update

```
PS C:\> wsl --update
Installing: Windows Subsystem for Linux
[==========================59.0%===


PS C:\> wsl --update
Installing: Windows Subsystem for Linux
Windows Subsystem for Linux has been installed.

```

- Login

https://hub.docker.com/

oopsmails@gmail.com

S5s

## Power Shell, checking

wsl -l -v

```
PS C:\> docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
PS C:\> wsl -l -v
  NAME                   STATE           VERSION
* docker-desktop         Running         2
  docker-desktop-data    Running         2
PS C:\>


```

wsl -l -o

to list all linux choices

wsl --install -d Ubuntu

```
PS C:\> wsl --install -d Ubuntu
Installing: Ubuntu
Ubuntu has been installed.
Launching Ubuntu...
Installing, this may take a few minutes...
Please create a default UNIX user account. The username does not need to match your Windows username.
For more information visit: https://aka.ms/wslusers
Enter new UNIX username: albert
New password:
Retype new password:
passwd: password updated successfully
Installation successful!
```

mkdir www
cd www

docker is NOT under this Ubuntu yet!

Go to docker desktop ::> Settings ::> Resources ::> WSL Integration ::> Enable Ubuntu ::> Apply and restart

Go back to Ununtu, docker is now available.

mkdir node
cd node

explorer.exe .

code node/

Choose VS code Terminal type ... wsl ...
