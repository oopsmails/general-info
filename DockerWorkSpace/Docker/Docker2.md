Docker.txt

====> 

==> Error:

Running pre-create checks...
(default) No default Boot2Docker ISO found locally, downloading the latest release...
Error with pre-create check: "failure getting a version tag from the Github API response (are you getting rate limited by Github?)"
Looks like something went wrong in step 'Checking if machine default exists'... Press any key to continue...


The workaround is that the user has to manually copy the boot2docker.iso from C:\Program Files\Docker Toolbox to the cache location.

-- Solution:

The workaround is that the user has to manually copy the boot2docker.iso from C:\Program Files\Docker Toolbox to the cache location, e.g, C:\Users\liuziy8\.docker\machine\cache



==> Error:
$ docker run -p 27017:27017 mongo
Unable to find image 'mongo:latest' locally
C:\Program Files\Docker Toolbox\docker.exe: Error response from daemon: Get https://registry-1.docker.io/v2/library/mongo/manifests/latest:
Get https://auth.docker.io/token?scope=repository%3Alibrary%2Fmongo%3Apull&service=registry.docker.io: x509: certificate signed by unknown a
uthority.
See 'C:\Program Files\Docker Toolbox\docker.exe run --help'.

-- Solution:


1. Get real certificate!
The certificate, tls-ca-bundle.pem, is in C:\Users\liuziy8\certs <----------------------- this is real cert

2. Copy to /var/lib/boot2docker/certs/
docker-machine ssh default
docker@default:~$ sudo -s
mkdir /var/lib/boot2docker/certs
cp /c/Users/my.username/certs/*.pem /var/lib/boot2docker/certs/ <------------------------ this is real fix

3. Restart default. Don't use Oracle VM VirtualBox, instead, always use "Docker Quickstart Terminal"
docker-machine restart default


4. (Could be optional), make bootlocal.sh

::> following should be enough
docker-machine ssh default
root@default:/home/docker# mkdir /var/lib/boot2docker/certs
root@default:/home/docker# cp /c/Users/my.username/certs/*.pem /var/lib/boot2docker/certs/

::> bootlocal.sh is used before docker machine starts ...
touch /var/lib/boot2docker/bootlocal.sh && chmod +x /var/lib/boot2docker/bootlocal.sh
vi /var/lib/boot2docker/bootlocal.sh

bootlocal.sh content:

#!/bin/sh

mkdir -p /etc/docker/certs.d && cp certs/certificate.pem /etc/docker/certs.d

docker-machine restart default

::> Here is why we know this bootlocal.sh is run before docker machine starts

docker@default:~$ sudo -s
root@default:/mnt/sda1/var/lib/boot2docker# ls /opt
bootlocal.sh   bootscript.sh  bootsync.sh    shutdown.sh    tcemirror
root@default:/mnt/sda1/var/lib/boot2docker# cat bootscript.sh
cat: can't open 'bootscript.sh': No such file or directory
root@default:/mnt/sda1/var/lib/boot2docker# cat /opt/bootscript.sh

------------

# Allow local HD customisation
if [ -e /var/lib/boot2docker/bootlocal.sh ]; then
    /bin/sh /var/lib/boot2docker/bootlocal.sh > /var/log/bootlocal.log 2>&1 &
    echo "------------------- ran /var/lib/boot2docker/bootlocal.sh"
fi

-------------

====> another hint, .crt should be OK as well.

https://github.com/docker/machine/issues/1799


I'm running Windows 7 + VirtualBox (v5.2.6) +Docker Toolbox (Boot2Docker version 18.02.-ce) and had the same issue.
For example, when trying to run a container I get the following error:
docker run ubuntu /bin/echo 'Hello world'
Unable to find image 'ubuntu:latest' locally
C:\Program Files\Docker Toolbox\docker.exe: Error response from daemon: Get https://registry-1.docker.io/v2/: x509: certificate signed by unknown authority.
See 'C:\Program Files\Docker Toolbox\docker.exe run --help'.

The following solution worked for me:

Login to the default docker VM
Download your Company root certificates
Create a new dir:
sudo mkdir /var/lib/boot2docker/certs
Copy your Company root certificates to the newly created folder:
sudo cp Root-Ca1.crt Root-Ca2.crt /var/lib/boot2docker/certs
Reboot default VM
Now it's pulling the image :)



======================================================

====> Other useful commands ....



====================================================================

https://docker-curriculum.com/


-----
docker run hello-world
docker pull busybox
docker run busybox
docker run busybox echo "hello from busybox"

docker ps -a

-----

docker run prakhar1989/static-site
docker run -d -P --name static-site prakhar1989/static-site
docker port static-site

	80/tcp -> 0.0.0.0:32769
	443/tcp -> 0.0.0.0:32768

http://localhost:32769/

-->
docker run -p 8888:80 prakhar1989/static-site

http://192.168.99.100:8888/

docker ps -a
docker stop 3dd652dcb472

-----

docker images

--> delete images


Delete all docker images
docker rmi $(docker images -q)

docker -f rm $(docker ps -a -q)

docker rm 305297d7a235 ff0a5c3750b9

-- Error response from daemon: conflict: unable to delete f01030e1dcf3 (must be forced) - image is being used by stopped container 3dd652dcb472
-- Solution: docker rm $(docker ps -a -q -f status=exited)
docker rmi $(docker images -q)


Remove all stopped containers.
docker rm $(docker ps -a -q)


Remove all untagged images
docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}')


==> docker rmi image has dependent child images

docker inspect --format='{{.Id}} {{.Parent}}' $(docker images --filter since=<image_id> -q)

docker inspect --format='{{.Id}} {{.Parent}}' $(docker images --filter since=ac159bad4797 -q)
docker inspect --format='{{.Id}} {{.Parent}}' $(docker images --filter since=569df2365176 -q)


docker rmi {sub_image_id}



docker images --format "{{.ID}}: {{.Parent}}"




-----

git clone https://github.com/prakhar1989/docker-curriculum
cd docker-curriculum/flask-app


=================================
How to get bash or ssh into a running container in background mode?

$ sudo docker exec -i -t 665b4a1e17b6 /bin/bash #by ID
or
$ sudo docker exec -i -t loving_heisenberg /bin/bash #by Name
$ root@665b4a1e17b6:/#


winpty docker attach --no-stdin 8144d72a486e --> only showing std output ... e.g, logs from springboot apps

winpty docker exec -it ad4b700d418a ls --> working!!!!!!!!!!!

--> RUN apk add --no-cache bash, when making alpine edge image

winpty docker exec -it 74466f4f6756 bash --> working!!!!!!!!!!! after add bash into alpine image
winpty docker exec -it 8144d72a486e /bin/sh --> 


docker build --tag=alpine-java:base --rm=true .


--cannot run base? exit immediately, docker run alpine-java:base

--docker run -d -p 9999:9999 alpine-java:base

winpty docker exec -i -t 6c5c4a13b2b0 /bin/bash


=======================================================
Docker:

https://stackoverflow.com/questions/31205438/docker-on-windows-boot2docker-certificate-signed-by-unknown-authority-error

Creating CA: C:\Users\liuziy8\.docker\machine\certs\ca.pem
Creating client certificate: C:\Users\liuziy8\.docker\machine\certs\cert.pem


docker run hello-world --> get cert problem: docker x509 certificate signed by unknown authority

--> solution:
docker-machine ssh default

docker@default:~$ sudo -s
root@default:/home/docker# mkdir /var/lib/boot2docker/certs
root@default:/home/docker# cp /c/Users/my.username/certs/*.pem /var/lib/boot2docker/certs/

sudo mkdir /var/lib/boot2docker/certs
sudo cp /c/Users/liuziy8/certs/*.pem /var/lib/boot2docker/certs/

-----

This general issue has been plaguing me for a couple of months. I first noticed it when trying to get a local virtual machine to fetch Python packages, so I already had an idea that certificates would be an issue. I solved it for my VMs, but hadn't until today been able to work out a solution for Docker. The trick is to add the certificates to Docker's cert store and have them persist. This is accomplished by using a bootlocal.sh script that executes every time the machine starts.

I assume if you've already found the answers for Linux, you already know the first steps. I will document them here for the sake of being thorough, because others may not have gotten this far. Start with #3 below if you've already done #1 and #2 by way of previous attempts.

Get the set of corporate root certificates, which should be installed in your corporate-configured browser. In Chrome, you can go to Settings, click Show advanced settings, and scroll down to HTTPS/SSL, where you can choose Manage Certificates. My organization has put them in Trusted Root Cerftification Authorities and named them after the organization. Export each (I have two), one at a time, making sure to choose DER format.

Once you have them saved to a known location, you will want to convert them to PEM format. The easiest way I found to do this was to run the openssl.exe[1] command from within the Docker Quickstart Terminal.

openssl x509 -inform der -in certificate.cer -out certificate.pem


Once you have the .pem files, you will want to copy them to a location to which your Docker machine has access. I made a directory in c:\Users\my.username\certs and copied them there.

This step may not be strictly necessary, but it's what I did, and it works. You will want to copy those certificates into your boot2docker partition, which is persistent. I am connecting to my default machine, which IS something you will need to do for Step 5.

MINGW64:$ docker-machine ssh default

docker@default:~$ sudo -s
root@default:/home/docker# mkdir /var/lib/boot2docker/certs
root@default:/home/docker# cp /c/Users/my.username/certs/*.pem /var/lib/boot2docker/certs/
Now it's time to write a bootlocal.sh script, which will copy the certificates to the proper location each time the system starts.[2] If you haven't already, open an SSH connection to the machine, per Step 4.

touch /var/lib/boot2docker/bootlocal.sh && chmod +x /var/lib/boot2docker/bootlocal.sh
vi /var/lib/boot2docker/bootlocal.sh
Insert the following and save the file:

#!/bin/sh

mkdir -p /etc/docker/certs.d && cp certs/certificate.pem /etc/docker/certs.d
Restart the machine, either by using the reboot command from within the machine, or by using the docker-machine command from the Docker terminal:

docker-machine restart default
Now you should be able to run 'hello-world' and others. I hope this helps.

------------------------


Error: virtual box, The VM session was aborted.(0x80004005)

Solution: run VirtualBox Manager by using "administor", then will see default is running ...
Otherwise, seeing it is stopped



docker-machine stop

===> if then start default VM in Oracle VM VirtualBox Manager, then have the linux command window!!!!!


openssl x509 -inform der -in registry-1.docker.cer -out registry-1.docker.pem


cp /d/SharedFolders/*.pem /var/lib/boot2docker/certs/


docker-machine restart default



export DOCKER_CERT_PATH="d:\SharedFolders" ????
need to change init-docker.cmd ????????



----------------------------------------------

====> Docker mongodb

docker run -p 27017:27017 mongo

docker run -d -p 27017:27017 mongo



docker-machine env default

$ docker-machine env default
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="C:\Users\liuziy8\.docker\machine\machines\default"
export DOCKER_MACHINE_NAME="default"
export COMPOSE_CONVERT_WINDOWS_PATHS="true"
# Run this command to configure your shell:
# eval $("C:\Program Files\Docker Toolbox\docker-machine.exe" env default)

---> DOCKER_CERT_PATH="C:\Users\liuziy8\.docker\machine\machines\default"
--> this is why seeing all .pem is in C:\Users\liuziy8\.docker\machine\machines\default, NOT in certs folder!
--> C:\Users\liuziy8\.docker\machine\machines\default\certs, NOT used!


docker@default:~$ sudo -s
root@default:/mnt/sda1/var/lib/boot2docker# ls /opt
bootlocal.sh   bootscript.sh  bootsync.sh    shutdown.sh    tcemirror
root@default:/mnt/sda1/var/lib/boot2docker# cat bootscript.sh
cat: can't open 'bootscript.sh': No such file or directory
root@default:/mnt/sda1/var/lib/boot2docker# cat /opt/bootscript.sh

------------

# Allow local HD customisation
if [ -e /var/lib/boot2docker/bootlocal.sh ]; then
    /bin/sh /var/lib/boot2docker/bootlocal.sh > /var/log/bootlocal.log 2>&1 &
    echo "------------------- ran /var/lib/boot2docker/bootlocal.sh"
fi

-------------



/c/Users/liuziy8/certs/*.pem

cp /c/Users/liuziy8/certs/*.pem .

keytool -importcert -keystore "C:/Program Files/Java/jdk1.8.0_162/jre/lib/security/cacerts" -storepass changeit -file  "D:/Downloaded/Certs/repo.maven.cer" -alias "repo1.maven.org"


C:/Users/liuziy8/.docker/machine/certs

==============================================================

--> from /var/lib/boot2docker/docker.log

/usr/local/bin/dockerd -g "/var/lib/docker" -H unix:// -H tcp://0.0.0.0:2376
--label provider=virtualbox

 --tlsverify --tlscacert=/var/lib/boot2docker/ca.pem --tlscert=/var/lib/boot2docker/server.pem --tlskey=/var/lib/boot2docker/serve                 r-key.pem -s aufs >> "/var/lib/boot2docker/docker.log"

----------------------


openssl x509 -in ~/.docker/machine/certs/cert.pem -text

openssl x509 -in cert.crt -outform der -out cert.der

registry-1.docker.pem

docker-machine ssh default
sudo -s
cd /var/lib/boot2docker
ls /etc/docker/certs.d/
cd /etc/docker/certs.d/

openssl x509 -in registry-1.docker.pem -outform der -out registry-1.docker.crt
openssl x509 -in ca.pem -outform der -out ca.crt
openssl x509 -in docker-base64.cer -outform der -out docker-base64.pem

docker-machine restart default
docker run -p 27017:27017 mongo
docker run hello-world


===========================================================================


docker build --tag=alpine-java:base --rm=true .



$ docker build --tag=alpine-java:base --rm=true .
Sending build context to Docker daemon  27.65kB
Step 1/4 : FROM alpine:edge
 ---> 5c4fa780951b
Step 2/4 : MAINTAINER oopsmails.com
 ---> Using cache
 ---> 708fe014ea1c
Step 3/4 : RUN apk add --no-cache openjdk8
 ---> Using cache
 ---> a2b25538cf25
Step 4/4 : COPY files/UnlimitedJCEPolicyJDK8/*   /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/
 ---> 5f452ba3e0b3
Successfully built 5f452ba3e0b3
Successfully tagged alpine-java:base
SECURITY WARNING: You are building a Docker image from Windows against a non-Windows Docker host. All files and directories added to build context will have '-rwxr-xr-x' permissions. It is recommended to double check and reset permissions for sensitive files and directories.


=========================================================

====> Compose image example, spring boot config-server and config-client 

--> ?? rm=true not working
docker build --tag=alpine-java:base --rm=true .

docker build --tag=alpine-java:base --force-rm .

docker build --tag=alpine-java:base --no-cache --force-rm .
docker build --file=Dockerfile.test --tag=alpine-test:latest --no-cache --force-rm .

6491776

docker rmi $(docker images -f "dangling=true" -q)

docker image prune 

docker rmi $(docker images -a | grep '^<none>' | awk '{print $3}') --> working, but not ok if has dependent child images
docker rmi -f $(docker images -a | grep '^<none>' | awk '{print $3}')

docker build --file=Dockerfile.server --tag=config-server:latest --rm=true .

docker volume create --name=spring-cloud-config-repo

docker run --name=config-server --publish=8888:8888 \
     --volume=spring-cloud-config-repo:/var/lib/spring-cloud/config-repo \
     config-server:latest

Some more useful options:
-it – enable interactive mode and allocate a pseudo-tty
-d – detach from the container after booting


docker run -d --name=config-server --publish=8888:8888 \
     --volume=spring-cloud-config-repo:/var/lib/spring-cloud/config-repo \
     config-server:latest


$> docker inspect config-server
$> docker stop config-server
$> docker rm config-server



http://192.168.99.100:8888/config-server-client/development
http://192.168.99.100:8080/msg

docker-compose config

docker-compose up --build

docker-compose down


=============================================

docker build --file=Dockerfile-alpine-java.txt --tag=alpine-java:base --rm=true .

docker volume create --name=microservice-docker-config-repo

winpty docker exec -it bf9507093b97 bash

===================================


====> change location of VM storage.

In Windows 10,

Stop docker etc
Type “Hyper-V Manager” in task-bar search box and run it.
Select your PC in the left hand pane (Mine is called DESKTOP-CBP**)
Right click on the correct virtual machine (Mine is called MobyLinuxVM)
Select “Turn off” (If it is running)
Right click on it again and select “Move”
Follow the prompts



Windows 7:

https://stackoverflow.com/questions/33933107/change-docker-machine-location-windows

Simply use the VirtualBox graphic interface to relocate the file disk.vmdk:

enter image description here

Copy file C:\Users\{myUsername}\.docker\machine\machines\default\disk.vmdk into another folder, say F:\docker-image\.
Open VirtualBox, select default VM and open Settings.
Open Storage, select current disk.vmdk and release it (or delete it).
Click on Choose Virtual Hard Disk File... and search for copied file in F:\docker-image\
A Warning occurs: VirtualBox complains of old VM UID then go to menu File, select Virtual Media Manager... and release or remove old disk.vmdk
Retry 4., it's done!
If required by your environment then do the relocation also for boot2docker.iso, Snapshot Folder, Video Capture.





====> Error: oracle vm virtualbox failed to open a session for the virtual machine

Exit current running virtualbox
Go to Task Manager, end all virtualbox processes
Restart virtualbox again, should be working now.




==> remove volume:
docker volume prune






