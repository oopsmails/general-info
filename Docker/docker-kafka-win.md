# Kafka on Windows with Docker

## 20190731: Working

https://iteritory.com/kafka-docker-image-installation-usage-tutorial-windows/


### Run kafka docker, image from landoop/fast-data-dev:latest

`docker run --name kafka -p 2181:2181 -p 3030:3030 -p 8081-8083:8081-8083 -p 9581-9585:9581-9585 -p 9092:9092 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://192.168.99.100:9092 landoop/fast-data-dev:latest`

- run in detached mode:

`docker run --name kafka -d -p 2181:2181 -p 3030:3030 -p 8081-8083:8081-8083 -p 9581-9585:9581-9585 -p 9092:9092 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://192.168.99.100:9092 landoop/fast-data-dev:latest`

- re-run by name

`docker start kafka`

- change port because 8082 is in use

docker run --name kafka -p 2181:2181 -p 3030:3030 -p 9081-9083:8081-8083 -p 9581-9585:9581-9585 -p 9092:9092 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://192.168.99.100:9092 landoop/fast-data-dev:latest


### landoop's excellent web-portal

http://192.168.99.100:3030/

- if MacOS,

ifconfig |grep inet

http://192.168.232.128:3030/


### Testing: Also see C:\Github\springboot2-app-all\springboot2-app-all-kafka\KafkaSetup.md

cd C:\Software\kafka_2.11-2.1.0\bin\windows

- Normally, change localhost to 192.168.99.100
kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic kafkatest

- create a topic
kafka-topics.bat --create --zookeeper 192.168.99.100:2181 --replication-factor 1 --partitions 1 --topic kafkatest

- list topics
kafka-topics.bat --list --zookeeper 192.168.99.100:2181

- send messages:
kafka-console-producer.bat --broker-list 192.168.99.100:9092 --topic kafkatest

This is a message
This is another message

- start a consumer: with Warning, but still working
kafka-console-consumer.bat --bootstrap-server 192.168.99.100:9092 --topic kafkatest --from-beginning

C:\Software\kafka_2.11-2.1.0\bin\windows>kafka-console-consumer.bat --bootstrap-server 192.168.99.100:9092 --topic kafkatest --from-beginning
[2019-07-31 14:27:10,362] WARN [Consumer clientId=consumer-1, groupId=console-consumer-24315] Error while fetching metadata with correlation id 2 : {kafkatest=LEADER_NOT_AVAILABLE} (org.apache.kafka.clients.NetworkClient)

- start a consumer: GOOD
C:\Software\kafka_2.11-2.1.0\bin\windows>kafka-console-consumer.bat --bootstrap-server 192.168.99.100:9092 --topic kafkatest --from-beginning --partition 0

### SpringBoot:
C:\Github\springboot2-app-all\springboot2-app-all-kafka-web\src\main\java\com\oopsmails\springboot2\app\all\kafka\web\SpringBootKafkaWebApplication.java

Postman: POST

http://localhost:9000/kafka/publish?message=abc


===================================================================


https://www.e4developer.com/2018/05/20/how-to-easily-run-kafka-with-docker-for-development/

## Run (should be working): run images

- Setting up kafka net
Docker provides us with a concept of docker net. We can create a dedicated net on which the containers will be able to talk to each other:

docker network create kafka

- Configuring the Zookeeper container
First, we create a Zookeeper image, using port 2181 and our kafka net. I use fixed version rather than latest, to guarantee that the example will work for you. If you want to use a different version of the image, feel free to experiment:

docker run –net=kafka -d –name=zookeeper -e ZOOKEEPER_CLIENT_PORT=2181 confluentinc/cp-zookeeper:4.1.0

- Configuring the Kafka container
With the Zookeeper container up and running, you can create the Kafka container. We will place it on the kafka net, expose port 9092 as this will be the port for communicating and set a few extra parameters to work correctly with Zookeeper:

docker run –net=kafka -d -p 9092:9092 –name=kafka -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092 -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 confluentinc/cp-kafka:4.1.0


## Testing: 

Connecting to Kafka – DNS editing
One last catch here is that Kafka may not respond correctly when contacted on localhost:9092– the Docker communication happens via kafka:9092.

You can do that easily on Windows by editing the hostfile located in C:\Windows\System32\drivers\etc\hosts. You want to add the line pointing kafka to 127.0.0.1. Your hostfile should look something like this:


You can see the line pointing kafka to 127.0.0.1
If you are using OS other than Windows, you need to do an equivalent trick- pointing your kafka to 127.0.0.1.

With that all setup you can connect to your Kafka locally at kafka:9092! Congratulations!


##
winpty docker exec -it kafka bash



## Run (??): run docker compose file

- old
https://zablo.net/blog/post/setup-apache-kafka-in-docker-on-windows/

- new
https://medium.com/@rinu.gour123/kafka-docker-steps-to-run-apache-kafka-using-docker-1645e85acd50


- trying

https://iteritory.com/kafka-docker-image-installation-usage-tutorial-windows/

- working but NOT good, forwarding to 127.0.0.1 ... causing trouble in outside host file.

docker run --rm -p 2181:2181 -p 3030:3030 -p 8081-8083:8081-8083 -p 9581-9585:9581-9585 -p 9092:9092 -e ADV_HOST=127.0.0.1 landoop/fast-data-dev:latest

- this is still NOT GOOD, not forwarding to 127.0.0.1 and later on, outside, can use 192.168.99.100 to create producer and consumer

docker run --name kafka -p 2181:2181 -p 3030:3030 -p 8081-8083:8081-8083 -p 9581-9585:9581-9585 -p 9092:9092 landoop/fast-data-dev:latest

- this is GOOD, telling container to forward to 192.168.99.100
docker run --name kafka -p 2181:2181 -p 3030:3030 -p 8081-8083:8081-8083 -p 9581-9585:9581-9585 -p 9092:9092 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://192.168.99.100:9092 landoop/fast-data-dev:latest


Now, you can also access landoop's excellent web-portal by hitting http://127.0.0.1:3030. This portal will provide you a comprehensive visual representation of your Kafka setup.

http://192.168.99.100:3030/





===========================================

- docker kafka IllegalStateException: No entry found for connection 0

In my case I was receiving that while trying to connect to my Kafka container, I had to pass the following:

-e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092

-e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092





