# Spring Kafka Consuming Strategies and Error Handling | JaCoV | RU

https://www.youtube.com/watch?v=OnZ7JArSoiU

https://github.com/xepcules/kafka-consumer-strategies

https://jaceklaskowski.gitbooks.io/apache-kafka/content/kafka-docker.html


## Demo around

**Note: Using docker-compose is NOT working with test.retry case5 !!!**

See /general-info/Kafka/kafka-Ubuntu-ConfluentPlatform.md, to use unzipped Confluent Kafka Community version.


### Simple Demo

```
Start App in intellij

. cdto1.sh ckafka

./bin/kafka-console-producer --broker-list localhost:9092 --topic test --property "parse.key=true" --property "key.separator=:"

key-good:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 188.88, "initiatedOn": "2021-05-23 23:59:37"}

key-malformed:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": ss.13, "initiatedOn": "2021-05-23 23:59:38"}

key-amt-negative:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": -5.55, "initiatedOn": "2021-05-23 23:59:39"}

key-amt-too-big:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 1000001.66, "initiatedOn": "2021-05-23 23:59:40"}

```


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
kafka-topics --bootstrap-server :9092 --delete --topic test.dlq <-------- use this
kafka-topics --bootstrap-server :9092 --delete --topic test.retry <-------- use this


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
14:18:39.237 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Payment processing started: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=188.88, initiatedOn=2021-05-23T23:59:37, errorMessage=null)
14:18:39.238 DEBUG [mainListener-0-C-1] c.o.k.c.d.s.impl.AbsServiceImpl          - ABS processed payment successfully
14:18:39.240 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - <<< Payment processed: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=188.88, initiatedOn=2021-05-23T23:59:37, errorMessage=null)
```

- Malformed: skipped and threw away

key-malformed:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": ss.12, "initiatedOn": "2021-05-23 23:59:37"}

```
14:19:06.471 ERROR [mainListener-0-C-1] c.o.k.c.d.c.k.KafkaErrorHandler          - Error processing STARTED
14:19:06.473 ERROR [mainListener-0-C-1] c.o.k.c.d.c.k.KafkaErrorHandler          - Kafka error. Skipping message with topic test and offset 1 - malformed message: { "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": ss.12, "initiatedOn": "2021-05-23 23:59:37"} , exception: failed to deserialize; nested exception is org.apache.kafka.common.errors.SerializationException: Can't deserialize data [[123, 32, 34, 105, 100, 101, 109, 112, 111, 116, 101, 110, 99, 121, 75, 101, 121, 34, 58, 32, 34, 51, 99, 99, 53, 50, 100, 57, 55, 45, 99, 48, 101, 51, 45, 52, 98, 56, 52, 45, 98, 50, 50, 48, 45, 100, 98, 102, 52, 97, 99, 51, 53, 50, 100, 98, 99, 34, 44, 32, 34, 97, 109, 111, 117, 110, 116, 34, 58, 32, 115, 115, 46, 49, 50, 44, 32, 34, 105, 110, 105, 116, 105, 97, 116, 101, 100, 79, 110, 34, 58, 32, 34, 50, 48, 50, 49, 45, 48, 53, 45, 50, 51, 32, 50, 51, 58, 53, 57, 58, 51, 55, 34, 125]] from topic [test]
```

- Negative amount: to DLQ

key-amt-negative:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": -5.12, "initiatedOn": "2021-05-23 23:59:37"}

```
14:19:37.887 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Payment processing started: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=-5.12, initiatedOn=2021-05-23T23:59:37, errorMessage=null)
14:19:37.887 ERROR [mainListener-0-C-1] c.o.k.c.d.s.impl.AbsServiceImpl          - Amount can't be negative, found in Payment
14:19:37.887 ERROR [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - Exception for messageKey=key-amt-negative
14:19:37.888 ERROR [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - DLQ sending due to exception to topic=test.dlq
14:19:38.128 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - <<< Payment processed: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=-5.12, initiatedOn=2021-05-23T23:59:37, errorMessage=Amount can't be negative, found in Payment=Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=-5.12, initiatedOn=2021-05-23T23:59:37, errorMessage=null))
```

- Amount too big: to retry topic and then to DLQ

key-amt-too-big:{ "idempotencyKey": "3cc52d97-c0e3-4b84-b220-dbf4ac352dbc", "amount": 10000001.12, "initiatedOn": "2021-05-23 23:59:37"}

```
16:55:09.783 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Payment processing started: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=10000001.12, initiatedOn=2021-05-23T23:59:37, errorMessage=null)
16:55:09.783 ERROR [mainListener-0-C-1] c.o.k.c.d.s.impl.AbsServiceImpl          - ABS unavailable right now, sending to retry queue, Payment=Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=10000001.12, initiatedOn=2021-05-23T23:59:37, errorMessage=null)
16:55:09.783 ERROR [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - Exception for messageKey=key-amt-too-big
16:55:09.783 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - calcTopicInternal, topic, groupId, e, toDlq = [test], [mainListener], [com.oklimenko.kafka.consumer.demo.exception.AbsUnavailableException: Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc], [false]
16:55:09.783 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - RETRY sending due to exception to topic=test.retry
16:55:09.789 DEBUG [mainListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - <<< Payment processed: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=10000001.12, initiatedOn=2021-05-23T23:59:37, errorMessage=Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc)
16:55:09.802 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Retry Payment processed: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=10000001.12, initiatedOn=2021-05-23T23:59:37, errorMessage=Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc)
16:55:09.802 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Retry # 1, delayMillis=500
16:55:09.914 ERROR [retryListener-0-C-1] c.o.k.c.d.s.impl.AbsServiceImpl          - ABS unavailable right now, sending to retry queue, Payment=Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=10000001.12, initiatedOn=2021-05-23T23:59:37, errorMessage=Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc)
16:55:09.915 ERROR [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - Exception for messageKey=key-amt-too-big
16:55:09.915 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - calcTopicInternal, topic, groupId, e, toDlq = [test.retry], [retryListener], [com.oklimenko.kafka.consumer.demo.exception.AbsUnavailableException: Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc], [false]
16:55:09.915 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - RETRY sending due to exception to topic=test.retry
16:55:09.918 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - <<< Retry # 1, idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc
16:55:09.919 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-2, groupId=retryListener] Revoke previously assigned partitions test.retry-0
16:55:09.920 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-2, groupId=retryListener] Member consumer-retryListener-2-8ea9b877-3a78-4563-9d37-c3cbb02e20e6 sending LeaveGroup request to coordinator localhost:9092 (id: 2147483646 rack: null) due to the consumer unsubscribed from all topics
16:55:10.429 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-3, groupId=retryListener] Discovered group coordinator localhost:9092 (id: 2147483646 rack: null)
16:55:10.430 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-3, groupId=retryListener] (Re-)joining group
16:55:10.433 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-3, groupId=retryListener] Join group failed with org.apache.kafka.common.errors.MemberIdRequiredException: The group member needs to have a valid member id before actually entering a consumer group
16:55:10.433 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-3, groupId=retryListener] (Re-)joining group
16:55:10.436 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-3, groupId=retryListener] Finished assignment for group at generation 3: {consumer-retryListener-3-331fef80-80b6-485e-952d-b9cdf6878f61=Assignment(partitions=[test.retry-0])}
16:55:10.439 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-3, groupId=retryListener] Successfully joined group with generation 3
16:55:10.440 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-3, groupId=retryListener] Adding newly assigned partitions: test.retry-0
16:55:10.443 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-3, groupId=retryListener] Setting offset for partition test.retry-0 to the committed offset FetchPosition{offset=1, offsetEpoch=Optional.empty, currentLeader=LeaderAndEpoch{leader=Optional[localhost:9092 (id: 1 rack: null)], epoch=0}}
16:55:10.451 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Retry Payment processed: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=10000001.12, initiatedOn=2021-05-23T23:59:37, errorMessage=Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc)
16:55:10.452 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Retry # 2, delayMillis=1000
16:55:10.553 ERROR [retryListener-0-C-1] c.o.k.c.d.s.impl.AbsServiceImpl          - ABS unavailable right now, sending to retry queue, Payment=Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=10000001.12, initiatedOn=2021-05-23T23:59:37, errorMessage=Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc)
16:55:10.553 ERROR [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - Exception for messageKey=key-amt-too-big
16:55:10.553 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - calcTopicInternal, topic, groupId, e, toDlq = [test.retry], [retryListener], [com.oklimenko.kafka.consumer.demo.exception.AbsUnavailableException: Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc], [false]
16:55:10.553 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - RETRY sending due to exception to topic=test.retry
16:55:10.557 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - <<< Retry # 2, idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc
16:55:10.558 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-3, groupId=retryListener] Revoke previously assigned partitions test.retry-0
16:55:10.558 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-3, groupId=retryListener] Member consumer-retryListener-3-331fef80-80b6-485e-952d-b9cdf6878f61 sending LeaveGroup request to coordinator localhost:9092 (id: 2147483646 rack: null) due to the consumer unsubscribed from all topics
16:55:11.565 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-4, groupId=retryListener] Discovered group coordinator localhost:9092 (id: 2147483646 rack: null)
16:55:11.566 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-4, groupId=retryListener] (Re-)joining group
16:55:11.571 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-4, groupId=retryListener] Join group failed with org.apache.kafka.common.errors.MemberIdRequiredException: The group member needs to have a valid member id before actually entering a consumer group
16:55:11.571 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-4, groupId=retryListener] (Re-)joining group
16:55:11.575 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-4, groupId=retryListener] Finished assignment for group at generation 5: {consumer-retryListener-4-9f90049b-2fd6-4954-aa10-02d31d7c80d0=Assignment(partitions=[test.retry-0])}
16:55:11.578 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-4, groupId=retryListener] Successfully joined group with generation 5
16:55:11.578 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-4, groupId=retryListener] Adding newly assigned partitions: test.retry-0
16:55:11.582 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-4, groupId=retryListener] Setting offset for partition test.retry-0 to the committed offset FetchPosition{offset=2, offsetEpoch=Optional.empty, currentLeader=LeaderAndEpoch{leader=Optional[localhost:9092 (id: 1 rack: null)], epoch=0}}
16:55:11.589 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Retry Payment processed: Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=10000001.12, initiatedOn=2021-05-23T23:59:37, errorMessage=Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc)
16:55:11.590 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - >>> Retry # 3, delayMillis=3000
16:55:11.691 ERROR [retryListener-0-C-1] c.o.k.c.d.s.impl.AbsServiceImpl          - ABS unavailable right now, sending to retry queue, Payment=Payment(idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc, amount=10000001.12, initiatedOn=2021-05-23T23:59:37, errorMessage=Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc)
16:55:11.691 ERROR [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - Exception for messageKey=key-amt-too-big
16:55:11.691 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - calcTopicInternal, topic, groupId, e, toDlq = [test.retry], [retryListener], [com.oklimenko.kafka.consumer.demo.exception.AbsUnavailableException: Payment idempotency key = 3cc52d97-c0e3-4b84-b220-dbf4ac352dbc], [true]
16:55:11.691 ERROR [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - DLQ sending due to exception to topic=test.dlq
16:55:11.694 DEBUG [retryListener-0-C-1] c.o.k.c.d.c.PaymentKafkaConsumer         - <<< Retry # 3, idempotencyKey=3cc52d97-c0e3-4b84-b220-dbf4ac352dbc
16:55:11.694 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-4, groupId=retryListener] Revoke previously assigned partitions test.retry-0
16:55:11.694 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-4, groupId=retryListener] Member consumer-retryListener-4-9f90049b-2fd6-4954-aa10-02d31d7c80d0 sending LeaveGroup request to coordinator localhost:9092 (id: 2147483646 rack: null) due to the consumer unsubscribed from all topics
16:55:14.718 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-5, groupId=retryListener] Discovered group coordinator localhost:9092 (id: 2147483646 rack: null)
16:55:14.719 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-5, groupId=retryListener] (Re-)joining group
16:55:14.723 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-5, groupId=retryListener] Join group failed with org.apache.kafka.common.errors.MemberIdRequiredException: The group member needs to have a valid member id before actually entering a consumer group
16:55:14.723 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-5, groupId=retryListener] (Re-)joining group
16:55:14.725 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-5, groupId=retryListener] Finished assignment for group at generation 7: {consumer-retryListener-5-95ab3f9b-febf-48ee-bdee-6b745906f328=Assignment(partitions=[test.retry-0])}
16:55:14.728 INFO  [retryListener-0-C-1] o.a.k.c.c.i.AbstractCoordinator          - [Consumer clientId=consumer-retryListener-5, groupId=retryListener] Successfully joined group with generation 7
16:55:14.729 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-5, groupId=retryListener] Adding newly assigned partitions: test.retry-0
16:55:14.731 INFO  [retryListener-0-C-1] o.a.k.c.c.i.ConsumerCoordinator          - [Consumer clientId=consumer-retryListener-5, groupId=retryListener] Setting offset for partition test.retry-0 to the committed offset FetchPosition{offset=3, offsetEpoch=Optional.empty, currentLeader=LeaderAndEpoch{leader=Optional[localhost:9092 (id: 1 rack: null)], epoch=0}}

```




