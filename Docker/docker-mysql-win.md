


# MySQL on Windows with Docker

## Step 1: Get the docker image of MySQL
docker pull mysql/mysql-server:latest


## Step 2: Start running a docker container from MySQL image

- print the logs of mysql
docker logs mysql1

docker volume create --name=mysqldb

- If you only want to access it locally, it’s enough, but if you want to access your mysql server remotely, you need mapping the port 3306 of the container to port 3306 of the host machine. Also, you need to set the environment variable MYSQL_ROOT_HOST with wildcards to allow root connections from other hosts:

docker run - name=mysql1 -e MYSQL_ROOT_HOST=% -p 3306:3306 -d mysql/mysql-server

docker run --name mysqldb -p 3306:3306 -d -v mysqldb:/var/lib/mysql -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7

docker run --name mysqldb -p 3306:3306 -v mysqldb:/var/lib/mysql -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=root -d mysql/mysql-server:latest

- Can use intellij datasource to test

jdbc:mysql://192.168.99.100:3306

root/root

Ref: 

https://medium.com/@backslash112/start-a-remote-mysql-server-with-docker-quickly-9fdff22d23fd



