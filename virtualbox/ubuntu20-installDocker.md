
# Ubuntu 20.04: install Docker

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04


## Step 1 — Installing Docker

**Note**: may try apt-get in future

- First, update your existing list of packages:

`sudo apt update`

`sudo apt-get update -y` 
 
- Next, install a few prerequisite packages which let apt use packages over HTTPS:

`sudo apt install apt-transport-https ca-certificates curl software-properties-common`

`sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common `

 
- Then add the GPG key for the official Docker repository to your system:

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`

 
- Add the Docker repository to APT sources:

`sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"`

`sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`

 
- Next, update the package database with the Docker packages from the newly added repo:

`sudo apt update`

`sudo apt-get update -y`
 
- Make sure you are about to install from the Docker repo instead of the default Ubuntu repo:

`apt-cache policy docker-ce`
 
You’ll see output like this, although the version number for Docker may be different:

```
Output of apt-cache policy docker-ce
docker-ce:
  Installed: (none)
  Candidate: 5:19.03.9~3-0~ubuntu-focal
  Version table:
     5:19.03.9~3-0~ubuntu-focal 500
        500 https://download.docker.com/linux/ubuntu focal/stable amd64 Packages
 ```

Notice that docker-ce is not installed, but the candidate for installation is from the Docker repository for Ubuntu 20.04 (focal).

- Finally, install Docker:

`sudo apt install docker-ce`

`sudo apt-get install docker-ce docker-ce-cli containerd.io -y
`
 
Docker should now be installed, the daemon started, and the process enabled to start on boot. 

Check that it’s running:

`sudo systemctl status docker`
 
The output should be similar to the following, showing that the service is active and running:

Output
```
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2020-05-19 17:00:41 UTC; 17s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 24321 (dockerd)
      Tasks: 8
     Memory: 46.4M
     CGroup: /system.slice/docker.service
             └─24321 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```
Installing Docker now gives you not just the Docker service (daemon) but also the docker command line utility, or the Docker client. We’ll explore how to use the docker command later in this tutorial.

- Start and Enable Docker Daemon Service

```
sudo systemctl enable docker.service
sudo systemctl start docker.service

```
## Step 2 — Executing the Docker Command Without Sudo (Optional)

By default, the docker command can only be run the root user or by a user in the docker group, which is automatically created during Docker’s installation process. If you attempt to run the docker command without prefixing it with sudo or without being in the docker group, you’ll get an output like this:
```
Output
docker: Cannot connect to the Docker daemon. Is the docker daemon running on this host?.
See 'docker run --help'.
```

- If you want to avoid typing sudo whenever you run the docker command, add your username to the docker group:


```
sudo usermod -aG docker ${USER}

sudo usermod -aG docker albert
```

 
To apply the new group membership, log out of the server and back in, or type the following:
```
su - ${USER}
su - albert

```
You will be prompted to enter your user’s password to continue.

Confirm that your user is now added to the docker group by typing:

`id -nG`
 
```
Output
albert sudo docker

```

- If you need to add a user to the docker group that you’re not logged in as, declare that username explicitly using:

`sudo usermod -aG docker username`
 
The rest of this article assumes you are running the docker command as a user in the docker group. If you choose not to, please prepend the commands with sudo.


**May only work after restart !!!**

## docker-compose

https://phoenixnap.com/kb/install-docker-compose-on-ubuntu-20-04

### Download and install

```
sudo apt update

sudo apt upgrade

sudo apt install curl


sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#The command instructs the system to save the file in the /usr/local/bin/ directory, under the name docker-compose.

- try in future
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


```

Change File Permission

sudo chmod +x /usr/local/bin/docker-compose

sudo docker–compose --version


Note: If the command docker-compose fails after installation, check your path. You can also create a symbolic link to /usr/bin or any other directory in your path.

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

### Uninstall Docker Compose on Ubuntu

sudo rm /usr/local/bin/docker-compose

sudo apt remove docker-compose

sudo apt autoremove









