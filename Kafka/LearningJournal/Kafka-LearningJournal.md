

# Learning Notes

## Kafka-LearningJournal-04_core_concepts.mp4

### Partition

- The message, data, is too big for one computer to store it
- The producer itself determines how many partitions to separate a Kafka Topic

### offset

- A sequence id given to messages as they arrive in a partition
- offset is a local concept of a partition

### Unique Identifier of a Message

- Topic + Partition + offset

### Consumer Group

- A group of consumers acting as a single logical unit
- Deal with a large task, scaling up

### Fault Tolerance

- Enabling a system to continue operation properly in the event of the failure of some of its components.

### Replication Factor

- Number of total copies

### Leader and Follower (Brokers)

- Every partition has a leader
- Leader takes responsibity of communicating to Productor and Consumer, takes care of all requests and responses
- Leader recieves message partition and kafka will idetifies Followers based on replication factor and Followers will copy the partition from Leader

### Command to Start Brokers

- Each broker needs a server-n.properties file
- Change the broker.id, listeners (port). log.dirs in the properties file

e.g,

`bin/kafka-server-start.sh config/server-1.properties`

### Create topic with name, partitions, replication-factor

e.g, 

`bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic TestTopicABC --partitions 2 --replication-factor 3`

### Command to check

`bin/kafka-topics.sh --zookeeper localhost:2181 --describe --topic TestTopicABC`

### Configuration Parameter

- log.retention.ms, log.retention.bytes, configures message backup for query. Remember, kafka is not a db.

### Producer

- Can Fire and Forget ... or

- Sync send

RecordMetadata metadata = producer.send(ProducerRecord record).get(); <--- get() from Future obj

- Async send, callback method

producer.send(ProducerRecord record, new MyProducerCallBack())

MyProducerCallBack implements Callback {
    @Override
    public void onCompletion(RecordMetadata metadata, Exception e) {
        if (e != null) {
            .....
        }
    }
}

- max.in.flight.requests.per.connection,

define how many requests sent to server before fetch a response, default is 5

### A flaw of Async sending

- Record1 to 10, two batches
- Batch1 failed, but Batch2 success
- Then retry Batch1 and success
- LOSE the order of records!!!

Solution:

- Use Synchronous send
- max.in.flight.requests.per.connection = 1

### Consumer

- How to read in parallel? A: create consumer group
- What about duplicate reads? Will all these consumers in one consumer group read the same message? A: NO
    - Example, one topic, 4 partitions
    - if one consumer in consumer group, then ok
    - if two consumers, then p0, p1 to c1 and p2, p3 to c2
    - if three, may, p0 to c1, p1 to c2 and p2, p3 to c2
    - NOTE: consumers don't share partition! So, one specific consumer will NOT read same partition again, and one partition will only go to one consumer
- How consumers enter/exit groups? A: **Group Coordinator**
    - One broker will be elected as a Group Corordinator
    - Each new Consumer Group joining through Group Coordinator
    - First consumer in the Consumer Group is the Leader

Kafka\LearningJournal\Kafka-LearningJournal-23-GroupCoordinatorAndConsumerLeaderInAction.PNG

### Consumer Example

- No need to worry about creating cosumer group or who is the leader, etc.
- One consumer can subscribe to multiple topics
- When consumer.poll(100), make sure the number can make each iteration completes in less than 3 seconds
- Set hartbeat.interval.ms and session.timeout.ms to higher if you can't poll every 3 seconds
- Consumer can be configured to sleep after a certain time period or exit when getting an empty ConsumerRecord

### Kafka Offsets

- Current Offset

Kafka Broker remembers the index of next sending message, i.e, Sent Records

- Committed Offset

The offset position that is already processed by a consumer, i.e, Processed Records

- Committed Offset is for if adding new consumer!!!

### How to commit?

- Auto Commit: when rebalace and adding consumer, may send messages to new consumer again, while the messages was already sent to old consumer, because old consumer hasn't sent the Committed Offset back yet!
    - enable.auto.commit = true
    - auto.commit.interval.ms, default 5000

- Manual Commit:
    - - enable.auto.commit = false
    - Commit Sync, will retry if failed
    - Commit Async, will not retry


### Stopped at Kafka-LearningJournal-20_exactly_once_processing.mp4






