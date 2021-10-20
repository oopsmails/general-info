
# Install and Configure Confluent Kafka on Ubuntu 20.04

- Ref:

https://developer.confluent.io/quickstart/kafka-local/



curl -O http://packages.confluent.io/archive/6.2/confluent-community-6.2.1.tar.gz

cd $programs/confluent-6.2.1


### Start the Kafka broker
We’ll launch the broker in KRaft mode, which means that it runs without ZooKeeper. Run this command first to configure the storage.


./bin/kafka-storage format \
                    --config ./etc/kafka/kraft/server.properties \
                    --cluster-id $(./bin/kafka-storage random-uuid)


./bin/kafka-server-start ./etc/kafka/kraft/server.properties

### List topics
./bin/kafka-topics --bootstrap-server :9092 --list

### Create topics
./bin/kafka-topics --bootstrap-server :9092 --create --topic test --partitions 3 --replication-factor 1 

### Delete topics
./bin/kafka-topics --bootstrap-server :9092 --delete --topic test <-------- use this
./bin/kafka-topics --bootstrap-server :9092 --delete --topic test.dlq <-------- use this
./bin/kafka-topics --bootstrap-server :9092 --delete --topic test.retry <-------- use this

### Describe topics
./bin/kafka-topics --bootstrap-server :9092 --describe --topic test <-------- use this

### Consumer
./bin/kafka-console-consumer --bootstrap-server :9092 --group testc1 --topic test
./bin/kafka-avro-console-consumer --bootstrap-server :9092 --group testc1 --topic test

### Producer
./bin/kafka-console-producer --broker-list localhost:9092 --topic test --property "parse.key=true" --property "key.separator=:"

./bin/kafka-console-producer --broker-list localhost:9092 --topic person_topic --property "parse.key=false"


./bin/kafka-avro-console-producer --broker-list localhost:9092 --topic person_topic --property "value.schema.file=/home/albert/Documents/sharing/github/springboot-dev-repo/spring-boot-kafka-avro/spring-boot-kafka-avro-basic/spring-boot-kafka-avro-basic-avro/src/main/avro/person.avsc"


./bin/kafka-avro-console-producer --broker-list localhost:9092 --topic person_topic --property "value.schema='{"type":"record","name":"PersonDto","namespace":"com.oopsmails.avro.dto","fields":[{"name":"firstName","type":"string","doc":"the first name of a person"},{"name":"lastName","type":"string","doc":"the last name of a person"}]}'

./bin/kafka-console-producer --broker-list localhost:9092 --topic person_topic --property "parse.key=false" --property "value.serializer=custom.class.serialization.JsonSerializer"

## Start Schema Registry

./bin/schema-registry-start ./etc/schema-registry/schema-registry.properties

schema-registry.properties, change `listeners=http://localhost:8081`, may need to change other App ports.


## Other

- kafka-console-producer send json
If you have JSON messages in the file, you can use following way to write in the kafka topic:

`bin/kafka-console-producer.sh --broker-list localhost:9092 --topic user-timeline < samplerecords.json`

Kafka producers reads the messages line by line using default LineMessageReader. Default Key and value serializers are **StringSerializer**. It will not validate whether there is a proper json or not, instead consider as raw string object as publish to a kafka topic. But if you want to validate you can define below configuration in console-producer command.

*key.serializer*
*value.serializer*

Example :

`kafka-console-producer --broker-list localhost:9092 --topic testTopic --property value.serializer=custom.class.serialization.JsonSerializer `

At the consumer side, you can do the similar approach. Use JsonDeserializer to read the data.


- kafka-console-producer send json

Confluent Platform 5.5 adds support for JSON Schema that also comes with kafka-json-schema-console-consumer and kafka-json-schema-console-producer.

Consuming messages with JSON schema

`kafka-json-schema-console-consumer --topic myTopic --bootstrap-server localhost:9092`

Producing message with JSON schema

```
kafka-json-schema-console-producer \
    --broker-list localhost:9092 \
    --topic myTopic \
    --property value.schema='{"type":"object","properties":{"f1":{"type":"string"}}}'
```

