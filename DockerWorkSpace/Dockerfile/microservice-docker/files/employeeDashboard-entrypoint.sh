#!/bin/sh
echo "inside employee-search entry point script!"

while ! nc -z microservicedocker-configserver 9090 ; do
    echo "Waiting for the Config Server"
    sleep 3
done

while ! nc -z microservicedocker-eurekaserver 9091 ; do
    echo "Waiting for the Eureka Server"
    sleep 3
done

java -jar /opt/lib/microservice-docker/microservice-docker-service-employee-dashboard.jar
