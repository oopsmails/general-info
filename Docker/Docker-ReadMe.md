

### Docker commands

docker login  
docker ps -a  
docker images  
docker build  
docker run -d -p  
docker push  
docker rm  
docker rmi  
docker volume prune  
- Command for restarting all running docker containers?  
Just run

`docker restart $(docker ps -q)`

Update

For Docker 1.13.1 use `docker restart $(docker ps -a -q)` as in answer lower.

- One liner to stop / remove all of Docker containers:
```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```


### Docker Spring Boot

https://medium.com/@lhartikk/development-environment-in-spring-boot-with-docker-734ad6c50b34  

- docker build
docker build -t oopsmails/backendmock . 

**Using Java or Maven from Host Machine**

In Dockerfile:  
```
ENV JAVA_HOME="//c/'Program Files'/Java/jdk1.8.0_121"

ENV MAVEN_HOME="//c/Software/Java/apache-maven-3.6.1"
```

Then for example, in Jenkins configuration, using "$JAVA_HOME" and "MAVEN_HOME"

- docker run  
docker run -p externalport:internalport oopsmails/backendmock --name oopsmails/backendmock  
docker run -p 49080:29080 oopsmails/backendmock

docker run -p 49080:29080 dockerbootdemo

- run background  
docker run -d -p 49080:29080 dockerbootdemo  
docker run -d -p 49080:29080 oopsmails/backendmock  
docker run -d -p 49080:29080 oopsmails/backendmock --name oopsmails/backendmock  

39080/tcp, 0.0.0.0:49080->29080/tcp:  

- stop and remove container  
docker stop 0cf4f01610da  
docker rm 0cf  
docker rmi -f dockerbootdemo

- docker push  
docker push oopsmails/backendmock


#### URL to use ...
- Not working, the URLs I was trying was localhost , 127.0.0.1 , 0.0.0.0, etc .  

It's probably because Spring Boot will bind to localhost by default (127.0.0.1). You need to add the following properties to bind to all host (or specify which IP on which to bind):

server.address=0.0.0.0 # Bind all
In your application.properties

- working
http://192.168.99.100:49080/backendmock/employee-api


### Problems,

- SpringBoot no main manifest attribute (maven)

Try adding repackage goal to execution goals. Otherwise you would need to call the plugin explicitly as mvn package spring-boot:repackage. With the goal added, you have to call only mvn package.
```
<plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <configuration>
            <mainClass>com.places.Main</mainClass>
        </configuration>

        <executions>
            <execution>
                <goals>
                    <goal>repackage</goal>
                </goals>
            </execution>
       </executions>

</plugin>
```

### Hot Swap and Debugging



-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=49080

java -jar -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=49080 
