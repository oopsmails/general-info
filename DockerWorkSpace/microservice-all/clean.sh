docker stop microservicedocker-zuulserver
docker stop microservicedocker-eurekaserver
docker stop microservicedocker-configserver

docker rm -f microservicedocker-zuulserver
docker rm -f microservicedocker-eurekaserver
docker rm -f microservicedocker-configserver

docker rmi -f microservicedocker-zuulserver
docker rmi -f microservicedocker-eurekaserver
docker rmi -f microservicedocker-configserver


