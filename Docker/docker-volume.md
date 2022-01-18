
# The Complete Guide to Docker Volumes

- Ref:

https://towardsdatascience.com/the-complete-guide-to-docker-volumes-1a06051d2cce


- Summary:

    - Named volumes

    ```
    volumes:
        - db_data:/var/lib/mysq

    ```

    - Bind mounts:

    ```
    volumes:
        - $PWD/data:/var/lib/mysql
    ```


## Setup: Using MySQL docker server as example

```

docker compose up

- Create Demo Table

# Access the container
docker exec -it mysql_db_1 bash
# Connect to MySQL server
mysql -uroot -proot
# Run MySQL commands
USE test_db;
SHOW TABLES;
CREATE TABLE users (
       user_id int NOT NULL AUTO_INCREMENT,
       name VARCHAR(20),
       PRIMARY KEY (user_id)
);
SHOW TABLES;

```

## Volumes

### Anonymous volumes

If we run the following docker-compose.yml file, an anonymous volume will be created. If we restart our container, the data will be visible, but not after we remove the container. Also, it’s not accessible by other containers. It is helpful if we want to persist data temporarily. These volumes are created inside /var/lib/docker/volume local host directory.

```
version: '3.8'
services:
  db:
    image: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: test_db
    ports:
      - "3306:3306"
    volumes:
      - /var/lib/mysql

```

```
docker volume ls

docker inspect mysql_db_1

```

We can use the following command to remove the container and its associated anonymous volume.

```
docker rm -v mysql_db_1
```

If we don’t remove the anonymous volume and the container together, it becomes a dangling volume.

```
docker rm mysql_db_1
```

### Named volumes

Named volumes can persist data after we restart or remove a container. Also, it’s accessible by other containers. These volumes are created inside */var/lib/docker/volume* local host directory.

```
version: '3.8'
services:
  db:
    image: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: test_db
    ports:
      - "3306:3306"
    volumes:
      - db_data:/var/lib/mysql
volumes:
  db_data:

```

Here, **the first field is a unique name of the volume on a host machine. The second part is the path in the container.**


Moreover, *if we remove the container using the following command, we will still have the volume, unlike anonymous volumes.*

```
docker rm -v mysql_db_1
```

### Bind mounts

Bind mounts can persist data after we restart or remove a container. As we can see, named volumes and bind mounts are the same, except the named volumes can be found under a specific host directory, and bind mounts can be any host directory.

```
version: '3.8'
services:
  db:
    image: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: test_db
    ports:
      - "3306:3306"
    volumes:
      - $PWD/data:/var/lib/mysql

```

Here, we are mounting a host folder. **The first part is the path in the host machine. The second part is the path in the container.**


## Commands

```

docker volume --help

Commands:
  create      Create a volume
  inspect     Display detailed information on one or more volumes
  ls          List volumes
  prune       Remove all unused local volumes
  rm          Remove one or more volumes


# Creat a volume
docker volume create test-vol
# test-vol
# Inspect a volume -------------------------
docker inspect test-vol

# Remove all volumes
docker volume prune


```







