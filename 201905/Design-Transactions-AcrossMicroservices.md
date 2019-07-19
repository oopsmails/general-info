
https://stackoverflow.com/questions/30213456/transactions-across-rest-microservices

Let's say we have a User, Wallet REST microservices and an API gateway that glues things together. When Bob registers on our website, our API gateway needs to create a user through the User microservice and a wallet through the Wallet microservice.

Now here are a few scenarios where things could go wrong:

- User Bob creation fails: that's OK, we just return an error message to the Bob. We're using SQL transactions so no one ever saw Bob in the system. Everything's good :)

- User Bob is created but before our Wallet can be created, our API gateway hard crashes. We now have a User with no wallet (inconsistent data).

- User Bob is created and as we are creating the Wallet, the HTTP connection drops. The wallet creation might have succeeded or it might have not.

What solutions are available to prevent this kind of data inconsistency from happening? Are there patterns that allow transactions to span multiple REST requests? I've read the Wikipedia page on Two-phase commit which seems to touch on this issue but I'm not sure how to apply it in practice. This Atomic Distributed Transactions: a RESTful design paper also seems interesting although I haven't read it yet.

Alternatively, I know REST might just not be suited for this use case. Would perhaps the correct way to handle this situation to drop REST entirely and use a different communication protocol like a message queue system? Or should I enforce consistency in my application code (for example, by having a background job that detects inconsistencies and fixes them or by having a "state" attribute on my User model with "creating", "created" values, etc.)?


## General history and solution:

#### What doesn't make sense:

distributed transactions with REST services. REST services by definition are stateless, so they should not be participants in a transactional boundary that spans more than one service. Your user registration use case scenario makes sense, but the design with REST microservices to create User and Wallet data is not good.

#### What will give you headaches:

- EJBs with distributed transactions. It's one of those things that work in theory but not in practice. Right now I'm trying to make a distributed transaction work for remote EJBs across JBoss EAP 6.3 instances. We've been talking to RedHat support for weeks, and it didn't work yet.
- Two-phase commit solutions in general. I think the 2PC protocol is a great algorithm (many years ago I implemented it in C with RPC). It requires comprehensive fail recovery mechanisms, with retries, state repository, etc. All the complexity is hidden within the transaction framework (ex.: JBoss Arjuna). However, 2PC is not fail proof. There are situations the transaction simply can't complete. Then you need to identify and fix database inconsistencies manually. It may happen once in a million transactions if you're lucky, but it may happen once in every 100 transactions depending on your platform and scenario.
- Sagas (Compensating transactions). There's the implementation overhead of creating the compensating operations, and the coordination mechanism to activate compensation at the end. But compensation is not fail proof either. You may still end up with inconsistencies (= some headache).

#### What's probably the best alternative:

- Eventual consistency. Neither ACID-like distributed transactions nor compensating transactions are fail proof, and both may lead to inconsistencies. Eventual consistency is often better than "occasional inconsistency". There are different design solutions, such as:

You may create a more robust solution using asynchronous communication. In your scenario, when Bob registers, the API gateway could send a message to a NewUser queue, and right-away reply to the user saying "You'll receive an email to confirm the account creation." A queue consumer service could process the message, perform the database changes in a single transaction, and send the email to Bob to notify the account creation.

The User microservice creates the user record and a wallet record in the same database. In this case, the wallet store in the User microservice is a replica of the master wallet store only visible to the Wallet microservice. There's a data synchronization mechanism that is trigger-based or kicks in periodically to send data changes (e.g., new wallets) from the replica to the master, and vice-versa.

#### But what if you need synchronous responses?

Remodel the microservices. If the solution with the queue doesn't work because the service consumer needs a response right away, then I'd rather remodel the User and Wallet functionality to be collocated in the same service (or at least in the same VM to avoid distributed transactions). Yes, it's a step farther from microservices and closer to a monolith, but will save you from some headache.

## Starbucks solution:

This is a classic question I was asked during an interview recently How to call multiple web services and still preserve some kind of error handling in the middle of the task. Today, in high performance computing, we avoid two phase commits. I read a paper many years ago about what was called the "Starbuck model" for transactions: Think about the process of ordering, paying, preparing and receiving the coffee you order at Starbuck... I oversimplify things but a two phase commit model would suggest that the whole process would be a single wrapping transaction for all the steps involved until you receive your coffee. However, with this model, all employees would wait and stop working until you get your coffee. You see the picture ?

Instead, the "Starbuck model" is more productive by following the "best effort" model and compensating for errors in the process. First, they make sure that you pay! Then, there are message queues with your order attached to the cup. If something goes wrong in the process, like you did not get your coffee, it is not what you ordered, etc, we enter into the compensation process and we make sure you get what you want or refund you, This is the most efficient model for increased productivity.

Sometimes, starbuck is wasting a coffee but the overall process is efficient. There are other tricks to think when you build your web services like designing them in a way that they can be called any number of times and still provide the same end result. So, my recommendation is:

- Don't be too fine when defining your web services (I am not convinced about the micro-service hype happening these days: too many risks of going too far);

- Async increases performance so prefer being async, send notifications by email whenever possible.

- Build more intelligent services to make them "recallable" any number of times, processing with an uid or taskid that will follow the order bottom-top until the end, validating business rules in each step;

- Use message queues (JMS or others) and divert to error handling processors that will apply operations to "rollback" by applying opposite operations, by the way, working with async order will require some sort of queue to validate the current state of the process, so consider that;

- In last resort, (since it may not happen often), put it in a queue for manual processing of errors.

#### Back to initial problem

Let's go back with the initial problem that was posted. Create an account and create a wallet and make sure everything was done.

Let's say a web service is called to orchestrate the whole operation.

Pseudo code of the web service would look like this:

- Call Account creation microservice, pass it some information and a some unique task id 1.1 Account creation microservice will first check if that account was already created. A task id is associated with the account's record. The microservice detects that the account does not exist so it creates it and stores the task id. NOTE: this service can be called 2000 times, it will always perform the same result. The service answers with a "receipt that contains minimal information to perform an undo operation if required".

- Call Wallet creation, giving it the account ID and task id. Let's say a condition is not valid and the wallet creation cannot be performed. The call returns with an error but nothing was created.

- The orchestrator is informed of the error. It knows it needs to abort the Account creation but it will not do it itself. It will ask the wallet service to do it by passing its "minimal undo receipt" received at the end of step 1.

- The Account service reads the undo receipt and knows how to undo the operation; the undo receipt may even include information about another microservice it could have called itself to do part of the job. In this situation, the undo receipt could contain the Account ID and possibly some extra information required to perform the opposite operation. In our case, to simplify things, let's say is simply delete the account using its account id.

- Now, let's say the web service never received the success or failure (in this case) that the Account creation's undo was performed. It will simply call the Account's undo service again. And this service should normaly never fail because its goal is for the account to no longer exist. So it checks if it exists and sees nothing can be done to undo it. So it returns that the operation is a success.

- The web service returns to the user that the account could not be created.

This is a synchronous example. We could have managed it in a different way and put the case into a message queue targeted to the help desk if we don't want the system to completly recover the error". I've seen this being performed in a company where not enough hooks could be provided to the back end system to correct situations. The help desk received messages containing what was performed successfully and had enough information to fix things just like our undo receipt could be used for in a fully automated way.

I have performed a search and the microsoft web site has a pattern description for this approach. It is called the compensating transaction pattern:

Compensating transaction pattern




