
# Jenkins Docker: Docker in Docker

- Ref:

    - Run Jenkins In Docker Using Docker Compose With Persistent Volumes

https://digitalavenue.dev/Run-Jenkins-On-Docker-Compose/

## Run Jenkins on a Docker Container Using Docker Compose ( make things faster and reusable)

- version

- Where is the Jenkins Data in Docker Container?
```
docker exec jenkins-server ls -l /var/jenkins_home
```
- Where is the Jenkins Data in Docker Host?
```
docker volume inspect jenkins-data
```

According to the output, You can see the “JENKINS_HOME” directory is mounted on “/var/lib/docker/volumes/jenkins-data/_data” docker volume. This means your data is persistent under that directory, and it is available even container is deleted. So, data will remain on the Docker host.

```
cd /home/albert/Documents/sharing/github/general-info/Jenkins/jenkins-docker-202111/

docker-compose up -d

docker-compose -f /home/albert/Documents/sharing/github/general-info/Jenkins/jenkins-docker-202111/docker-compose.yml up -d

```

- First run using 8080:8080

docker exec jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword

admin/admin

New Item (Hello World) :: Freestyle project :: Build section :: Add build step :: Execute shell :: echo "Hello, World!"  

Configured URL as: http://albert-mint20:8080/ and tested using "Hello World"

- Second run, changed 8080:8080 to 7080:8080 in docker-compose.yml

Open the url as:

http://albert-mint20:7080/ 


## Run Jenkins on a Docker Container Manually (Not used but nice to know)

### Create Docker Bridge Network

Make sure docker engine is installed

`sudo docker network create jenkins-net`

### Create Docker Volumes

I will create a Docker volume to store the “JENKINS_HOME” directory, which use to mount into the docker host machine.

Docker Host	  |   Jenkins Container  
"----------------------------------"  
jenkins-data  |   /var/jenkins_home


`sudo docker volume create jenkins-docker-data`

### Start Jenkins Server Container

```
sudo docker container run --name jenkins-server --detach --restart unless-stopped --network jenkins-net --hostname jenkins --publish 8080:8080 --volume jenkins-data:/var jenkins_home jenkins/jenkins:lts

```

### Access Jenkins Console
```
http://<DOCKER-HOST-IP>:8080/
```
### Get Jenkins Init Password

```
sudo docker exec jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword

or 

docker container exec [CONTAINER ID or NAME] sh -c "cat /var/jenkins_home/secrets/initialAdminPassword"
```

## Comments:

- If you are running jenkins on docker, make sure you exposed the range port.  
$ docker run -d –expose=32768-60999 …..

- I have 2 questions regarding its practical value:


1. seems all docker container will be running on the same VM (docker host), correct? If so if the VM resource is limited then it can’t really scale out
2. jenkins agent already support multiple “executors”, so the node can support multiple executors already?

A: 
1. if you want to scale agent with the container, you should consider using Kubernetes based distributed agents.

2. Even though Jenkins supports executors, Docker-based agents will give you isolated environments for each build. For example, different java versions, python versions, other utilities. In some cases, we have to have different agent VMs for different use cases. We can avoid it by having dedicated container images for specific build use cases.

- how to set Docker Host IP in step-5.

i’m using below command to run docker image:
docker run -d -p 4243:22 –name udockerslave bibinwilson/jenkins-slave:latest
it binds docker at 0.0.0.0:4243,i can use -p 127.0.0.1:4243:22 but can’t use any other private ip like -p 192.168.33.10:4243:22, please suggest!

You can use the private IP. You need to expose the docker API on all interfaces. It is explained in this blog https://scriptcrunch.com/enable-docker-remote-api/








