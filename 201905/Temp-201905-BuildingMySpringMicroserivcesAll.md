


docker build --rm -f Dockerfile -t angular-integration-dev:v1 .

docker run -it --name adev -v "/${PWD}://dockerv/adev" -p 4301:4301 angular-integration-dev:v1


docker run -it --name adev -v //c/Github/angular-integration://dockerv/adev -p 4301:4301 angular-integration-dev:v1


docker run -it --name adev -v /dockerv/adev://dockerv/adev -p 4301:4301 angular-integration-dev:v1



docker run -it --name adev -p 4301:4301 angular-integration-dev:v1

docker run -it --name adev -v //dockerv:/dockerv/adev -p 4301:4301 angular-integration-dev:v1

docker run -it --name adev --mount type=volume,src=adev,dst=/c/Github/angular-integration -p 4301:4301 angular-integration-dev:v1

docker run -it --name adev --mount type=volume,src=adev,dst=/c/Github/angular-integration -p 4301:4301 angular-integration-dev:v1


--docker run -it --name adev --mount type=volume,src=/c/Github/angular-integration,dst=/adev -p 4301:4301 angular-integration-dev:v1




docker run -it -v C:/Github/angular-integration:/usr/src/app/node_module -p 4301:4301 -p 49153:49153 --rm something-clever bash -c "npm start"


docker run -it -v C:/Github/angular-integration:/adev/node_modules -p 4301:4301 -p 49153:49153 --rm angular-integration-dev:v1 bash -c "npm start"


docker run -it --rm -p 4301:4301 -v ${pwd}/src:/adev angular-integration-dev:v1


docker run -it --rm -p 4301:4301 -v ${pwd}/src:/adev/src angular-integration-dev:v1



docker run -it -v C:/Github/angular-integration:/usr/src/app/node_modules -p 4301:4301 -p 49153:49153 --rm angular-integration-dev:v1 bash -c "npm start"



docker run -it --rm -p 4301:4301 -v //c/Github/angular-integration:/dockerv/app angular-integration-dev:v1


docker run -it --name adev --mount type=volume,src=//c/Github/angular-integration,dst=/dockerv/app -p 4301:4301 angular-integration-dev:v1


docker run -it -v C:/Github/angular-integration:/app/node_modules -p 4200:4200 -p 49153:49153 --rm adev bash -c "npm start"

docker run -it -v C:/Github/angular-integration:/app/node_modules -p 4200:4200 -p 49153:49153 --rm adev bash -c "npm start"



docker run -it --name adev -p 4301:4301 -p 49153:49153 -v C:/Github/angular-integration:/app/node_modules angular-integration-dev:v1


docker run -it --name adev -p 4301:4301 -p 49153:49153 -v //c/Github/angular-integration:/app/node_modules angular-integration-dev:v1



docker run -it --name adev -p 4301:4301 -p 49153:49153 -v "C:/Github/angular-integration:/app/node_modules" angular-integration-dev:v1


==========================================================


```
<build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <mainClass>com.oopsmails.spring.cloud.microservices.configserver.SpringCloudMicroservicesConfigServerApplication</mainClass>
                </configuration>

                <executions>
                    <execution>
                        <goals>
                            <goal>repackage</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
```


=========================



docker run --name microservicedocker-configserver -d -p 8888:8888 microservicedocker-configserver

docker run -d -p 8761:8761 microservicedocker-eurekaserver --name microservicedocker-eurekaserver


http://192.168.99.100:8888/discovery-service/default
http://192.168.99.100:8888/discovery-service/default --> ok

ENV SPRING_APPLICATION_JSON='{"eureka": {"client": {"serviceUrl": {"defaultZone": "http://microservicedocker-eurekaserver:8761/eureka/"}}}, "spring": {"cloud": {"config": {"uri": "http://microservicedocker-configserver:8888"}}}}'


http://microservicedocker-configserver:8888/discovery-service/default







![imgTest](imgLink)



http://192.168.99.100:49080/backendmock/employee-api

docker volume inspect ba6e04748d95fdd093af33c961f5edea5c31805be4c4eb8940b2ebb77f355335


docker stop backendmock
docker rm backendmock
docker rmi -f oopsmails/backendmock


docker run -d --name backendmock -p 49080:29080 oopsmails/backendmock

. cmd.sh image
. cmd.sh ps

docker logs --follow backendmock











