# Kafka Knowledge: How To View Messages

- Ref:

https://stackoverflow.com/questions/44239027/how-to-view-kafka-message

## Kafka build in script
```
find . -name kafka-console-consumer.sh

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning

./kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning --max-messages 10

```
## Kowl - Apache Kafka Web UI

- https://github.com/cloudhut/kowl

- Non business version is free.

## KAFKA MAGIC

- https://www.kafkamagic.com/

- Kafka Magic Community Edition is FREE for personal and business use. Download Magic here!

## Kakfa console

- kafdrop

- Used in https://github.com/oopsmails/springboot-dev-repo/blob/develop/spring-boot-kafka-ms-email-files/docker-compose.yml



