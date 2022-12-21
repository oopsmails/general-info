# RxJS Observable: Understanding hot vs cold Observables

To understand the concept of a hot and cold Observable it's good to always refer to what the data producer is. To make it simple:

> When the data is produced by the Observable itself, we call it a cold Observable. When the data is produced outside the Observable, we call it a hot Observable.

## Cold Observables

So, we call an Observable “cold” when the data is produced inside the Observable. As you might have read in my previous article, Observables are lazy. Observables are lazy in the sense that they only execute values when something subscribes to it. **For each subscriber the Observable starts a new execution, resulting in the fact that the data is not shared.** If your Observable produces a lot of different values it can happen that two Observables that subscribe at more or less the same receive two different values. We call this behaviour “unicasting”. To demonstrate this:

```
import * as Rx from "rxjs";

const observable = Rx.Observable.create((observer) => {
    observer.next(Math.random());
});

// subscription 1
observable.subscribe((data) => {
  console.log(data); // 0.24957144215097515 (random number)
});

// subscription 2
observable.subscribe((data) => {
   console.log(data); // 0.004617340049055896 (random number)
});
```

As you see the data is produced inside the Observable, making it cold. We have two subscriptions which subscribe more or less at the same time. Since the Observable does a new execution for every subscriber and the Observable generates a random number, the data the subscriber receives is different. This is not a bad thing, you just have to be aware of this behaviour.

Of course this behaviour is not always desirable. Luckily it's easy to change this behaviour:

```
import * as Rx from "rxjs";

const random = Math.random()

const observable = Rx.Observable.create((observer) => {
    observer.next(random);
});

// subscription 1
observable.subscribe((data) => {
  console.log(data); // 0.11208711666917925 (random number)
});

// subscription 2
observable.subscribe((data) => {
   console.log(data); // 0.11208711666917925 (random number)
});
```

Woah, that was easy! All we did was moving the data producer out of the Observable. We still have two subscribers and the Observable will still execute two times, but since the data is produced outside the Observable our subscriptions will receive the same data.

**I hope this rings a bell, because we just turned our cold Observable into a hot Observable.**

## Hot Observables

Yes, it is that easy. An Observable is cold when data is produced inside the Observable and the Observable is hot when the data is produced outside the Observable. As we just saw the hot Observable is able to share data between multiple subscribers. We call this behaviour “multicasting”.

Generating a random number is not a good real life usecase. A good usecase would be DOM events. Let's say we're tracking clicking behaviour and have multiple subscribers do something with the coordinates:

```
import * as Rx from "rxjs";

const observable = Rx.Observable.fromEvent(document, 'click');

// subscription 1
observable.subscribe((event) => {
  console.log(event.clientX); // x position of click
});

// subscription 2
observable.subscribe((event) => {
   console.log(event.clientY); // y position of click
});
```

The data is produced outside of the Observable itself. Which makes it hot, because the data is being created regardless of if there is a subscriber or not. If there is no subscriber when the data is being produced, the data is simply lost.

## Is one better than the other?

Well, that depends on the usecase. A cold Observable is usually fine, unless:

- You want to make sure multiple subscribers get the same data.
- Your creating a new instance of something on each Observable execution, let's say a websocket connection. You don't want to create a new connection for each subscriber, but instead just share it to all the subscribers. Moving the instantiation of the connection outside the Observable will make it hot and fixes this.

- ref:

https://luukgruijs.medium.com/understanding-hot-vs-cold-observables-62d04cf92e03#:~:text=To%20understand%20the%20concept%20of,call%20it%20a%20hot%20Observable.
