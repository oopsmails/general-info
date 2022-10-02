# Use a MSSQL Server 2017 Docker Container with Full-Text Search Support

## Dockerfile

By default, there is currently no Full-Text Search Support in the Docker Images for Microsoft SQL Server 2017 or 2019 by Microsoft. The only option currently available is to create your own Docker Image, which includes Full-Text Search in the form of the MSSQL Agent.

Fortunately, others have already thought about it: the Microsoft MSSQL Docker samples shows a Dockerfile that provides full-text support.

```
## Source: https://github.com/Microsoft/mssql-docker/blob/master/linux/preview/examples/mssql-agent-fts-ha-tools/Dockerfile

# mssql-agent-fts-ha-tools
# Maintainers: Microsoft Corporation (twright-msft on GitHub)
# GitRepo: https://github.com/Microsoft/mssql-docker

# Base OS layer: Latest Ubuntu LTS
FROM ubuntu:16.04

# Install prerequistes since it is needed to get repo config for SQL server
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -yq curl apt-transport-https && \
    # Get official Microsoft repository configuration
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list | tee /etc/apt/sources.list.d/mssql-server.list && \
    apt-get update && \
    # Install SQL Server from apt
    apt-get install -y mssql-server && \
    # Install optional packages
    apt-get install -y mssql-server-ha && \
    apt-get install -y mssql-server-fts && \
    # Cleanup the Dockerfile
    apt-get clean && \
    rm -rf /var/lib/apt/lists

# Run SQL Server process
CMD /opt/mssql/bin/sqlservr

```


## Create the image
Save this snippet into a Dockerfile and create an image with a tag of your choice. For example:

```
-- docker build -t benjaminabt/mssql-fts:2017-ubuntu .

docker build -t albert/mssql-fts:2017-ubuntu .

docker build -f Dockerfile-mssql2017-fts -t oopsmails/mssql2017fts:v1 .

```

After a few minutes, depending on how fast your internet and your PC is, your image should be listed under the command docker images.

## Run the image
The Docker Container can now be created. It is a best to assign a name directly, so that starting and stopping later is easier. Make sure to include the additional argument -e "MSSQL_AGENT_ENABLED=true". This also starts the agent that provides full-text support.

```
-- docker run --name mssql -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourPass123#" -e "MSSQL_AGENT_ENABLED=true" -p 1401:1433 -d benjaminabt/mssql-fts:2017-ubuntu

docker run --name mssql -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Test123!" -e "MSSQL_AGENT_ENABLED=true" -p 1401:1433 -d oopsmails/mssql2017fts:v1

```

In this case, the container can be reached via port 1401.

## To start the Docker Container 

just type `docker start mssql` 

to stop it just use 

`docker stop mssql`

Note: on Windows, the command line uses double quotes("). On Linux, single quotes (') are used.

The MSSQL Server 2017 Docker Container can now be used with Full-Text Search Support :-)


### Connection

intellij, DB Navigator plugin,

Type: Generic

jdbc:sqlserver://localhost:1401;encrypt=true;trustServerCertificate=true; 

/home/albert/Documents/programs/JARs/sqljdbc_11.2/enu/mssql-jdbc-11.2.0.jre11.jar

sa/Test123!

### Upload to dockerhub

- error:

```
albert@albert-mint20:~/Documents/docker$ docker push albert/mssql-fts:2017-ubuntu
The push refers to repository [docker.io/albert/mssql-fts]
......... 
be96a3f634de: Preparing 
denied: requested access to the resource is denied

```
- Resaon:


You need to include the namespace for Docker Hub to associate it with your account.
The namespace is the same as your Docker Hub account name.
You need to rename the image to YOUR_DOCKERHUB_NAME/docker-whale.

- Pushed with oopsmails/

docker login 

docker push oopsmails/mssql2017fts:v1


## Another way to get MSSQL with FTS. 20221002: still cannot solve the problem

- The docker image above is with one problem

sometimes, after restarting VM, got error, "The file archive /opt/mssql/lib/sqlserver.sfp is invalid".

My VM, if *docker stop mssql* before shutting down VM, then it is ok next time.

But, other VMs, couldn't resolve the problem


- Exploring add FTS on office MS SQL docker image

```
docker pull mcr.microsoft.com/mssql/server:2019-CU18-ubuntu-20.04


docker run --name mssql2 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Test123!" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-CU18-ubuntu-20.04

d exec -it mssql2 bash <--------------------- this will login as "mssql" user, NOT root

docker exec -it --user root mssql2 "bash" <--------------------- this will login as "root" user

--- following from Dockerfile
RUN export DEBIAN_FRONTEND=noninteractive &&
apt-get update --fix-missing &&
apt-get install -y gnupg2 &&
apt-get install -yq curl apt-transport-https &&
curl https://packages.microsoft.com/keys/microsoft.asc | tac | tac | apt-key add - &&
curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list | tac | tac | tee /etc/apt/sources.list.d/mssql-server.list &&
apt-get update

;# Install optional packages. Comment out the ones you don't need
;# RUN apt-get install -y mssql-server-agent
;# RUN apt-get install -y mssql-server-ha
RUN apt-get install -y mssql-server-fts


--- Run following in mssql server bash

export DEBIAN_FRONTEND=noninteractive &&
apt-get update --fix-missing &&
apt-get install -y gnupg2 &&
apt-get install -yq curl apt-transport-https &&
curl https://packages.microsoft.com/keys/microsoft.asc | tac | tac | apt-key add - &&
curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list | tac | tac | tee /etc/apt/sources.list.d/mssql-server.list &&
apt-get update

apt-get install -y mssql-server-fts

```

Then, restart ms sql, it will be with FTS package ....

## Try docker-compose, though, still, 20221002: cannot solve the problem

https://github.com/infinity-arc/mssql-docker-compose.git

https://infinity-arc.github.io/mssql-docker-compose/


- error: 

"The repository 'http://security.ubuntu.com/ubuntu groovy-security Release' does not have a Release file"

- solution: add following in Dockerfile

```
cp  /etc/apt/sources.list /etc/apt/sources.list.bak
sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
```

run `docker-compose up -d` in proper dir.


## Refs

https://schwabencode.com/blog/2019/10/27/MSSQL-Server-2017-Docker-Full-Text-Search


