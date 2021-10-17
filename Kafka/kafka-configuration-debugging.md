
# Debugging Kafka Configuration

## kafka broker may not be available

- Ref:

https://stackoverflow.com/questions/46158296/kafka-broker-not-available-at-starting/47619310

- Solution:

So I start by asking Zookeeper some data

`echo dump | nc localhost 2181`

I get back something like this

```
SessionTracker dump:
Session Sets (3):
0 expire at Sun Dec 03 18:15:48 GST 2017:
0 expire at Sun Dec 03 18:15:51 GST 2017:
1 expire at Sun Dec 03 18:15:54 GST 2017:
0x1601c9a25190000
ephemeral nodes dump:
Sessions with Ephemerals (1):
0x1601c9a25190000:
/controller
/brokers/ids/0
```


I read this to mean that I have 1 Broker available - and it is has an id of 0.

So, lets find about that broker.

`bin/zookeeper-shell.sh localhost:2181 <<< "get /brokers/ids/0"`

`./bin/zookeeper-shell.sh localhost:2181 ls /brokers/ids`

And I see

```
{"listener_security_protocol_map":{"PLAINTEXT":"PLAINTEXT"},"endpoints":["PLAINTEXT://192.168.1.220:9092"],"jmx_port":-1,"host":"192.168.1.220","timestamp":"1512308520781","port":9092,"version":4}
cZxid = 0x69
ctime = Sun Dec 03 17:42:00 GST 2017
mZxid = 0x69
mtime = Sun Dec 03 17:42:00 GST 2017
pZxid = 0x69
cversion = 0
dataVersion = 0
aclVersion = 0
ephemeralOwner = 0x1601c9a25190000
dataLength = 196
numChildren = 0
```


This rather startled me ... PLAINTEXT://192.168.1.220:9092, so when I changed my connect string to read

`bin/kafka-console-producer.sh  --broker-list PLAINTEXT://192.168.1.220:9092  --topic test`


It all now worked.

- what if no zookeeper

`bin/kafka-broker-api-versions.sh --bootstrap-server BROKER | grep 9092`


