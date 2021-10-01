# Kafka Knowledge: Schema Value vs Key

- Ref:

https://stackoverflow.com/questions/65202887/should-avro-be-used-to-on-both-the-key-and-value-in-kafka

## If Avro should be used on both the key and value of a Kafka message

That is upto how you are going to use the key. Keys are usually (not always) a single field, possibly a String or a number but not complex objects. That being the case, there is no reason to use Avro format for them.

## I've explored both use cases and I'm not really seeing the benefit of applying AVRO at the key level

You can evaluate the usage by considering what you will be putting in as key. If value is what you are mostly concerned about and that a simple string or a number would be enough to differentiate (or) classify your Kafka messages, you don't require Avro format.

Sometimes, there can be use-cases where multiple fields make up a key, just like we create a primary key in RDBMS out of multiple columns. If you suppose that your application has (or can have) such a use-case, then use avro in order to support schema evolution.

## And a follow-up if not using AVRO on the key what is the preferred converter (String, JSON, etc)

JSON and Avro are for complex objects like your custom POJOs, whilst others like String, Long etc are for single field values.

If I want to stream a user information which can be identified by a user_id, then user_id will be my Kafka message key. In such a case we can use String or Long.

Avro has a compact binary format. For more on why use Avro for Kafka see this article.


## Other

- You are not required to use avro for keys. If your key is of type string you may use org.apache.kafka.common.serialization.StringSerializer. If you want to use avro, you need to register the schema for each object type.


- Kafka messages are key/value pairs. What you set the key is up to you and the requirements of what you are implementing. Example ?????

The message key is used for partition assignment. Typically you would key a message based on the processing you expect to do, and any strict ordering you want to impose on the data. For example, if you want to have multiple parallel processes in the same consumer group with each process receiving all records for a given customer, you would key on the customer ID.

