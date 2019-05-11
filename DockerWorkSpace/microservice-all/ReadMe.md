
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
Not using:  
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




