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

kafka-console-consumer --bootstrap-server :9092 --group testc1 --topic test

```
albert@albert-ubuntu20:~$ docker exec -it broker bash
[appuser@broker ~]$ kafka-console-consumer --bootstrap-server :9092 --group testc1 --topic test
{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.12, "initiatedOn": "2021-05-23 23:59:37"}
{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.12, "initiatedOn": "2021-05-23 23:59:37"}
{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.12, "initiatedOn": "2021-05-23 23:59:37"}
{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.12, "initiatedOn": "2021-05-23 23:59:37"}
{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": ss.12, "initiatedOn": "2021-05-23 23:59:37"} <----- this is ok, but SpringBoot app cannot process it because Payment object
{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.12, "initiatedOn": "2021-05-23 23:59:37"}
^CProcessed a total of 6 messages
```


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

kafka-console-producer --broker-list localhost:9092 --topic test --property "parse.key=true" --property "key.separator=:"


### Testing message from producer terminal, should be seen in consumer terminal

```

- in Producer terminal, message data, copied from src/test/resources/test1.json

albert@albert-ubuntu20:~$ docker exec -it broker bash
[appuser@broker ~]$ kafka-console-producer --broker-list localhost:9092 --topic test --property "parse.key=true" --property "key.separator=:"
>key1:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.12, "initiatedOn": "2021-05-23 23:59:37"}
>

```

- Normal case:
key1:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.12, "initiatedOn": "2021-05-23 23:59:37"}

- Start Spring boot app, processing of message can see in Console

branch *case-1-simple-after*

#### Error cases: 

key1:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": ss.12, "initiatedOn": "2021-05-23 23:59:37"}

- case-1-simple-after
SpringBoot app cannot process it because Payment object, will see

`Caused by: com.fasterxml.jackson.core.JsonParseException: Unrecognized token 'ss': was expecting (JSON String, Number, Array, Object or token 'null', 'true' or 'false')
` 
and never stop!!!!

- case-2-error-handler-after

```
11:24:17.729 ERROR [tenerEndpointContainer#0-0-C-1] c.o.k.c.d.c.k.KafkaErrorHandler          - Kafka error. Skipping message with topic test and offset 8 - malformed message: { "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": ss.12, "initiatedOn": "2021-05-23 23:59:37"} , exception: failed to deserialize; nested exception is org.apache.kafka.common.errors.SerializationException: Can't deserialize data [[123, 32, 34, 105,
```

- case-3-spring-retry-after

23:42 of 1:00:58

For example, we retry 3 times and if still cannot process the message, then we put it in Dead Letter Queue.

```

@KafkaListener(topics = "#{'${kafka.payment.topics.input}'.split(',')}",

    topics:
      input: test
      dlq: test.dlq

factory.setRetryTemplate(kafkaRetry());
factory.setRecoveryCallback(this::retryOption1); <--------- retry options, here, we send it to DLQ

fixedBackOffPolicy.setBackOffPeriod(3 * 1000L); <---------- 3 seconds

if (Boolean.TRUE.equals(retryContext.getAttribute(RetryContext.EXHAUSTED))) <--------------- what to do after last retry, here, sending to DLQ

```

Add logs:

KafkaConsumerConfig.java
log.debug("consumerRecord:  key = {}, value = {}", consumerRecord.key(), consumerRecord.value());


key1:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.12, "initiatedOn": "2021-05-23 23:59:37"}

key2:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": -5.12, "initiatedOn": "2021-05-23 23:59:37"}

Still, having drawbacks, for example, , stacking up DLQ, memory, reboot handling ...


- case-4-spring-SeekToCurrentErrorHandler

30:39

Latest Spring SeekToCurrentErrorHandler, similiar to case 3, same pros and cons, just wrapping case3 in *SeekToCurrentErrorHandler*.  

See, AppPropertiesConfig.java.  

```
factory.setErrorHandler(new KafkaErrorHandler()); // case 3


factory.setErrorHandler(new SeekToCurrentErrorHandler( // case 4

```

- case-5-different-queues-with-delay-2

30:51

```
    topics:
      input: test
      dlq: test.dlq
      retry: test.retry

    retries:
      1: 500
      2: 1000
      3: 3000

AbsServiceImpl
business logic

PaymentKafkaConsumer

retry times passed in header
@Header("retry") byte[] retryBytes,
Integer retry = Integer.valueOf(new String(retryBytes, StandardCharsets.UTF_8));

```

## Final Tesing with Case5


- Good:

key-good:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 188.88, "initiatedOn": "2021-05-23 23:59:37"}

```
13:27:02.893 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Payment processing started: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=188.88, initiatedOn=2021-05-23T23:59:37, errorMessage=null)
13:27:02.893 DEBUG [mainListener-0-C-1] c.o.k.c.d.s.impl.AbsServiceImpl          - ABS processed payment successfully
13:27:02.894 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - <<< Payment processed: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=188.88, initiatedOn=2021-05-23T23:59:37, errorMessage=null)
```

- Malformed: skipped and threw away

key-malformed:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": ss.12, "initiatedOn": "2021-05-23 23:59:37"}

```
13:30:57.065 ERROR [mainListener-0-C-1] c.o.k.c.d.c.k.KafkaErrorHandler          - Error processing STARTED
13:30:57.066 ERROR [mainListener-0-C-1] c.o.k.c.d.c.k.KafkaErrorHandler          - Kafka error. Skipping message with topic test and offset 1 - malformed message: { "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": ss.12, "initiatedOn": "2021-05-23 23:59:37"} , exception: failed to deserialize; nested exception is org.apache.kafka.common.errors.SerializationException: Can't deserialize data [[123, 32, 34, 105, 100, 101, 109, 112, 111, 116, 101, 110, 99, 121, 75, 101, 121, 34, 58, 32, 34, 51, 99, 99, 53, 50, 100, 57, 55, 45, 99, 48, 101, 51, 45, 52, 98, 56, 52, 45, 98, 50, 50, 48, 45, 100, 98, 102, 52, 97, 99, 51, 53, 50, 100, 98, 99, 34, 44, 32, 34, 97, 109, 111, 117, 110, 116, 34, 58, 32, 115, 115, 46, 49, 50, 44, 32, 34, 105, 110, 105, 116, 105, 97, 116, 101, 100, 79, 110, 34, 58, 32, 34, 50, 48, 50, 49, 45, 48, 53, 45, 50, 51, 32, 50, 51, 58, 53, 57, 58, 51, 55, 34, 125]] from topic [test]
```

- Negative amount: to DLQ

key-amt-negative:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": -5.12, "initiatedOn": "2021-05-23 23:59:37"}

```
13:32:33.157 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Payment processing started: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=-5.12, initiatedOn=2021-05-23T23:59:37, errorMessage=null)
13:32:33.157 ERROR [mainListener-0-C-1] c.o.k.c.d.s.impl.AbsServiceImpl          - Amount can't be negative, found in Payment
13:32:33.157 ERROR [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - Exception for messageKey=key-amt-negative
13:32:33.157 ERROR [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - DLQ sending due to exception to topic=test.dlq
13:32:33.160 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - <<< Payment processed: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=-5.12, initiatedOn=2021-05-23T23:59:37, errorMessage=Amount can't be negative, found in Payment=Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=-5.12, initiatedOn=2021-05-23T23:59:37, errorMessage=null))
```

- Amount too big: to retry topic

key-amt-too-big:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.12, "initiatedOn": "2021-05-23 23:59:37"}

```

- After restart

13:37:35.555 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Retry Payment processed: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=1000001.12, initiatedOn=2021-05-23T23:59:37, errorMessage=Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc)
13:37:35.556 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Retry # 1, delayMillis=500
13:37:35.663 ERROR [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - Exception for messageKey=key-amt-too-big
13:37:35.663 ERROR [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - DLQ sending due to exception to topic=test.dlq
13:37:35.845 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - <<< Retry # 1, idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc
13:37:35.846 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-2, groupId=retryListener] Revoke previously assigned partitions test.retry-0

```




