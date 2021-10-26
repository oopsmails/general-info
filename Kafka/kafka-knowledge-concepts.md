
# Kafka Knowledges


## Consumer groupId

- Ref:

https://stackoverflow.com/questions/41376647/understanding-consumer-group-id

```
Consumers label themselves with a consumer group name, and each record published to a topic is delivered to one consumer instance within each subscribing consumer group. Consumer instances can be in separate processes or on separate machines.

If all the consumer instances have the same consumer group, then the records will effectively be load balanced over the consumer instances.

If all the consumer instances have different consumer groups, then each record will be broadcast to all the consumer processes.
```


The group.id is a string that uniquely identifies the group of consumer processes to which this consumer belongs




## UI Tools

### akhp



```
micronaut:
  server:
    port: 8082

akhq:
  connections:
    local:
      properties:
        bootstrap.servers: "localhost:9092"
      schema-registry:
        url: "http://localhost:8081" # schema registry url (optional)
        type: "confluent" # schema registry type (optional). Supported types are "confluent" (default) or "tibco"

  # Configure avro-to-json serializer
  avro-serializer:
    json.serialization.inclusions: # ObjectMapper serialization inclusions used for avro-to-json conversion for display in the UI.
    # Supports Enums in JsonInclude.Include from Jackson library
      - NON_NULL


##
elif test "$1" = "akhq"
then
	cd $sharing/jars/akhq
	java -Dmicronaut.config.files=application.yml -jar akhq.jar
##

```


