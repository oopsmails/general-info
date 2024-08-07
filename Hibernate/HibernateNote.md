

# Hibernate Tutorial

- Reference:

https://www.youtube.com/watch?v=Yv2xctJxE-w&list=PL4AFF701184976B25


## Introduction:

Hibernate:

```
@ElementCollection + @JoinTable(name, joinColumns=@JoinColumn(name))
@Embeddedable
@Embedded

@EmbeddedId

@Id
```

## Hibernate Tutorial 11 - Configuring Collections and Adding Keys
==> @CollectionId not in JPA, 

--> not working?
@ElementCollection(fetch=FetchType.EAGER)
@CollectionId(
	columns=@Column(name="Property_image_id"),
	type=@Type(type="long"),
	generator="native"
)
private Collection<FileAttachment> images = new ArrayList<FileAttachment>();

--> ?
@GenericGenerator(name = "hilo-gen", strategy = "hilo")
@CollectionId(columns = { @Column(name="Address_id") }, generator = "hilo-gen", type = @Type(type="long"))



--> working
@ElementCollection(fetch=FetchType.EAGER)
@OrderColumn(name = "IMAGE_INDEX")
private List<FileAttachment> images


## Hibernate Tutorial 12 - Proxy Objects and Eager and Lazy Fetch Types


## Hibernate Tutorial 13 - One To One Mapping

@OneToOne
@JoinColumn(name="vehicle_id")
private Vehicle vehicle;

## Hibernate Tutorial 14 - One To Many Mapping

in UserDetails class

@OneToMany
@JoinTable(name="USER_VEHICLE",
	joinColumns=@JoinColumn(name="USER_ID"),
	inverseJoinColumns=@JoinColumn(name="VEHICLE_ID")
	)
private Collection<Vehicle> = new ArrayList<>();

in Vehicle class

@ManyToOne
private UserDetails user;


--> @OneToMany creating mapping table if no "mappedBy" configuration, but @ElementCollection will not

--> if would not create new mapping table, but add USER_ID in VEHICLE table
then, used mappedBy in UserDetails class

in Vehicle class

@ManyToOne
@JoinColumn(name="USER_ID")
private UserDetails user;

in UserDetails class

@OneToMany(mappedBy="user")
private Collection<Vehicle> vehicleList = new ArrayList<>();


## Hibernate Tutorial 15 - mappedBy and Many To Many Mapping

--> two mapping tables, if no "mappedBy" configuration

in UserDetails class

@ManyToMany
@JoinTable(name="USER_VEHICLE",
	joinColumns=@JoinColumn(name="USER_ID"),
	inverseJoinColumns=@JoinColumn(name="VEHICLE_ID")
	) --> this has to be here!
private Collection<Vehicle> vehicleList = new ArrayList<>();

in Vehicle class

@ManyToMany(mappedBy="vehicleList")
private Collection<UserDetails> userList = new ArrayList<>();


## Hibernate Tutorial 16 - CascadeTypes and Other Things

@ManyToOne
@NotFound(action=NotFoundAction.IGNORE) --> hibernate annotation!

Hibernate Collections
Bag semantic - List / ArrayList
Bag semantic with ID - List / ArrayList
List semantic - List / ArrayList
Set semantic - Set
Map semantic - Map

Cascade: 

@OneToMany
private Collection<Vehicle> vehicleList = new ArrayList<>();

--> if only save user and not save vehicles explicitly, then get 
"object references an unsaved transient instance - save the transient instance before flushing ..."
--> not automatically saving vehicles ... because vehicle is also an Entity

--> to save vehicles automatically when saving user ...
@OneToMany(cascade=CascadeType.PERSIST): to save automatically.

CascadeType.PERSIST
CascadeType.MERGE
CascadeType.REMOVE
CascadeType.DETACH
CascadeType.REFRESH
CascadeType.ALL

no use session.save(user), instead, use session.persis(user)


## Hibernate Tutorial 17 - Implementing Inheritance

by default, subclasses, will be saved in the same table as super class ... 
but automatically adds "DTYPE", populated by superclass name and subclass names
and fields from subclasses are all added as columns.


## Hibernate Tutorial 18 - Implementing Inheritance - Single Table Strategy
--> SINGLE_TABLE
superclass:

@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(
	name="VEHICLE_TYPE",
	discriminatorType=DiscriminatorType.STRING
)


subclass:
@DiscriminatorValue("Bike")
@DiscriminatorValue("Car")

=> not recommanded ..., least normalized

## Hibernate Tutorial 19 - Implementing Inheritance With Table Per Class Strategy

--> TABLE_PER_CLASS
@Inheritance(strategy=InheritanceType.TABLE_PER_CLASS)

Three tables, with ID is in sequence ...

=> slightly normalized, but repeating columns

## Hibernate Tutorial 20 - Implementing Inheritance With Joined Strategy
--> JOINED
@Inheritance(strategy=InheritanceType.JOINED)


## Hibernate Tutorial 21 - CRUD Operations

session.delete(user);
session.update(user);

## Hibernate Tutorial 22 - Transient, Persistent and Detached Objects
there are 3 object states!

before session, i.setUserName("..") is Transient. This means, if there is an update in session, then 
this before session one will be ignored. 

session.save(user)
.setUserName("..")
.setUserName(".. again")
in session, only the last update statement, will go into db, even AFTER .save
Hibernate is smart enough to update the latest for any changes ..., this is called Persistent

-------------------------
user.setUserName("1") <-- Transient

SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
Session session = sessionFactory.openSession();
session.befinTransaction();

session.save(user); <-- becomes Persistent

user.setUserName("2")
user.setUserName("3") <-- only this will trigger update statement of db

session.getTransaction().commit();
session.close() <-- becomes Detached

user.setUserName("4") <-- not hibernate tracked ...

----------------------------



## Hibernate Tutorial 23 - Understanding State Changes

after session.delete(), the object back to Transient state

## Hibernate Tutorial 24 - Persisting Detached Objects

DB fatch 

wait User Input

DB update <-- need to Persist Detached Object

@Entity class
--> add Hibernate annotation, @org.hibernate.annotations.Entity(selectBeforeUpdate=true)
--> select before update, update only if there is any change


## Hibernate Tutorial 25 - Introducing HQL and the Query Object

--> org.hibernate.Query here!?
Query query = session.createQuery("from UserDetails where userId > 5");
List<UserDetails> users = (List<UserDetails>)query.list();

## Hibernate Tutorial 26 - Select and Pagination in HQL

Query query = session.createQuery("select userName from UserDetails where userId > 5");

List<String> users = (List<String>)query.list(); <-- if only userName, then List<String> here

Query query = session.createQuery("select map(userId, userName) from UserDetails where userId > 5");
Map<Integer, String>

select max(userId) ...
Integer maxUserId



query.setFirstResult(5); <-- pagination
query.setMaxResult(4);

=> generating imit ? and offset ?



## Hibernate Tutorial 27 - Understanding Parameter Binding and SQL Injection

String minUserId = "5";
Query query = session.createQuery("select map(userId, userName) from UserDetails where userId > " + minUserId); <-- could result SQL Injection on String

- SQL Injection on String
if user input is "5 or 1 = 1"

-> solution: Parameter Binding
Query query = session.createQuery("from UserDetails where userId > ?");
query.setInteger(0, Integer.parseInt(minUserId));


Query query = session.createQuery("from UserDetails where userId > ? and userName = ?");
query.setInteger(0, Integer.parseInt(minUserId));
query.setString(1, userName);

or:

Query query = session.createQuery("from UserDetails where userId > :userId and userName = :userName");
query.setInteger("userId", Integer.parseInt(minUserId));
query.setString("userName", userName);

## Hibernate Tutorial 28 - Named Queries

@Entity
@NamedQuery(name="UserDetails.byId", query="from UserDetails where userId = ?")
or:
@NamedNativeQuery(name="UserDetails.byName", query="select * from user_details where username = ?", resultClass=UserDetais.class)

Query query = session.getNameedQuery("UserDetails.byId");
query.setInteger(0, Integer.parseInt(minUserId));

Query query = session.getNameedQuery("UserDetails.byName");
query.setString(0, userName);
List<UserDetails> users = (List<UserDetails>)query.list(); <-- still a List here!



## Hibernate Tutorial 29 - Introduction to Criteria API

- org.hibernate.Criteria
Criteria criteria = session.createCriteria(UserDetails.class);
criteria.add(Restrictions.eq("userName", "User 10"));
List<UserDetails> users = (List<UserDetails>)criteria.list();

## Hibernate Tutorial 30 - Understanding Restrictions

chaining ...

=> AND
criteria.add(Restrictions.like("userName", "%User %"))
.add(Restrictions.gt("userId", 5))
.add(...);

=> OR

criteria.add(Restrictions.or(
	Restrictions.between("userId", 5, 50), 
	Restrictions.gt("userName", "%User %")
));


## Hibernate Tutorial 31 - Projections and Query By Example

-- Projections
Criteria criteria = session.createCriteria(UserDetails.class);
criteria.setProjection(Projections.property("userId")); <-- one column
List<Integer>

criteria.setProjection(Projections.max("userId")); <-- aggregations

criteria.addOrder(Order.desc("userId")); <-- order by

-- Query By Example

UserDetails exampleUser = new UserDetails();
exampleUser.set...
exampleUser.set...

Example example = Example.create(exampleUser);
Criteria criteria = session.createCriteria(UserDetails.class).add(example);

--> Note: hibernate will ignore, 1. primary key 2. null fields


Example example = Example.create(exampleUser).excludeProperty("userName").excludeProperty(..); <-- exclude property

exampleUser.setUserName("User 1%");
Example example = Example.create(exampleUser).enableLike(); <-- enable like
Criteria criteria = session.createCriteria(UserDetails.class).add(example);

## Hibernate Tutorial 32 - Cacheing in Hibernate

- First Level Cache - **Session**: update and select twice, hibernate smart enough to run once
- Second Level Cache - Since session should not be there for long time, so, need second level cache, like, Ehcache ... 
	- Across sessions in an application
	- Across applicaitons, diff sessions and diff applicaitons
	- Across clusters, problem with application not using hibernate, etc. invalid cache, dirty data
 



1. Only one query run, session cache, first level cache
```
UserDetails user = (UserDetails)session.get(UserDetails.class, 1);
...  .... ...
UserDetails user2 = (UserDetails)session.get(UserDetails.class, 1);
```


2. One select and one update ... no second select, because cached in session, even with an *update* in the middle


```
UserDetails user = (UserDetails)session.get(UserDetails.class, 1);
user.setUserName("updated ...");
UserDetails user2 = (UserDetails)session.get(UserDetails.class, 1);
```

3. Then two select queries runs, this can be solved by cache ... second level cache !!!!

```
SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
Session session = sessionFactory.openSession();
session.befinTransaction();

UserDetails user = (UserDetails)session.get(UserDetails.class, 1);

session.getTransaction().commit();
session.close() <---------------------- session closed, second select will go to database!

Session session2 = sessionFactory.openSession();
session2.befinTransaction();

UserDetails user2 = (UserDetails)session.get(UserDetails.class, 1);

session2.getTransaction().commit();
session2.close()
```

## Hibernate Tutorial 33 - Configuring Second Level Cache

1. hibernate.cfg.xml
--> 
Open hibernate.xx.jar, to find cache classes
-->
change NoCacheProvider to EhCacheProvider
--> add
<property name="hibernate.cache.use_second_level_cache">true</property>
--> download ehcache-core.xx.jar and put in classpath

2. configure @Entity is cacheable
@Entity
@Cacheable <-- javax.persistence.
@Cache(usage=CacheConcurrencyStrategy.READ_ONLY) <-- hibernate, NONE, NONSTRICT_READ_WRITE(read cache, but may have changed somewhere else), READ_ONLY, READ_WRITE, TRANSACTIONAL


SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
Session session = sessionFactory.openSession();
session.befinTransaction();

UserDetails user = (UserDetails)session.get(UserDetails.class, 1);

session.getTransaction().commit();
session.close()

Session session2 = sessionFactory.openSession();
session2.befinTransaction();

UserDetails user2 = (UserDetails)session.get(UserDetails.class, 1);

session2.getTransaction().commit();
session2.close()
--> Now, only one select runs ...


----------------
1. include the jars in /hibernate-release-(version)/lib/optional/ehcache in your Hibernate User Library
2. modify the code of your hibernate.cfg.xml to look like the following:
<!-- Control the second-level cache  -->
<property name="hibernate.cache.region.factory_class">org.hibernate.cache.ehcache.EhCacheRegionFactory</property>
<property name="hibernate.cache.use_second_level_cache">true</property>

<dependency>
    <groupId>org.hibernate</groupId>
    <artifactId>hibernate-ehcache</artifactId>
    <version>3.6.2.Final</version>
</dependency>

---------------

## Hibernate Tutorial 34 - Using Query Cache

--> Query Cache should be used carefully ... because it may end with all over places in application.

SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
Session session = sessionFactory.openSession();
session.befinTransaction();

Query query = session.createQuery("from UserDetails user where user.userId = 1");
List<UserDetails> users = (List<UserDetails>)query.list();

session.getTransaction().commit();
session.close()

Session session2 = sessionFactory.openSession();
session2.befinTransaction();

Query query2 = session.createQuery("from UserDetails user where user.userId = 1");
users = (List<UserDetails>)query2.list();

session2.getTransaction().commit();
session2.close()

--> then two queries runs even with second level cache!
--> to solve this: 
1. hibernate.cfg.xml:
<property name="hibernate.cache.use_query_cache">true</property>


2.
query.setCacheable(true);
query2.setCacheable(true); <-- also needed, because this means setCacheable() checking cache first.


## 


