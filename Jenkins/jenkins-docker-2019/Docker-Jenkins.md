


====================================

: docker run -p 8080:8080 -p 50000:50000 jenkins

: docker run --name MyJenkins -p 8080:8080 -p 50000:50000 -v /Users/raghav/Desktop/Jenkins_Home:/var/jenkins_home jenkins

: docker run --name MyJenkins2 -p 9090:8080 -p 50000:50000 -v /Users/raghav/Desktop/Jenkins_Home:/var/jenkins_home jenkins

: docker volume create myjenkins
: docker volume ls
: docker volume inspect myjenkins

: docker run --name MyJenkins3 -p 9090:8080 -p 50000:50000 -v myjenkins:/var/jenkins_home jenkins

: docker inspect MyJenkins3



docker run --name myjenkins -p 9090:8080 -p 50000:50000 -v /c/dockerv/jenkins:/var/jenkins_home jenkins

$Env:COMPOSE_CONVERT_WINDOWS_PATHS=1

docker run --name myjenkins -p 9090:8080 -p 50000:50000 -v //c/dockerv/jenkins:/var/jenkins_home jenkins




docker run --name myjenkins -p 9090:8080 -p 50000:50000 -v c:/dockerv/jenkins:/var/jenkins_home jenkins





docker run --name myjenkins -p 9090:8080 -p 50000:50000 -v /c/dockerv/jenkins:/var/jenkins_home jenkins


--> working

docker run --name myjenkins -p 9090:8080 -p 50000:50000 -v //dockerv/jenkins:/var/jenkins_home jenkins

http://192.168.99.100:9090

93e637dd88c74b5c926a09e209862a02


admin
admin

--> same volume, same container
docker run --name myjenkins2 -p 9091:8080 -p 50001:50000 -v //dockerv/jenkins:/var/jenkins_home jenkins
http://192.168.99.100:9091




--> 20190515:

docker pull jenkins/jenkins:lts

docker run --name myjenkins -p 9090:8080 -p 50000:50000 -v //dockerv/jenkins:/var/jenkins_home jenkins/jenkins:lts

docker-machine ssh default


--> 20190516:

docker rm -f myjenkins


cd /c/docker/jenkins

docker build -t myjenkins .


docker run --name myjenkins -p 9090:8080 -p 50000:50000 -v //dockerv/jenkins:/var/jenkins_home myjenkins


--> 20190519:

docker run --name myjenkins -p 9090:8080 -p 50000:50000 \
-v //dockerv/jenkins:/var/jenkins_home \
-v //maven361:/var/jenkins_home \
jenkins/jenkins:lts



--docker@default:/dockerv/jenkins$


--wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3a%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk8-downloads-2133151.html; oraclelicense=accept-securebackup-cookie;" "https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz"


--wget --no-check-certificate --header "Cookie: gpw_e24=http%3a%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk8-downloads-2133151.html; oraclelicense=accept-securebackup-cookie;" "https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz"


wget --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz"


docker@default:/var$ sudo passwd root
root/root


--sudo usermod -a -G vboxsf username
sudo usermod -a -G vboxsf docker




## working

docker run --name jenkins -p 9090:8080 -p 50000:50000 -v //dockerv/jenkins:/var/jenkins_home jenkins

http://192.168.99.100:9090

admin
admin

--> same image, same volume
docker run --name jenkins2 -p 9091:8080 -p 50001:50000 -v //dockerv/jenkins:/var/jenkins_home jenkins
http://192.168.99.100:9091



--> You must update Jenkins from v2.60.3 to v2.121.1 or later to run this plugin.

https://medium.com/@Charles_Stover/fixing-volumes-in-docker-toolbox-4ad5ace0e572

Windows 10 Home:

Need to setup "Shared Folders" in Oracle VM VirtualBox Manager


===========

https://code-maze.com/ci-jenkins-docker/















