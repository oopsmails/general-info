
# Install Docker on Elementary OS:

## 20200906: update and install docker-compose

`sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose`


## Not used: removed from snap store because not community edition.
sudo apt update
sudo apt install snapd

sudo snap install docker

sudo snap remove docker

## install docker ce:

https://blog.avojak.com/2019/01/18/installing-docker-on-elementary-os/

### remove previous if any,

```
sudo apt-get remove \
    docker \
    docker-engine \
    docker.io \
    containerd \
    runc
```

### Install Docker CE via the Docker repository

#### "Install packages to allow apt to use a repository over HTTPS:" [1]

```
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
```

#### Add Docker's GPG key, and verify that you have the key with the fingerprint 

9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88:


`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`

`sudo apt-key fingerprint 0EBFCD88`

pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]


#### Add the stable Docker repository. The key here is to use bionic, because elementary OS 5.0 Juno is build on Ubuntu 18.04 LTS "Bionic Beaver".

`sudo apt-add-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"`


#### Install Docker CE

```
sudo apt-get update
sudo apt-get install docker-ce
```

#### Test it out!

sudo docker run hello-world


#### (Optional) Add your user to the docker group to avoid typing sudo for every docker command:

```
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG

???
alice sudo docker
```

====================================


https://blog.avojak.com/2019/01/18/installing-docker-on-elementary-os/


https://www.takeexams.co.in/tutorial/linux/install-docker-in-elementry-os


#### Update Package Index
So first of all we will update package index for fetching latest update from sources for that we will use this command.

`sudo apt-get update`

#### Check Debian Flavour
Now in second step we will check that which dists of ubuntu we are using to check that, list the contents of sources.list  file using command `cat /etc/apt/sources.list`. Here is my sources.list file contents, I am using elementry os hera.

#### Install Transport https
Now install some important packages like curl, transport-https, software-properties-common, gnupg on your system using the following command.

```
root@hp-notebook:~$ sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common
```

#### Add Docker Official gpg key
Now run this command on your system to add docker official gpg keys.

`root@hp-notebook:~$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`


#### Setting up stable repository
Now we will setup a stable repository in apt directory using following command, and update the source package list.

```
 root@hp-notebook:~$ sudo add-apt-repository \
  	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   	bionic \
   	stable"
root@hp-notebook:~$ sudo apt-get update
```

In above command you should notice i have used bionic because in sources.list file i am using ubuntu bionic official package for elemetary os hera.

#### Install Docker and Docker-Compose
In this step we will install docker and docker-compose. To install docker and docker-compose use the following command.

`root@hp-notebook:~$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose`

#### Check Docker Version
After sucessfull installation check installed version of docker and docker-compose using following commands.

```
root@hp-notebook:~$ docker -v
Docker version 19.03.6, build 369ce74a3c
root@hp-notebook:~$ docker-compose -v
docker-compose version 1.17.1, build unknown
```






