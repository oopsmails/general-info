# Docker Useful Hacks: Cheat Sheet For Beginners to Expert

https://scriptcrunch.com/docker-useful-hacks/

## Docker Useful Hacks

- Run docker without sudo

`usermod -aG docker ${USER}  `

Execute the following command if you do not want to restart the terminal

`newgrp docker`

- Connecting to Docker Container

```
docker exec -it  <container-name>  bash
docker exec -it  <container-name>  sh
```

- Remove Unused Docker Objects

The best way to remove all stopped, dangling and unused networks is through prune command.

docker system prune

You can remove all unused docker volumes using volume prune command.

docker system prune --volumes

- Stopping all containers at once

docker stop $(docker ps -a -q)

To forcefully stop,

docker stop -f $(docker ps -a -q)

- Removing all containers at once

docker rm $(docker ps -a -q)

To forcefully remove,

docker rm -f $(docker ps -a -q)


- Removing all docker images at once

docker rmi $(docker images -q)

To forcefully remove,

docker rmi -f $(docker images -q)


- Assign a name to the container

```
docker run -d --name <name-of-container> ubuntu/apache

Spring Boot:

docker run -p8080:8080 oopsmails/mockbackend:v1 --spring.profiles.active=dev

docker run -p8080:8080 oopsmails/mockbackend:v1 --spring.config.location=/home/springboot/config

```

- List all running containers

docker ps

- List all containers

docker ps -a

- List all images

docker images

- To inspect image

docker inspect oopsmails/mockbackend:v1

- Remove unwanted/intermediate/untagged images

Most of the times while building new images, there is a possibility of untagged, intermediate images that might eat up your disk space as well as increases your images list. To clean up those images, you can use the following command.

`docker rmi $(docker images --filter "dangling=true" -q --no-trunc)`


## https://medium.com/the-code-review/top-10-docker-commands-you-cant-live-without-54fb6377f481


### docker-compose

#### docker-compose up

#### docker-compose down

Usage: down [options]

Options:
    --rmi type              Remove images. Type must be one of:
                              'all': Remove all images used by any service.
                              'local': Remove only images that don't have a
                              custom tag set by the `image` field.
    -v, --volumes           Remove named volumes declared in the `volumes`
                            section of the Compose file and anonymous volumes
                            attached to containers.
    --remove-orphans        Remove containers for services not defined in the
                            Compose file
    -t, --timeout TIMEOUT   Specify a shutdown timeout in seconds.
                            (default: 10)


#### docker-compose stop

Usage: stop [options] [SERVICE...]

Options:
  -t, --timeout TIMEOUT      Specify a shutdown timeout in seconds.
                             (default: 10)
Stops running containers without removing them. They can be started again with docker-compose start




### general:

```
docker login  
docker ps -a  
docker images  
docker build  
docker run -d -p  
docker push  
docker rm  
docker rmi  

- removing all the unused Images
docker rmi $(docker images | grep '^<none>' | awk '{print $3}')

docker rmi $(docker images | awk '/^<none>/{print $3}')

docker volume ls -qf dangling=true
docker volume ls
docker volume rm $(docker volume ls -qf dangling=true)


docker volume prune  

docker system prune

WARNING! This will remove:
  - all stopped containers
  - all networks not used by at least one container
  - all dangling images
  - all dangling build cache

Are you sure you want to continue? [y/N]



docker container exec -it my_mysql /bin/bash
docker container exec -it wiremock-docker_wiremock_1 /bin/bash

docker-compose up
docker-compose start
docker-compose down
docker-compose stop



-  kill all running containers with 

docker kill $(docker ps -q)

- delete all stopped containers with 

docker rm $(docker ps -a -q)

- delete all images with 

docker rmi $(docker images -q)

- view logs


# -t display timestamp 
# -f track display log 
# --tail the last line number, default all 
# --since specify the start time, such as: 30m "2020-05-22" 

docker logs -t -f [CONTAINER ID]/ [NAMES]
docker logs -t -f --tail=100 --since=30m [CONTAINER ID]/ [NAMES]
docker logs -t -f --tail=100 --since= " 2020-05-22 " [cONTAINER ID] / [NAMES]

- view details of the container 
Docker Inspect [cONTAINER ID] / [NAMES]

```


### docker ps 

—  Lists running containers. Some useful flags include: -a / -all for all containers (default shows just running) and —-quiet /-q to list just their ids (useful for when you want to get all the containers).


### docker pull

 —  Most of your images will be created on top of a base image from the Docker Hub registry. Docker Hub contains many pre-built images that you can pull and try without needing to define and configure your own. To download a particular image, or set of images (i.e., a repository), use docker pull.


### docker build 

—  The docker build command builds Docker images from a Dockerfile and a “context”. A build’s context is the set of files located in the specified PATH or URL. Use the -t flag to label the image, for example docker build -t my_container . with the . at the end signalling to build using the currently directory.


### docker run 

—  Run a docker container based on an image, you can follow this on with other commands, such as -it bash to then run bash from within the container. Also see Top 10 options for docker run — a quick reference guide for the CLI command. docker run my_image -it bash


### docker logs

 —  Use this command to display the logs of a container, you must specify a container and can use flags, such as --follow to follow the output in the logs of using the program. docker logs --follow my_container


### docker volume ls 

—  ab0c55cf5818This lists the volumes, which are the preferred mechanism for persisting data generated by and used by Docker containers.


### docker rm 

—  Removes one or more containers. docker rm my_container


### docker rmi 

—  Removes one or more images. docker rmi my_image


### docker stop 

—  Stops one or more containers. docker stop my_container stops one container, while docker stop $(docker ps -a -q) stops all running containers. A more direct way is to use docker kill my_container, which does not attempt to shut down the process gracefully first.

### Use them together 

for example to clean up all your docker images and containers:
-  kill all running containers with docker kill $(docker ps -q)

- delete all stopped containers with docker rm $(docker ps -a -q)

- delete all images with docker rmi $(docker images -q)


### docker jenkins no space left on device

https://jhooq.com/docker-error-no-space-left/


