# PostgreSQL on Windows with Docker

https://hackernoon.com/dont-install-postgres-docker-pull-postgres-bee20e200198

https://medium.com/@rrfd/setting-up-docker-postgresql-connecting-locally-using-advanced-functions-d8fe3bd58de6

docker run --rm --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres

docker run --rm --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres

## Run (Not working)
docker run --rm --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v //dockerv/postgres:/var/lib/postgresql/data postgres

running bootstrap script ... 2019-07-31 01:48:08.892 UTC [76] FATAL:  data directory "/var/lib/postgresql/data" has wrong ownership
2019-07-31 01:48:08.892 UTC [76] HINT:  The server must be started by the user that owns the data directory.
child process exited with exit code 1
initdb: removing contents of data directory "/var/lib/postgresql/data"



## Run (working)

- create volume first
docker volume create --name=postgres

- without -d
docker run --rm --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -v postgres:/var/lib/postgresql/data postgres

- with -d
docker run --rm --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v postgres:/var/lib/postgresql/data postgres


##
winpty docker exec -it postgres bash


##
-- psql -h localhost -p 5432 -U postgres  
psql -h localhost -U postgres -d postgres

