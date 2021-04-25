# general-info

## ElementaryOS

### Run Docker images for Dev

- MongoDB

docker run -it -v /dockerdata/mongodb:/data/db -p 27017:27017 --name mongodb -d mongo:4.2.2

- Kafka
   - bitnami/kafka:2
   - nginx:alpine
   - bitnami/zookeeper:3
   - obsidiandynamics/kafdrop, to view kafka
   - mailhog/mailhog
   - spring-boot-kafka-ms-email

github/springboot-dev-repo/spring-boot-kafka-ms-email-files/docker-compose.yml

- redis
   - redis:alpine

spring-boot-session-redis/docker-compose.yml

- wiremock
   - rodolpheche/wiremock

github/dev-repo-backend/wiremock-docker/docker-compose.yml

- nginx
   - one is included in Kafka email ms



- sonarqube
   - sonarqube:8.2-community
   - postgres (latest)

github/springboot-dev-repo/spring-boot-rest-sonarqube/docker/docker-compose.yaml

- mysql
   - mysql:8.0.17
   - adminer

github/springboot-dev-repo/spring-boot-oauth2/spring-boot-oauth2-social-login/docker/docker-compose.yml



