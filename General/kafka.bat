@echo off

cd /D C:\tmp
rmdir kafka-logs
rmdir zookeeper

cd /D C:\Software\kafka_2.11-2.1.0\bin\windows


echo 'Starting zookeeper-server .....'
start zookeeper-server-start.bat ../../config/zookeeper.properties

timeout 10

echo 'Starting kafka-server .....'
start kafka-server-start.bat ../../config/server.properties

timeout 10

echo 'Starting kafka-producer .....'
start kafka-console-producer.bat --broker-list localhost:9092 --topic kafkatest

timeout 5

echo 'Starting kafka-consumer .....'
start kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic kafkatest --from-beginning

rem exit



