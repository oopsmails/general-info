
# Kubuntu: 202103

## Install Docker CE

### Remove any older installations of Docker that may be on your system:

`sudo apt remove docker docker-engine docker.io`

### Make sure you have the necessary packages to allow the use of Docker’s repository:

`sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg`

### Add Docker’s GPG key:

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`

### Verify the fingerprint of the GPG key:

`sudo apt-key fingerprint 0EBFCD88`

You should see output similar to the following:

```
pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
```

### Add the stable Docker repository:

`sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`

Note

For Ubuntu 19.04, if you get an E: Package 'docker-ce' has no installation candidate error, this is because the stable version of docker is not yet available. Therefore, you will need to use the edge / test repository.

`sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge test"`


### Update your package index and install Docker CE:

```
sudo apt update
sudo apt install docker-ce

```

### Add your limited Linux user account to the docker group:

`sudo usermod -aG docker $USER`

Note

After entering the usermod command, you will need to close your SSH session and open a new one for this change to take effect.


### Check that the installation was successful by running the built-in “Hello World” program:

`docker run hello-world`


