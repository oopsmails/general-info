
# Docker Compose General 

## Keywords Explained

### Using links to Build Communication Between Services

- Dockerfile

```
FROM openjdk:8-jdk-alpine
LABEL maintainer="author@javatodev.com"
VOLUME /main-app
ADD build/libs/spring-boot-mongodb-base-project-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar","/app.jar"]

```

- Build image, Tag it

docker build --rm -f abc/Dockerfile -t api_service:v1 api_service

- docker-compose.yml explained

```
version: "3.7"
services:
  api_service:
    build: .
    restart: always
    ports:
      - 8080:8080
    links: <---------------------- The docker-compose documentation specifies that links is deprecated and should be replaced with depends_on.
      - mongo_db:app_db
    depends_on:
    - app_db
  mongo_db:
    image: "mongo:4.4.3"
    restart: always
    ports:
      - 27017:27017

```


- Here we have out two main services as,

1. api_service – Spring Boot REST API which runs on port 8080.
2. mongo_db – MongoDB which runs on port 27017.

- Explanation about the configurations I have used in this docker-compose file,

**build** – Here we should introduce the image name to build under that service, Here we have our Dockerfile which developed for the API in the same level with docker-compose.yml so using “.” it will capture that docker file and build the handle the api_service when executing this file.

Additionally, we have introduced mongo:4.4.3 as the docker image for MongoDB. It will download from docker registry and start when needed.

More to research: We can do the same to spring boot API docker image as well, Just push that image to docker-hub and you can directly use given image name and version for this setup as well.

**restart** – always Always restart the container if it stops. If it is manually stopped, it is restarted only when Docker daemon restarts or the container itself is manually restarted.

**ports** – Here we are mapping local machine port along with port inside a docker container.

**links** **depends_on** – Here we are setting a link with app_db service. So we can use app_db when defining an IP address for the database connection on our spring boot application. Then it will connect with the database running with this docker-compose.

The docker-compose documentation specifies that links is deprecated and should be replaced with depends_on.

- All done, Now let’s change our *application.properties* to support this database and application server setup.

```
spring.data.mongodb.host=app_db <------------------- Here
spring.data.mongodb.port=27017
spring.data.mongodb.database=java-to-dev-api
```

Here as you can see we are using that **link** **depends_on** value we used in docker-compose definition for host/IP address.

**Better Solution**: Use a separate *application.properties* file for docker-compose based deployments and set that via profiles.

## Build and Run

### Navigate to application root folder and execute,
```
$ ./gradlew clean build
```
Now there should be a newly created jar file with all the necessary files to run this application on build/libs folder.

### Then create the build with docker compose to build docker image using built jar file.
```
$ docker-compose build
```

### Then use following command to run whole setup using docker compose.
```
$ docker-compose up
```

### Then It will capture the docker-compose.yml and start running using the instructions given on that file.


## Refs:

- https://javatodev.com/docker-compose-for-spring-boot-with-mongodb/


