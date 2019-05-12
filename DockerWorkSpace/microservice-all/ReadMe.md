
### docker-compose config

docker-compose up --build


Creating network "microserviceall_emp-network" with driver "bridge"
ERROR: Volume microservice-docker-config-repo declared as external, but could not be found. Please create the volume manually using `docker volume create --name=microservice-docker-config-repo` and try again.


docker volume create --name=microservice-docker-config-repo

docker-compose up --build

### Only run Configuration Server docker image, OK

#### Build
`docker build -f Dockerfile-configserver.txt -t microservicedocker-configserver .`  

#### Run
`docker run -d --name microservicedocker-configserver -p 8888:8888 microservicedocker-configserver`

No --link needed ....
`docker run -d --name microservicedocker-configserver --link microservicedocker-configserver:microservicedocker-configserver -p 8888:8888 microservicedocker-configserver`

#### Verify

http://192.168.99.100:8888/discovery-service/default

#### Explain

in **Dockerfile-configserver.txt**

- Create volumn  
`VOLUME /var/lib/microservice-docker/config-repo`
- Copy configuration files to volumn  
`COPY files/config-repo /var/lib/microservice-docker/config-repo`
- Define searchLocations
`"searchLocations": "/var/lib/microservice-docker/config-repo"`



### Only run Eureka Server docker image, OK

#### Build
`docker build -f Dockerfile-eurekaserver.txt -t microservicedocker-eurekaserver .`  

#### Run
---Not using:  
`docker run -d --name microservicedocker-eurekaserver -p 8761:8761 microservicedocker-eurekaserver`

Using:  
`docker run -d --name microservicedocker-eurekaserver --link microservicedocker-configserver:microservicedocker-configserver -p 8761:8761 microservicedocker-eurekaserver`

#### Verify

http://192.168.99.100:8761/  

#### Explain  

To find Configuration Server:
`--link microservicedocker-configserver:microservicedocker-configserver`  

`"uri": "http://microservicedocker-configserver:8888" \` in Dockerfile-eurekaserver.txt


### Only run Zuul Server docker image, OK

#### Build
`docker build -f Dockerfile-zuulserver.txt -t microservicedocker-zuulserver .`  

#### Run
Not using:  
`docker run -d --name microservicedocker-zuulserver -p 9999:9999 microservicedocker-zuulserver`

Using:  
`docker run -d --name microservicedocker-zuulserver --link microservicedocker-configserver:microservicedocker-configserver --link microservicedocker-eurekaserver:microservicedocker-eurekaserver -p 9999:9999 microservicedocker-zuulserver`

#### Verify

http://192.168.99.100:8761/  

#### Explain  

To find Configuration Server:
`--link microservicedocker-configserver:microservicedocker-configserver --link microservicedocker-eurekaserver:microservicedocker-eurekaserver`  

`"uri": "http://microservicedocker-configserver:8888" \` in Dockerfile-zuulserver.txt  

`eureka:
  client:
    serviceUrl:
      defaultZone: http://microservicedocker-eurekaserver:8761/eureka/
` in discovery-service.yml, which is copied to "COPY files/config-repo /var/lib/microservice-docker/config-repo" in Dockerfile-configserver.txt  



### Only run Auth Server docker image, OK

#### Build
`docker build -f Dockerfile-authserver.txt -t microservicedocker-authserver .`  

#### Run

Using:  
`docker run -d --name microservicedocker-authserver --link microservicedocker-configserver:microservicedocker-configserver --link microservicedocker-eurekaserver:microservicedocker-eurekaserver -p 7777:7777 microservicedocker-authserver`

#### Verify

http://192.168.99.100:8761/  

#### Explain  

Similar to Zuul Server 



### Only run Employee Service docker image, OK

#### Build
`docker build -f Dockerfile-service-employee.txt -t microservice-docker-service-employee .`  

#### Run

Using:  
`docker run -d --name microservice-docker-service-employee --link microservicedocker-configserver:microservicedocker-configserver --link microservicedocker-eurekaserver:microservicedocker-eurekaserver -p 18084:18084 microservice-docker-service-employee`

#### Verify

http://192.168.99.100:8761/  


## Problem:

### Exception in Zuul server,
Caused by: java.net.UnknownHostException: da2a0f28cab8: Name or service not known

For example: da2a0f28cab8 is the hostname of auth-server,

Eureca server: 

AUTH-SERVER	n/a (1)	(1)	UP (1) - da2a0f28cab8:auth-server:7777

#### Run in same container:


docker run -it -d shykes/pybuilder /bin/bash


docker logs --follow microservicedocker-configserver
docker logs --follow microservicedocker-eurekaserver
docker logs --follow microservicedocker-authserver
docker logs --follow microservicedocker-zuulserver
docker logs --follow microservicedocker-service-employee


# To Be Continued ...

Currently, when frontend click "Login", zuul log, seeing error,

Caused by: java.lang.RuntimeException: java.net.UnknownHostException: fcebb375324f: Name or service not known

Need to, 

- https://stackoverflow.com/questions/44689202/springboot-client-unable-register-with-eureka-using-docker-container-id

- Know how to access Virtual Box, volume ... if can vi those yml files, then don't need to rebuild all the time. Currently, 

```
$ docker volume inspect ba6e04748d95fdd093af33c961f5edea5c31805be4c4eb8940b2ebb77f355335
[
    {
        "CreatedAt": "2019-05-12T20:24:57Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/mnt/sda1/var/lib/docker/volumes/ba6e04748d95fdd093af33c961f5edea5c31805be4c4eb8940b2ebb77f355335/_data",
        "Name": "ba6e04748d95fdd093af33c961f5edea5c31805be4c4eb8940b2ebb77f355335",
        "Options": null,
        "Scope": "local"
    }
]
```
Permission denied on "/mnt/sda1/var/lib/docker", current user, docker. How to get root and chmod.

- Start Oracle Virtual Box, 
`docker restart $(docker ps -a -q)` to start all containers ...

- https://medium.com/@madhupathy/simplified-microservices-building-with-spring-cloud-netflix-oss-eureka-zuul-hystrix-ribbon-2faa9046d054

- docker start config_server_container_id, then eureka, then zuul, then auth, then employee

- 2019-05-12 21:25:46.619 ERROR 1 --- [tbeatExecutor-0] com.netflix.discovery.DiscoveryClient    : DiscoveryClient_DISCOVERY-SERVICE/f9d30cea1b13:discovery-service - was unable to send heartbeat!




