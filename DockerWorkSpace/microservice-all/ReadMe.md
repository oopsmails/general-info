
docker-compose config

docker-compose up --build


Creating network "microserviceall_emp-network" with driver "bridge"
ERROR: Volume microservice-docker-config-repo declared as external, but could not be found. Please create the volume manually using `docker volume create --name=microservice-docker-config-repo` and try again.


docker volume create --name=microservice-docker-config-repo

docker-compose up --build



