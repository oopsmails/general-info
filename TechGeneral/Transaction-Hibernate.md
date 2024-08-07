
# Transaction Concepts in Hibernate


## Hibernate Transaction Management Example

Transaction Interface in Hibernate
In hibernate framework, we have Transaction interface that defines the unit of work. It maintains abstraction from the transaction implementation (JTA,JDBC).

A transaction is associated with Session and instantiated by calling session.beginTransaction().


The methods of Transaction interface are as follows:

- void begin() starts a new transaction.
- void commit() ends the unit of work unless we are in FlushMode.NEVER.
- void rollback() forces this transaction to rollback.
- void setTimeout(int seconds) it sets a transaction timeout for any transaction started by a subsequent call to begin on this instance.
- boolean isAlive() checks if the transaction is still alive.
- void registerSynchronization(Synchronization s) registers a user synchronization callback for this transaction.
- boolean wasCommited() checks if the transaction is commited successfully.
- boolean wasRolledBack() checks if the transaction is rolledback successfully.
