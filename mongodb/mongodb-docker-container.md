
# How To Run MongoDB as a Docker Container

- Ref:

https://www.bmc.com/blogs/mongodb-docker-container/

## Installing Docker (on Ubuntu)

```
sudo apt update && sudo apt upgrade -y

sudo apt install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update

apt-cache policy docker-ce

sudo apt install docker-ce

sudo systemctl status docker ----> checkingif runningas Service
```

## Installing Docker Compose

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
```

## Setting up a MongoDB container


### search for the official MongoDB container image using the search command.

```
sudo docker search mongodb
```

### prepare locally

Next, we need to create a directory called "mongodb" to hold the docker-compose file. We will create another directory called "database" inside the "mongodb" directory to map to the database location of the container. This will enable local access to the database. We use the *-pv* operator to create those parent folders.

`mkdir -pv mongodb/database`

- structure

tree mongodb

### docker-compose.yml


```
version: "3.8"
services:
mongodb:
    image : mongo
    container_name: mongodb
    environment:
        - PUID=1000
        - PGID=1000
    volumes:
        - /home/barry/mongodb/database:/data/db
    ports:
        - 27017:27017
    restart: unless-stopped
```

We used version 3.8 to create the above compose file. The compose file version directly correlates to:

- Which options are available within the compose file
- The minimum supported Docker engine version

In this case, It’s Docker Engine 19.03.0 or newer.

## Run 

```
sudo docker-compose up -d

sudo docker ps -a

sudo tree mongodb ???? not working
```

## Interacting with the MongoDB container

```
sudo docker exec -it mongodb bash

- inside container,
mongo admin -u root -p root

use food
db.createCollection("fruits")
db.fruits.insertMany([ {name: "apple", origin: "usa", price: 5}, {name: "orange", origin: "italy", price: 3}, {name: "mango", origin: "malaysia", price: 3} ])


db.fruits.find().pretty()
```

## External connections to MongoDB container

- didn't install mongo externally .... not tested yet ....

```
mongo 10.10.10.60:27017

mongo localhost:27017

show databases
use food
show collections
db.fruits.find().pretty()
```

## Data resilience

```
sudo docker-compose down
sudo docker rmi mongo
sudo tree mongodb

sudo docker-compose up -d
sudo docker exec -it mongodb bash

show databases
use food
db.fruits.find().pretty()

```

## Container log files

sudo docker logs mongodb

sudo docker logs -f --tail 100 mongodb

## Advanced container usage

Mongo Express is a web-based MongoDB administration interface that also can be run as a containerized application.

docker-compose.yml

```
version: "3.8"
services:
    mongodb:
        image: mongo
    container_name: mongodb
    environment:
        - MONGO_INITDB_ROOT_USERNAME=root
        - MONGO_INITDB_ROOT_PASSWORD=pass12345
    volumes:
        - mongodb-data:/data/db
    networks:
        - mongodb_network
    ports:
        - 27017:27017
    healthcheck:
        test: echo 'db.runCommand("ping").ok' | mongo 10.10.10.60:27017/test --quiet
        interval: 30s
        timeout: 10s
        retries: 3
    restart: unless-stopped
mongo-express:
    image: mongo-express
    container_name: mongo-express
    environment:
    - ME_CONFIG_MONGODB_SERVER=mongodb
    - ME_CONFIG_MONGODB_ENABLE_ADMIN=true
    - ME_CONFIG_MONGODB_ADMINUSERNAME=root
    - ME_CONFIG_MONGODB_ADMINPASSWORD=pass12345
    - ME_CONFIG_BASICAUTH_USERNAME=admin
    - ME_CONFIG_BASICAUTH_PASSWORD=admin123
    volumes:
    - mongodb-data
    depends_on:
    - mongodb
    networks:
    - mongodb_network
    ports:
    - 8081:8081
    healthcheck:
    test:  wget --quiet --tries=3 --spider http://admin:admin123@10.10.10.60:8081 || exit 1
    interval: 30s
    timeout: 10s
    retries: 3
    restart: unless-stopped
    volumes:
    mongodb-data:
    name: mongodb-data
    networks:
    mongodb_network:
    name: mongodb_network

```

sudo docker-compose up -d

sudo docker ps -a

## Mongo Express

Now, let’s go to the Mongo Express web interface using the server IP (http://10.10.10.60:8081).

> http://localhost:8081/

## How to dump & restore a MongoDB database from a docker container

- Ref:

https://davejansen.com/how-to-dump-restore-a-mongodb-database-from-a-docker-container/

### Create a database dump

We will simply dump the files to somewhere within the docker container, and then docker cp them out.

```
docker exec -i <container_name> /usr/bin/mongodump --username <username> --password <password> --authenticationDatabase admin --db <database_name> --out /dump


docker cp <container_name>:/dump ~/Downloads/dump


```

### Restoring

- Need a user, admin

You can run the following in your mongodb (cli) client of choice to create a new user. A prompt will appear after running this command in which you can specify the user's password.

```
use admin

db.createUser({
    user: "username",
	pwd: passwordPrompt(),
	roles:[{role: "readWrite" , db:"<database_name>"}]})

```

- Copy dump files to container
Just like before, we should first make the dumped database files available within the docker container.

```
docker cp ~/Downloads/dump <container_name>:/dump

sudo docker cp ~/Documents/dev/elm/elm-db-bk mongodb:/elm-db-bk

```

- Restore

Now that the dump files are available within the container, run the following command to have everything be imported.

```
docker exec -i <container_name> /usr/bin/mongorestore --username <username> --password <password> --authenticationDatabase admin --db <database_name> /dump/<database_name>

sudo docker exec -i mongodb /usr/bin/mongorestore --username root --password root --authenticationDatabase admin --db elm /elm-db-bk

albert@albert-mint20:~/Documents/dev$ sudo docker exec -i mongodb /usr/bin/mongorestore --username root --password root --authenticationDatabase admin --db elm /elm-db-bk
2022-01-18T21:46:18.498+0000	The --db and --collection flags are deprecated for this use-case; please use --nsInclude instead, i.e. with --nsInclude=${DATABASE}.${COLLECTION}
2022-01-18T21:46:18.499+0000	building a list of collections to restore from /elm-db-bk dir
2022-01-18T21:46:18.499+0000	reading metadata for elm.orders from /elm-db-bk/orders.metadata.json

... ... ...

2022-01-18T21:46:21.747+0000	restoring indexes for collection elm.hongbaos from metadata
2022-01-18T21:46:21.747+0000	index: &idx.IndexDocument{Options:primitive.M{"background":true, "name":"id_1", "ns":"elm.hongbaos", "v":1}, Key:primitive.D{primitive.E{Key:"id", Value:1}}, PartialFilterExpression:primitive.D(nil)}
2022-01-18T21:46:21.776+0000	267535 document(s) restored successfully. 0 document(s) failed to restore.


```

- Cleaning up afterwards

If you'd like to delete the dump files from either docker container after importing, you can open a shell session within the docker container like so:

```
docker exec -it <container_name> /bin/bash

```

Now you can delete these files by running something like *rm -rf /dump*.













