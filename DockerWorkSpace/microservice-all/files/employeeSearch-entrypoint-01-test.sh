#!/bin/sh
echo "inside employee-search entry point script!"

while ! nc -z 192.168.99.100 9090 ; do
    echo "Waiting for the Config Server"
    sleep 3
done

while ! nc -z 192.168.99.100 9091 ; do
    echo "Waiting for the Eureka Server"
    sleep 3
done

java -jar /opt/lib/microservice-docker/microservice-docker-service-employee-search.jar
