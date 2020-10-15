
# old way, but no topic created on kafka startup

- run in detached mode:

`docker run --name landoopkafka -d -p 2181:2181 -p 3030:3030 -p 8081-8083:8081-8083 -p 9581-9585:9581-9585 -p 9092:9092 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://172.17.255.255:9092 landoop/fast-data-dev:latest`

- re-run by name

`docker start landoopkafka`

- stop container

`docker stop landoopkafka`


`docker -exec -it landoopkafka bash`


docker exec -it CONTAINER_ID /bin/bash

docker exec -it 5164bb28935e /bin/bash

albert@eosvm:~$ docker exec -it 5164bb28935e /bin/bash
root@fast-data-dev / $ kafka-topics --zookeeper localhost:2181 --create --topic users --partitions 1 --replication-factor 1
Created topic users.
root@fast-data-dev / $ exit



`kafka-topics --zookeeper localhost:2181 --create --topic users --partitions 1 --replication-factor 1`

# New, will try to use docker-compose


https://stackoverflow.com/questions/58004386/i-need-to-create-a-kafka-image-with-topics-already-created

`docker run -d --name landoopkafka -p 2181:2181 -p 3030:3030 -p 8081:8081 -p 8082:8082 -p 8083:8083 -p 9092:9092 -e ADV_HOST=localhost landoop/fast-data-dev`

After running this command my container is up and running.

now i go to bash inside this container like 

`docker -exec -it landopkafka bash`

and create topic using this command

`kafka-topics --zookeeper localhost:2181 --create --topic hello_topic --partitions 1 --replication-factor 1`

My topic is created.


https://github.com/yan-khonski-it/kafka-compose








