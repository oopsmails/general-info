
# Redis on ElementaryOS Docker

- Ref:

https://phoenixnap.com/kb/docker-redis

https://kb.objectrocket.com/redis/how-to-run-and-deploy-redis-in-docker-1154


## How to Run and Deploy Redis in Docker

### Start a Docker Redis Container

- Check the current status of the Docker service by entering the following command in your terminal:

`sudo systemctl status docker`

- Run a Redis container

`sudo docker run --name my-first-redis -d redis`

- Now, let’s run Redis and execute the redis-cli command inside the container. This will start the interactive shell command-line interpreter. Here’s how to do it:

`sudo docker exec -it my-first-redis sh`

- After that, type the command *redis-cli* to enter into the Redis command-line interface. The following commands can be used to get started, example below,

```
127.0.0.1:6379> set docker great
OK
127.0.0.1:6379> get docker
"great"
127.0.0.1:6379> set name objectrocket
OK
127.0.0.1:6379> get name
"objectrocket"
```

### Using a Custom redis.conf File (Optional)

The redis.conf file allows you to set up authentication, limit commands, and define other security-oriented settings.

If you have created a custom Redis configuration file, use the following command to load the file at container launch:

`sudo docker run --name my-first-redis -v /myfirstredis/redis.conf:/usr/local/etc/redis/redis.conf -d redis`


### Connect from another container

1. Use the --link option to create and connect a new container to the existing Redis instance:

`sudo docker run -it --rm --name my-second-redis --link my-first-redis:redis -d redis`


2. Initiate the interactive shell within the my-second-redis container:

`sudo docker exec -it my-second-redis sh`

3. Start the Redis command-line in the my-second-redis container and connect to my-first-redis (now named redis), with the following command:

`redis-cli -h redis`

4. The original my-first-redis container is still active. The name key created earlier is available and can be accessed by the second container:

`redis:6379> get name`

5. Enter quit to leave the redis-cli and then type exit to return to your terminal:

```
redis:6379> quit
# exit
```

### Access Redis from Remote Server
You can use the Docker port-forwarding function to access Redis containers from remote servers.

1. Define the port to be used for the remote connection:

`sudo docker run --name my-first-redis -p [port_number]:6379 -d redis`

2. Access the Redis container from a remote server using the host-name or IP and the newly defined port number:

`sudo redis-cli -h [host or IP] -p [port_number] -a [password]`

The -a authentication flag is optional. If used, it requests users to enter their password to access the Redis database.



## Redis commands:

`redis-cli FLUSHALL -> flushall`

`redis-cli FLUSHDB -> flushdb`

Delete all keys of the specified Redis database:

`redis-cli -n <database_number> FLUSHDB`

