
# Spring Boot Session Management Example (2022)

- Ref:

https://www.techgeeknext.com/spring-boot/spring-boot-session-management


## What is Session Management?

Session management is the process of securely handling multiple requests to a web-based application or service from a single user or entity. HTTP is used to communicate between websites and browsers, and a session is a series of HTTP requests and transactions created by the same user. The session management implementation specifies the process for sharing and continually exchanging the session ID between the user and the web application.

Note : The full source code for Spring boot session management example can be downloaded at the end of this article.

You can also learn how to authenticate user using Spring Boot + JWT Token.


As HTTP protocol is stateless, and to keep track of customer behavior, we need session management. Session Management is a web container framework used to store session data for a specific user.

### Session Handling

You can handle the session in one of the following ways:


- Cookies
is a data sent from a website and saved by the user's web browser on the user's computer as the user browses.

- Hidden form field
is a hidden data, which will not be shown to user and can not be modified. However, when the user submits the form, hidden data would be sent.

- URL Rewriting
is the method of modifying the URL parameters.

- HttpSession
enables data to be associated with individual visitors.
You may enhance your application's performance even further by storing static or frequently requested data in memory/cache provider. Refer Spring Boot Caching Example to learn more.

### Session Management

Managing user session is very important in most of the web applications. Mainly we have been maintaining user session data in cluster environment with load balancer in front of server nodes to distribute the traffic accordingly. So to manage the session environment like in production would be very crucial. In **distributed environment**, we can manage session in below ways.

- Sticky Session
In this type of session, load balancer would always route same client request to same node. But here if that node goes down, session would also be gone.

- Session Replication
To overcome sticky session problem, session replication replicates session data to multiple servers. So in case of any node goes down, session data would always be available with other nodes.

- Session Data in a Persistent DataStore
Here in this case session would not stored in server memory, instead, it will be store in database(RDBMS, Redis, HazelCast, MongoDB etc) with unique id called SESSION_ID.

If you want to do certain important tasks whenever an HTTP Session is created or deleted, use the Spring Boot + Session Listener Example.

## Spring Session

The following modules are included in the Spring Session:

- Spring Session Core

Spring Session core APIs

- Spring Session Data Redis

Provides session repository for Redis database session management
- Spring Session JDBC

Provides session repository for relational database like MYSQL etc session management.

- Spring Session Hazelcast

Provides session repository for Hazelcast session management.

## Spring Session JDBC

By default Apache Tomcat store objects in memory for HTTP session management. Moreover, in order to manage Spring Boot Session Management, the HTTPSession will be used to store session information with persistent storage (Mysql) by using Spring Session JDBC.

In this tutorial, will see how to use Spring Boot Session Management using JDBC Session


Now if you go to the database and see that the 2 tables will be created and the NOTE SESSION object will be stored in this table to manage the session

> spring_session
> 
> spring_session_attributes

Click on Destroy Session, Spring Boot will delete data (NOTES_SESSION) from spring_session_attributes table.

As you have seen how Spring boot store user session data to database, which will make very easy to maintain session data in cluster environment as well.


>../springboot-session-management-master/

## Spring Boot Session Management using Redis Example

>../springboot-session-management-redis-master

## Spring Boot Security + JWT (JSON Web Token) Authentication using MYSQL Example

- additional example

>../spring-boot-jwt-jpa-master/

