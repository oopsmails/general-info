# Update Docker and docker-compose


## Update docker

albert@albert-mint20:~$ d -v
Docker version 20.10.7, build f0df350


sudo apt-get --only-upgrade install docker-ce docker-ce-cli containerd.io

albert@albert-mint20:~$ d -v
Docker version 20.10.18, build b40c2f6

## Update docker-compose

albert@albert-mint20:~$ dc -v
docker-compose version 1.25.0, build unknow


### First, remove the old version:

- If installed via apt-get

sudo apt-get remove docker-compose     <------------------ Using this


- If installed via curl

sudo rm /usr/local/bin/docker-compose
or
sudo rm /usr/bin/docker-compose


- If installed via pip

pip uninstall docker-compose

### Then find the newest version on the release page at GitHub or by curling the API and extracting the version from the response using grep or jq (thanks to dragon788, frbl, and Saber Hayati for these improvements):

```
# curl + grep
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')

albert@albert-mint20:~$ VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')
albert@albert-mint20:~$ 
albert@albert-mint20:~$ 
albert@albert-mint20:~$ echo $VERSION



# curl + jq
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
Finally, download to your favorite $PATH-accessible location and set permissions:

```

###  install docker-compose

```
DESTINATION=/usr/local/bin/docker-compose

or 

DESTINATION=/usr/bin/docker-compose

sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION

```

### chmod

```
sudo chmod 755 $DESTINATION
```

### verify

albert@albert-mint20:~$ dc -v
Docker Compose version v2.11.1



