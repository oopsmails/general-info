

--> working

docker run --name myjenkins -p 9090:8080 -p 50000:50000 -v //dockerv/jenkins:/var/jenkins_home jenkins

http://192.168.99.100:9090

admin
admin

--> same image, same volume
docker run --name myjenkins2 -p 9091:8080 -p 50001:50000 -v //dockerv/jenkins:/var/jenkins_home jenkins
http://192.168.99.100:9091




https://medium.com/@Charles_Stover/fixing-volumes-in-docker-toolbox-4ad5ace0e572

Windows 10 Home:

Need to setup "Shared Folders" in Oracle VM VirtualBox Manager


===========

https://code-maze.com/ci-jenkins-docker/















