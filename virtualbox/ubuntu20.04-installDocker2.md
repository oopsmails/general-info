
# Ubuntu 20.04: install Docker

https://docs.docker.com/engine/install/ubuntu/


## Uninstall old versions
Older versions of Docker were called docker, docker.io, or docker-engine. If these are installed, uninstall them:

sudo apt-get remove docker docker-engine docker.io containerd runc

## Install using the repository

## Install from a package

If you cannot use Docker’s repository to install Docker Engine, you can download the .deb file for your release and install it manually. You need to download a new file each time you want to upgrade Docker.

- Go to https://download.docker.com/linux/ubuntu/dists/, choose your Ubuntu version, then browse to pool/stable/, choose amd64, armhf, arm64, or s390x, and download the .deb file for the Docker Engine version you want to install.

- Install Docker Engine, changing the path below to the path where you downloaded the Docker package.

```
sudo dpkg -i /path/to/package.deb
```

The Docker daemon starts automatically.

Verify that Docker Engine is installed correctly by running the hello-world image.

```
sudo docker run hello-world
```

This command downloads a test image and runs it in a container. When the container runs, it prints a message and exits.

Docker Engine is installed and running. The docker group is created but no users are added to it. You need to use sudo to run Docker commands. Continue to Post-installation steps for Linux to allow non-privileged users to run Docker commands and for other optional configuration steps.

## Post-installation Steps

https://docs.docker.com/engine/install/linux-postinstall/


### Manage Docker as a non-root user
The Docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root and other users can only access it using sudo. The Docker daemon always runs as the root user.

If you don’t want to preface the docker command with sudo, create a Unix group called docker and add users to it. When the Docker daemon starts, it creates a Unix socket accessible by members of the docker group.

**Warning**

The docker group grants privileges equivalent to the root user. For details on how this impacts security in your system, see Docker Daemon Attack Surface.

Note:

To run Docker without root privileges, see Run the Docker daemon as a non-root user (Rootless mode).

To create the docker group and add your user:

Create the docker group.

 sudo groupadd docker
Add your user to the docker group.

 sudo usermod -aG docker $USER
Log out and log back in so that your group membership is re-evaluated.

If testing on a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.

On a desktop Linux environment such as X Windows, log out of your session completely and then log back in.

On Linux, you can also run the following command to activate the changes to groups:

 newgrp docker 
Verify that you can run docker commands without sudo.

 docker run hello-world
This command downloads a test image and runs it in a container. When the container runs, it prints a message and exits.

If you initially ran Docker CLI commands using sudo before adding your user to the docker group, you may see the following error, which indicates that your ~/.docker/ directory was created with incorrect permissions due to the sudo commands.

WARNING: Error loading config file: /home/user/.docker/config.json -
stat /home/user/.docker/config.json: permission denied
To fix this problem, either remove the ~/.docker/ directory (it is recreated automatically, but any custom settings are lost), or change its ownership and permissions using the following commands:

 sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
 sudo chmod g+rwx "$HOME/.docker" -R


### Configure Docker to start on boot

Most current Linux distributions (RHEL, CentOS, Fedora, Debian, Ubuntu 16.04 and higher) use systemd to manage which services start when the system boots. On Debian and Ubuntu, the Docker service is configured to start on boot by default. To automatically start Docker and Containerd on boot for other distros, use the commands below:

```
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

To disable this behavior, use disable instead.

```
sudo systemctl disable docker.service
sudo systemctl disable containerd.service
```
If you need to add an HTTP Proxy, set a different directory or partition for the Docker runtime files, or make other customizations, see customize your systemd Docker daemon options.



