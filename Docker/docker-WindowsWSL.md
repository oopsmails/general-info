# Install Docker Desktop on Windows

## Switching Between WSL2 and Virtual Box

Running both VirtualBox and WSL 2 on the same system can sometimes lead to compatibility issues due to conflicts in virtualization technologies. WSL 2 uses Hyper-V for virtualization, and VirtualBox also uses its own virtualization technology. Enabling Hyper-V for WSL 2 can interfere with the functioning of VirtualBox.

Here are a few steps you can take to potentially resolve the issue:

1. Disable Hyper-V to Use VirtualBox:

Open PowerShell as an administrator.
Run the following command to disable Hyper-V:

```
bcdedit /set hypervisorlaunchtype off
```

Restart your computer.
After restarting, VirtualBox should work, but keep in mind that WSL 2 won't be able to run until you re-enable Hyper-V.
Re-enable Hyper-V to Use WSL 2:

2. If you need to use WSL 2 again and have disabled Hyper-V, you can re-enable it by opening PowerShell as an administrator and running:

```
bcdedit /set hypervisorlaunchtype auto
```

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


wsl.exe --shutdown Ubuntu

wsl.exe --list

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

## Ubuntu bash

\\wsl.localhost\Ubuntu\home\albert\.profile

```

alias d="docker "
alias dc="docker-compose "
alias lsa="ls -all"

```

## Run MySql Docker Image

sudo docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=your_password -p 3306:3306 -v /path/to/mysql_data:/var/lib/mysql mysql

- will NOT work
  sudo docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=your_password -p 3306:3306 -v /c/docker-data/mysql:/var/lib/mysql mysql

C:\docker-data\mysql

it is actually as "/mnt/c/...", not "/c/"

- will work

in Ubuntu bash, mkdir, /home/albert/docker-data/mysql, this is actually, \\wsl.localhost\Ubuntu\home\albert\docker-data\mysql

### USE THIS

docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -v /home/albert/docker-data/mysql:/var/lib/mysql mysql

```
albert@lenovo-small:~/docker-data/mysql$ docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -v /home/albert/docker-data/mysql:/var/lib/mysql mysql

albert@lenovo-small:~/docker-data/mysql$ d ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                               NAMES
944f95c2c99d   mysql     "docker-entrypoint.s…"   59 seconds ago   Up 58 seconds   0.0.0.0:3306->3306/tcp, 33060/tcp   mysql-container


```

### Connect to container

sudo docker exec -it mysql mysql -uroot -p

### DBeaver

- need allowPublicKeyRetrieval

jdbc:mysql://localhost:3306/?allowPublicKeyRetrieval=true

### Clean up

d stop mysql-container

d ps -a

d rm mysql-container

d rmi mysql

## Run MSSQL Docker

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=sa' -p 1433:1433 --name sql_server_container -d mcr.microsoft.com/mssql/server

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourStrongPassword' -p 1433:1433 --name sql_server_container -v $(pwd)/mssql-data:/var/opt/mssql -d mcr.microsoft.com/mssql/server

### Setup Trying

- Don't use too simple password.

```
Debugging, NOT use -d option to see logs .....

2023-07-04 14:30:07.77 spid35s     ERROR: Unable to set system administrator password: Password validation failed. The password does not meet SQL Server password policy requirements because it is too short. The password must be at least 8 characters..

```

---- docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Test123!' -p 1433:1433 --name mssql -v /home/albert/docker-data/mssql:/var/opt/mssql -d mcr.microsoft.com/mssql/server

---- **no volume? data still persist after restarting container** ... default saved in container ... but not recommanded!

docker run --name mssql -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Test123!" -e "MSSQL_AGENT_ENABLED=true" -p 1433:1433 -d mcr.microsoft.com/mssql/server

---- with volume, error, even using sudo ...
docker run --name mssql -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Test123!" -e "MSSQL_AGENT_ENABLED=true" -p 1433:1433 -v /home/albert/docker-data/mssql:/var/opt/mssql -d mcr.microsoft.com/mssql/server

sudo docker run --name mssql -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Test123!" -e "MSSQL_AGENT_ENABLED=true" -p 1433:1433 -v /home/albert/docker-data/mssql:/var/opt/mssql -d mcr.microsoft.com/mssql/server

```
/opt/mssql/bin/sqlservr: Error: The system directory [/.system] could not be created. File: LinuxDirectory.cpp:420 [Status: 0xC0000022 Access Denied errno = 0xD(13) Permission denied]


albert@lenovo-small:~/docker-data$ chmod 777 mssql/

```

### USE THIS

--- Using this after chmod

docker run --name mssql -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Test123!" -e "MSSQL_AGENT_ENABLED=true" -p 1433:1433 -v /home/albert/docker-data/mssql:/var/opt/mssql -d mcr.microsoft.com/mssql/server

### DBeaver

jdbc:sqlserver://;serverName=localhost;databaseName=master

### Connect to container

sudo docker exec -it mssql bash
