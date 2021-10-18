# Spring Kafka Consuming Strategies and Error Handling | JaCoV | RU

https://www.youtube.com/watch?v=OnZ7JArSoiU

https://github.com/xepcules/kafka-consumer-strategies

https://jaceklaskowski.gitbooks.io/apache-kafka/content/kafka-docker.html


## Demo around


### Commands from tutorial

- Connect to docker container

https://docs.confluent.io/platform/current/quickstart/cos-docker-quickstart.html

docker exec -it broker bash <-------- use this

docker exec -it 77fcc0be141d bash


- Kafka console producer, can work with message key

kafka-console-producer --broker-list localhost:9092 \
--topic test \
--property "parse.key=true" \
-- property "key.separator=:"


- Show headers:

kafkacat -b localhost:9092 -t test-retry -C \
-f '\nKey (%k bytes): %k 
Value (%S bytes): %s 
Timestamp: %T 
Partition: %p 
Offset: %o 
Headers: %h\n'

- Clear topic, just delete it

bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic test



### Working in Container

- Examples:
docker-compose exec broker kafka-topics \
  --create \
  --bootstrap-server localhost:9092 \
  --replication-factor 1 \
  --partitions 2 \
  --topic test



docker-compose exec broker kafka-topics \
    --bootstrap-server :9092 \
    --list


- Working in container, "broker"
docker exec -it broker bash <-------- use this

kafka-topics \
    --bootstrap-server :9092 \
    --list

kafka-topics --bootstrap-server :9092 --list <-------- use this


kafka-topics \
	--bootstrap-server :9092 \
	--create \
	--topic test \
	--partitions 3 \
	--replication-factor 1

kafka-topics --bootstrap-server :9092 --create --topic test --partitions 3 --replication-factor 1 <-------- use this


kafka-topics \
    --bootstrap-server :9092 \
    --delete \
	--topic test

kafka-topics --bootstrap-server :9092 --delete --topic test <-------- use this


kafka-topics \
    --bootstrap-server :9092 \
    --describe \
    --topic test


kafka-topics --bootstrap-server :9092 --describe --topic test <-------- use this


### Using another terminal for Consumer

- Examples:

docker exec -t kafka-docker_kafka_1 \
  kafka-console-consumer.sh \
    --bootstrap-server :9092 \
    --group testc1 \
    --topic test


docker-compose exec -t broker \
  kafka-console-consumer \
    --bootstrap-server :9092 \
    --group testc1 \
    --topic test

- Working in container, "broker"

docker exec -it broker bash <-------- use this

kafka-console-consumer \
    --bootstrap-server :9092 \
    --group testc1 \
    --topic test


### Using another terminal for Producer

- Examples:

docker exec -it kafka-docker_kafka_1 \
  kafka-console-producer.sh \
    --broker-list :9092 \
    --topic t1


kafka-console-producer \
    --broker-list :9092 \
    --topic test

- Working in container, "broker"

docker exec -it broker bash <-------- use this

kafka-console-producer --broker-list localhost:9092 \
--topic test \
--property "parse.key=true" \
--property "key.separator=:"


### Testing message from producer terminal, should be seen in consumer terminal

```

- in Producer terminal, message data, copied from src/test/resources/test1.json

albert@albert-ubuntu20:~$ docker exec -it broker bash
[appuser@broker ~]$ kafka-console-producer --broker-list localhost:9092 \
> --topic test \
> --property "parse.key=true" \
> --property "key.separator=:"
>key1:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.12, "initiatedOn": "2021-05-23 23:59:37"}
>

```






