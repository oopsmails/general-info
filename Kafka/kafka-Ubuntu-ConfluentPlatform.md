
# Install and Configure Confluent Kafka on Ubuntu 20.04

- Ref:

https://developer.confluent.io/quickstart/kafka-local/



curl -O http://packages.confluent.io/archive/6.2/confluent-community-6.2.1.tar.gz

cd $programs/confluent-6.2.1


Start the Kafka broker
We’ll launch the broker in KRaft mode, which means that it runs without ZooKeeper. Run this command first to configure the storage.


./bin/kafka-storage format \
                    --config ./etc/kafka/kraft/server.properties \
                    --cluster-id $(./bin/kafka-storage random-uuid)


./bin/kafka-server-start ./etc/kafka/kraft/server.properties


./bin/kafka-topics --bootstrap-server :9092 --list

./bin/kafka-topics --bootstrap-server :9092 --create --topic test --partitions 3 --replication-factor 1 

./bin/kafka-topics --bootstrap-server :9092 --delete --topic test <-------- use this
./bin/kafka-topics --bootstrap-server :9092 --delete --topic test.dlq <-------- use this
./bin/kafka-topics --bootstrap-server :9092 --delete --topic test.retry <-------- use this

./bin/kafka-topics --bootstrap-server :9092 --describe --topic test <-------- use this

./bin/kafka-console-consumer --bootstrap-server :9092 --group testc1 --topic test

./bin/kafka-console-producer --broker-list localhost:9092 --topic test --property "parse.key=true" --property "key.separator=:"










