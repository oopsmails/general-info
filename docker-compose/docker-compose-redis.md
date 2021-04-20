
# Run Redis with Compose

- Ref:

https://kb.objectrocket.com/redis/run-redis-with-docker-compose-1055


## Create a config file for Redis

There aren’t any environment variables that can be set using the docker-compose.yml file. However, some functions can be modified with the redis.conf file.

To inject a custom configuration file for Redis when building the Docker container, create the redis.config file somewhere in the project directory and download a version of the config file that matches the version found on the Redis website.

The following configurations will specify a bound IP address and port:

```
bind 172.28.1.4
protected-mode yes
port 6379
```

## Create a Docker-Compose file for Redis

Be certain to specify the relative path for the redis.conf file and for the Redis data. A password can be specified by invoking the redis-server --requirepass command under the command: field, as shown here:

```
version: "3.2"
services:

 redis:
    image: "redis:alpine"

    command: redis-server --requirepass sOmE_sEcUrE_pAsS

    ports:
     - "6379:6379"

    volumes:
     - $PWD/redis-data:/var/lib/redis
      - $PWD/redis.conf:/usr/local/etc/redis/redis.conf

    environment:
     - REDIS_REPLICATION_MODE=master

    networks:
      node_net:
        ipv4_address: 172.28.1.4

# networking for the Redis container
networks:
  node_net:
    ipam:
      driver: default
      config:
        - subnet: 172.28.0.0/16

```

The above networks: fields will assign the container an IP address of 172.28.1.4. The "redis-alpine" image will install Redis on a barebones “Alpine” distro of Linux.

## Build the Redis with Docker Compose
Now save all of the settings and then execute the following docker-compose command to spin-up the container, after it is built from the YAML configuration:


`docker-compose up --build`

The container should now be running in the foreground of the terminal window. Open another terminal instance, or a new tab, and use the docker ps command to have Docker return the container’s alpha-numeric ID.

## Run commands in the Redis container
With the container ID obtained, use the ID to execute commands and connect to the Docker-Compose container interactively. Execute the following docker exec -it command to get access to its bash shell:


`docker exec -it {CONTAINER_ID} sh`


**NOTE**: When executing the above command, be absolutely certain to replace {CONTAINER_ID} with the actual ID of the container.

Now type exit to disconnect from the container. To shutdown the container, execute the docker-compose down command in the same directory where the docker-compose.yml file is located.




