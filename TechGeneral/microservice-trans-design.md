

# Microservice Transaction Design

- https://stackoverflow.com/questions/30213456/transactions-across-rest-microservices?rq=1

## Scenario:

Let's say we have a User, Wallet REST microservices and an API gateway that glues things together. When Bob registers on our website, our API gateway needs to create a user through the User microservice and a wallet through the Wallet microservice.

Now here are a few scenarios where things could go wrong:

User Bob creation fails: that's OK, we just return an error message to the Bob. We're using SQL transactions so no one ever saw Bob in the system. Everything's good :)

User Bob is created but before our Wallet can be created, our API gateway hard crashes. We now have a User with no wallet (inconsistent data).

User Bob is created and as we are creating the Wallet, the HTTP connection drops. The wallet creation might have succeeded or it might have not.

What solutions are available to prevent this kind of data inconsistency from happening? Are there patterns that allow transactions to span multiple REST requests? I've read the Wikipedia page on Two-phase commit which seems to touch on this issue but I'm not sure how to apply it in practice. This Atomic Distributed Transactions: a RESTful design paper also seems interesting although I haven't read it yet.

Alternatively, I know REST might just not be suited for this use case. Would perhaps the correct way to handle this situation to drop REST entirely and use a different communication protocol like a message queue system? Or should I enforce consistency in my application code (for example, by having a background job that detects inconsistencies and fixes them or by having a "state" attribute on my User model with "creating", "created" values, etc.)?


## Solution Suggestions

### General Suggestion 1

#### What doesn't make sense:

distributed transactions with REST services. REST services by definition are stateless, so they should not be participants in a transactional boundary that spans more than one service. Your user registration use case scenario makes sense, but the design with REST microservices to create User and Wallet data is not good.

#### What will give you headaches:

- EJBs with distributed transactions. It's one of those things that work in theory but not in practice. Right now I'm trying to make a distributed transaction work for remote EJBs across JBoss EAP 6.3 instances. We've been talking to RedHat support for weeks, and it didn't work yet.

- Two-phase commit solutions in general. I think the 2PC protocol is a great algorithm (many years ago I implemented it in C with RPC). It requires comprehensive fail recovery mechanisms, with retries, state repository, etc. All the complexity is hidden within the transaction framework (ex.: JBoss Arjuna). However, 2PC is not fail proof. There are situations the transaction simply can't complete. Then you need to identify and fix database inconsistencies manually. It may happen once in a million transactions if you're lucky, but it may happen once in every 100 transactions depending on your platform and scenario.

- Sagas (Compensating transactions). There's the implementation overhead of creating the compensating operations, and the coordination mechanism to activate compensation at the end. But compensation is not fail proof either. You may still end up with inconsistencies (= some headache).

#### What's probably the best alternative:

- Eventual consistency. Neither ACID-like distributed transactions nor compensating transactions are fail proof, and both may lead to inconsistencies. Eventual consistency is often better than "occasional inconsistency". There are different design solutions, such as:


-- You may create a more robust solution using asynchronous communication. In your scenario, when Bob registers, the API gateway could send a message to a NewUser queue, and right-away reply to the user saying "You'll receive an email to confirm the account creation." A queue consumer service could process the message, perform the database changes in a single transaction, and send the email to Bob to notify the account creation.


-- The User microservice creates the user record and a wallet record in the same database. In this case, the wallet store in the User microservice is a replica of the master wallet store only visible to the Wallet microservice. There's a data synchronization mechanism that is trigger-based or kicks in periodically to send data changes (e.g., new wallets) from the replica to the master, and vice-versa.

#### But what if you need synchronous responses?

- Remodel the microservices. If the solution with the queue doesn't work because the service consumer needs a response right away, then I'd rather remodel the User and Wallet functionality to be collocated in the same service (or at least in the same VM to avoid distributed transactions). Yes, it's a step farther from microservices and closer to a monolith, but will save you from some headache.

