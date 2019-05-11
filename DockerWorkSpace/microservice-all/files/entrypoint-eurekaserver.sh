#!/bin/sh
echo "inside eureka entry point script!"

while ! nc -z microservicedocker-configserver 8888 ; do
    echo "Waiting for the Config Server"
    sleep 3
done

java -jar /opt/lib/microservice-docker/microservice-docker-eureka-server.jar
