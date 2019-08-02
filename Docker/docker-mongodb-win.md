
# MongoDB on Windows in Minutes with Docker

https://blog.jeremylikness.com/blog/2018-12-27_mongodb-on-windows-in-minutes-with-docker/

## Run (Not working)
- Local volume mounting, first in VM or Docker Desktop, "Settings", configure "Shared Driver".

`-v //dockerv/mongodata:/data/db`, then "//" means pointing to "C:/dockerv/mongodata"

Also, see "Docker-Jenkins.md", working sucessfully as well!

`docker run --name mongodb -v //dockerv/mongodata:/data/db -d -p 27017:27017 mongo:4.0.4`

`docker run --name mongodb -v //dockerv/mongodata:/data/db -d -p 27017:27017 mongo:4.0.4 --auth`

## Run (working)

docker volume create --name=mongodata

docker run --name mongodb -v mongodata:/data/db -d -p 27017:27017 mongo:4.0.4
docker run --name mongodb -v mongodata:/data/db -d -p 27017:27017 mongo:4.0.4

- user/pass
docker run --name mongodb -v mongodata:/data/db -d -p 27017:27017 mongo:4.0.4 --auth




### First, log into the running (non-authenticated) version.

`winpty docker exec -it mongodb bash`

(winpty is needed from a typical Windows command line. You can omit it to run from other terminals. There is nothing special about mongodb other than it’s the name I gave the container in the previous step).

### Open the MongoDB terminal:

`mongo`

### Let’s assume your database is called “mydatabase” and you want to set up a user named “myuser” with password “secret”. These two steps will take care of it for you (the database does not have to exist yet):

`use mydb`

`db.createUser({user:"user", pwd:"pass", roles:[{role:"readWrite", db: "mydb"}]});`

```
> use mydatabase
switched to db mydb
> db.createUser({user:"user", pwd:"pass", roles:[{role:"readWrite", db: "mydb"}]});
Successfully added user: {
        "user" : "user",
        "roles" : [
                {
                        "role" : "readWrite",
                        "db" : "mydb"
                }
        ]
}
```

### After that, you can exit out of the MongoDB terminal and the bash shell that’s running. Next, stop and remove the existing instance and launch a new one with authentication active:

`docker stop mongodb`

`docker rm mongodb`

`docker run --name mongodb -v mongodata:/data/db -d -p 27017:27017 mongo --auth`

`mongo "mongodb://user:pass@localhost:27017/mydb"`

### Now you can authenticate with the connection string:

`mongodb://myuser:secret@localhost:27017/mydatabase`

That’s it! Hopefully this simple set of steps is helpful for you to get up and running with MongoDB on your machine.

### Examples:

use mydb
db.createUser({user:"user", pwd:"pass", roles:[{role:"readWrite", db: "mydb"}]});

db.people.save({ firstname: "Nic", lastname: "Raboy" })
db.people.save({ firstname: "Maria", lastname: "Raboy" })

db.people.find({ firstname: "Nic" })


