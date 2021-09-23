
# High concurrency Phaser, ReadWriteLock, StampedLock

- Ref:

https://www.fatalerrors.org/a/high-concurrency-phaser-readwritelock-stampedlock.html


## Phaser

Phaser is a synchronization tool class introduced at the beginning of JDK7, which is suitable for processing tasks that need to be phased. Its functions are similar to those of CyclicBarrier and CountDownLatch, but its scenarios are more flexible, similar to a multi-stage fence, and more powerful. Let's compare the functions of the three

Synchronizer	effect
- CountDownLatch	Countdown counter, initially set the counter value, the thread can wait on the counter, when the counter value returns to 0, all waiting threads continue to execute

- CyclicBarrier	Loop fence, initially set the number of participating threads. When the thread reaches the fence, it will wait for other threads to arrive. When the total number of arriving fences meets the specified number, all waiting threads will continue to execute

- Phaser	For multi-stage fence, you can set the number of participating threads at the beginning, or you can register / log off participants midway. When the number of arriving participants meets the number set by the fence, the stage upgrade will be carried out

Usage scenarios

Compared with the previous CyclicBarrier and CountDownLatch, this is a little difficult to understand. Here is a scene: marriage

A wedding is bound to be divided into many stages, such as the arrival of the guests, the wedding ceremony, the bride and groom's worship, the bridal chamber, the banquet, and the guests' departure. If different people are regarded as different threads, then the stages of different threads are different. For example, the bride and groom may have to go through a complete process, and the guests may only be a few of them.


see,  
spring-boot-java-main/src/test/java/com/oopsmails/generaljava/highconcurrency/TestPhaser.java

Common methods of Phaser
```
Phaser() //The default construction method, the number of initialization and registration threads is 0
Phaser(int parties)//A construction method to specify the number of threads
```

## ReadWriteLock
According to translation, read-write lock, as the name suggests, when reading, read lock, when writing lock, this is a clever solution to a performance problem of synchronized: read and read mutually exclusive.

- ReadWriteLock summary

Using ReadWriteLock can improve reading efficiency

ReadWriteLock allows only one thread to write;
ReadWriteLock allows multiple threads to read at the same time without writing;
ReadWriteLock is suitable for reading more and writing less scenarios.

see,  
spring-boot-java-main/src/test/java/com/oopsmails/generaljava/highconcurrency/TestReadAndWriteLock1.java  
spring-boot-java-main/src/test/java/com/oopsmails/generaljava/highconcurrency/TestReadAndWriteLock2.java  
spring-boot-java-main/src/test/java/com/oopsmails/generaljava/highconcurrency/TestReadAndWriteLock3.java  


## StampedLock

The ReadWriteLock described above can solve the problem that multiple threads can read at the same time, but only one thread can write.

If we deeply analyze ReadWriteLock, we will find a potential problem: if a thread is reading, the write thread needs to wait for the read thread to release the lock before obtaining the write lock, that is, writing is not allowed in the process of reading, which is a pessimistic read lock.

To further improve the efficiency of concurrent execution, Java 8 introduces a new read-write lock: StampedLock.

Compared with ReadWriteLock, StampedLock has the following advantages: in the process of reading, it also allows writing after obtaining the write lock! In this way, the data we read may be inconsistent. Therefore, we need a little extra code to judge whether there is writing in the process of reading. This kind of read lock is an optimistic lock.

Optimistic lock means to optimistically estimate that there will be no writing in the process of reading, so it is called optimistic lock. On the other hand, pessimistic lock is to refuse to write in the process of reading, that is, writing must wait. Obviously, optimistic locking is more efficient in concurrency, but once there is a small probability that the data read is inconsistent, it needs to be detected and read again.

Therefore, StampedLock divides read lock into optimistic read and pessimistic read, which can further improve concurrency efficiency. But there are costs:

First, the code is more complex

Second, StampedLock is a non reentrant lock, which cannot acquire the same lock repeatedly in a thread.

see below, but no test  
spring-boot-java-main/src/main/java/com/oopsmails/generaljava/highconcurrency/Point.java


