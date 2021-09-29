
# Install and Configure Apache Kafka on Ubuntu 20.04

- Ref:

https://computingforgeeks.com/configure-apache-kafka-on-ubuntu/


## Trouble shooting

- virtualbox apache kafka topic disappeared after restart

There can be two potential problems

If it is kafka running in docker, then docker image restart always cleans up the previous state and creates a new cluster hence all topics are lost.

Check the log.dir or Zookeeper data path. If either is set to /tmp directory, it will be cleaned on each reboot. Hence you will lose all logs and topics will be lost. 

Go to zookeeper.properties, set *dataDir=/var/zookeeper*

Ref: https://stackoverflow.com/questions/52953858/after-reboot-kafka-topic-appears-to-be-lost

- kafka no broker after create cluster

In server.properties, in kafka-server/config folder, 

uncomment this line

`listeners=PLAINTEXT://:9092`

changed this to

`listeners=PLAINTEXT://127.0.0.1:9092`

**in my case, localhost**, not hostname, e.g, albert, 127.0.0.1 or ip.

Ref: https://stackoverflow.com/questions/46158296/kafka-broker-not-available-at-starting/47619310

bin/kafka-console-producer.sh  --broker-list PLAINTEXT://192.168.1.220:9092  --topic test

- Run my application to verify

Do NOT use, spring-boot-kafka-admin/src/main/java/com/oopsmails/springboot/kafka/admin/KafkaApplication.java

Use, spring-boot-kafka-docker/src/main/java/com/oopsmails/springboot/kafka/SpringKafkaDockerApplication.java

in spring-boot-kafka-docker/src/main/resources/application.yaml,

bootstrapAddress, has to be changed to the same as in kafka-server/config/server.properties

Otherwise, error "kafka could not be established. broker may not be available"


## Defining other terms you will encounter
- Topic: 
  A topic is a common name used to store and publish a particular stream of data. For example if you would wish to store all the data about a page being clicked, you can give the Topic a name such as "Added Customer".
- Partition: 
  Every topic is split up into partitions ("baskets"). When a topic is created, the number of partitions need to be specified but can be increased later as need arises. Each message gets stored into partitions with an incremental id known as its Offset value.
- Kafka Broker: 
  Every server with Kafka installed in it is known as a broker. It is a container holding several topics having their partitions.
- Zookeeper: 
  Zookeeper manages Kafka’s cluster state and configurations.

## Apache Kafka Use Cases
The following are some of the applications where you can take advantage of Apache Kafka:

- Message Broking: In comparison to most messaging systems Kafka has better throughput, built-in partitioning, replication, and fault-tolerance which makes it a good solution for large scale message processing applications
- Website Activity Tracking
- Log Aggregation: Kafka abstracts away the details of files and gives a cleaner abstraction of log or event data as a stream of messages.
- Stream Processing: capturing data in real-time from event sources; storing these event streams durably for later retrieval; and routing the event streams to different destination technologies as needed
- Event Sourcing: This is a style of application design where state changes are logged as a time-ordered sequence of records.
- Commit Log: Kafka can serve as a kind of external commit-log for a distributed system. The log helps replicate data between nodes and acts as a re-syncing mechanism for failed nodes to restore their data.
- Metrics: This involves aggregating statistics from distributed applications to produce centralized feeds of operational data.


## Installing Apache Kafka on Ubuntu 20.04

- Step 1: Preparing your Ubuntu Server
Update your fresh Ubuntu 20.04 server and get Java installed as illustrated below.

```
sudo apt update && sudo apt upgrade
sudo apt install default-jre wget git unzip -y
sudo apt install default-jdk -y
```


- Step 2: Fetch Kafka on Ubuntu 20.04
After Java is well installed, let us now fetch Kafka sources. Head over to Downloads and look for the Latest release and get the sources under Binary downloads. Click on the one that is recommended by Kafka and you will be redirected to a page that has a link you can use to fetch it.
```
cd ~
wget https://downloads.apache.org/kafka/2.6.0/kafka_2.13-2.6.0.tgz
sudo mkdir /usr/local/kafka-server && cd /usr/local/kafka-server
sudo tar -xvzf ~/kafka_2.13-2.6.0.tgz --strip 1
```
Archive’s contents will be extracted into /usr/local/kafka-server/ due to –strip 1 flag set.

- Step 3: Create Kafka and Zookeeper Systemd Unit Files
Systemd unit files for Kafka and Zookeeper will pretty much help in performing common service actions such as starting, stopping, and restarting Kafka. This makes it adapt to how other services are started, stopped, and restarted which is beneficial and consistent.

Let us begin with Zookeeper service:

```
$ sudo vim /etc/systemd/system/zookeeper.service

[Unit]
Description=Apache Zookeeper Server
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
ExecStart=/usr/local/kafka-server/bin/zookeeper-server-start.sh /usr/local/kafka-server/config/zookeeper.properties
ExecStop=/usr/local/kafka-server/bin/zookeeper-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
```


Then for Kafka service. Make sure your JAVA_HOME configs are well inputted or Kafka will not start.
```
$ sudo vim /etc/systemd/system/kafka.service

[Unit]
Description=Apache Kafka Server
Documentation=http://kafka.apache.org/documentation.html
Requires=zookeeper.service
After=zookeeper.service

[Service]
Type=simple
Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
ExecStart=/usr/local/kafka-server/bin/kafka-server-start.sh /usr/local/kafka-server/config/server.properties
ExecStop=/usr/local/kafka-server/bin/kafka-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target

```

After you are done adding the configurations, reload the systemd daemon to apply changes and then start the services. You can check their status as well.

```
sudo systemctl daemon-reload
sudo systemctl enable --now zookeeper
sudo systemctl enable --now kafka
sudo systemctl status kafka zookeeper
```

- Step 4: Install Cluster Manager for Apache Kafka (CMAK) | Kafka Manager
CMAK (previously known as Kafka Manager) is an opensource tool for managing Apache Kafka clusters developed by Yahoo.
```
cd ~
git clone https://github.com/yahoo/CMAK.git
```

- Step 5: Configure CMAK on Ubuntu 20.04
The minimum configuration is the zookeeper hosts which are to be used for CMAK (pka kafka manager) state. This can be found in the application.conf file in conf directory. Change cmak.zkhosts="my.zookeeper.host.com:2181″ and you can also specify multiple zookeeper hosts by comma delimiting them, like so: cmak.zkhosts="my.zookeeper.host.com:2181,other.zookeeper.host.com:2181". The host names can be ip addresses too.

```
$ vim ~/CMAK/conf/application.conf
cmak.zkhosts="localhost:2181
```
After you are done adding your zookeeper hosts, the command below will create a zip file which can be used to deploy the application. You should see a lot of output on your terminal as files are downloaded and compiled. Give it time to finish and compile because it takes a while.
```
cd ~/CMAK/
./sbt clean dist
```
When all is done, you should see a message like below:
```
[info] Your package is ready in /home/tech/CMAK/target/universal/cmak-3.0.0.5.zip
```
Change into the directory where the zip file is located and unzip it:
```
$ cd ~/CMAK/target/universal
$ unzip cmak-3.0.0.5.zip
$ cd cmak-3.0.0.5
```

- Step 6: Starting the service and Accessing it
After extracting the produced zipfile, and changing the working directory to it as done in Step 4, you can run the service like this:

```
$ cd ~/CMAK/target/universal/cmak-3.0.0.5
$ bin/cmak
```

By default, it will choose port 9000, so open your favorite browser and point it to http://ip-or-domain-name-of-server:9000. In case your firewall is running, kindly allow the port to be accessed externally.

`sudo ufw allow 9000`


- Step 7: Adding Sample Topic
Apache Kafka provides multiple shell scripts to work with. Let us first create a sample topic called “ComputingForGeeksTopic” with a single partition with single replica. Open a new terminal leaving CMAK running and issue the command below:
```
cd /usr/local/kafka-server
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic ComputingForGeeksTopic
```

Created topic ComputingForGeeksTopic.

