
# Jenkins

## Start, Stop

Run the command java -jar jenkins.war.

Browse to http://localhost:8080 and wait until the Unlock Jenkins page appears.

java -jar jenkins.war --httpPort=9090

Open Console/Command line --> Go to your Jenkins installation directory. Execute the following commands respectively:


C:\Program Files (x86)\Jenkins>jenkins stop

to stop:
jenkins.exe stop

to start:
jenkins.exe start

to restart:
jenkins.exe restart

https://stackoverflow.com/questions/48750742/jenkins-is-not-using-local-maven-repository


mvn install:install-file -Dfile=<path-to-file> -DgroupId=<group-id> \
    -DartifactId=<artifact-id> -Dversion=<version> -Dpackaging=<packaging>


mvn install:install-file -Dfile=c:\kaptcha-2.3.jar -DgroupId=com.google.code 
-DartifactId=kaptcha -Dversion=2.3 -Dpackaging=jar


# Nexus

## Start, Stop

C:\Software\nexus-3.16.1-02-win64\nexus-3.16.1-02\bin>nexus /run

http://localhost:8081
admin/admin

http://localhost:8081/repository/oopsmails-mvn-github/







