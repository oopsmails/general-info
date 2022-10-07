
# Ubuntu 20.04: install Docker

## Install Ubuntu Software

sudo apt install gnome-software

## Install Docker

Search "Docker"

Docker container runtime

## Running Docker as normal user

By default, Docker is only accessible with root privileges (sudo). If you want to use docker as a regular user, you need to add your user to the docker group.

```
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap disable docker
sudo snap enable docker
```

Warning: if you add your user to the docker group, it will have similar power as the root user. For details on how this impacts security in your system, see https://docs.docker.com/engine/security/#docker-daemon-attack-surface


### Docker Compose

Installing above Docker will also install Docker-Compose.

```
albert@albert-Lenovo-ubuntu:~$ docker -v
Docker version 20.10.14, build a224086349
albert@albert-Lenovo-ubuntu:~$ docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
albert@albert-Lenovo-ubuntu:~$ docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE

albert@albert-Lenovo-ubuntu:~$ docker-compose -v
docker-compose version 1.29.2, build unknown
```


