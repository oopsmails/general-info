# RxJS Subjects and their internal state

## Subject vs BehaviorSubject vs ReplaySubject in Angular

From: Randall Koutnik's book "Build Reactive Websites with RxJS." :

A Subject is an object that's a turbocharged observable. At its core, a Subject acts much like a regular observable, but each subscription is hooked into the same source. Subjects also are observers and have next, error, and done methods to send data to all subscribers at once. Because subjects are observers, they can be passed directly into a subscribe call, and all the events from the original observable will be sent through the subject to its subscribers.

We can use the ReplaySubject to track history. A ReplaySubject records the last n events and plays them back to every new subscriber. For example in a chat applications. We can use it for tracking the record of previous chat history.

A BehaviorSubject is a simplified version of the ReplaySubject. The ReplaySubject stored an arbitrary number of events, the BehaviorSubject only records the value of the latest event. Whenever a BehaviorSubject records a new subscription, it emits the latest value to the subscriber as well as any new values that are passed in. The BehaviorSubject is useful when dealing with single units of state, such as configuration options.

Let's start by talking about Subjects and their internal state and why is it so important to be aware of complete and error notifications. Then we'll move to more interesting examples with ReplaySubject and BehaviorSubject classes.

- Ref:

https://stackoverflow.com/questions/43118769/subject-vs-behaviorsubject-vs-replaysubject-in-angular

## Reusing a single instance of Subject

All Subjects have an internal state that reflects the most basic principle of Rx. Every Observable emits zero or more next notifications and one complete or error notification but never both. In practise this means that when an instance of Subject receives a complete it should never ever emit anything. We can see this on the following example:

```
// http://jsbin.com/nobuwud/2/edit?js,console
const s = new Subject();
s.subscribe(console.log);
s.next(1);
s.next(2);
s.complete();
s.next(3);
```

This prints only numbers 1 and 2. Number 3 is emitted after our Subject already received the complete notification which marked itself as stopped. This means that this instance of Subject will never emit anything any more (there's no legitimate way to make the Subject "not stopped" again).

A very common problem with reusing Subjects is unintentionally passing the complete notification. For example let's consider the following example:

```
// http://jsbin.com/matatit/1/edit?js,console
const s = new Subject();
s.subscribe(console.log);
Observable.range(1, 5)
  .subscribe(s);
s.next(42);
```

This prints only numbers 1 — 5 but what happened to 42?

The _range(1, 5)_ source Observable sends apart from nexts also the complete notification at the end. We usually subscribe to handle just next items and we don't care about the complete notification but in the case it's very important. So what happened should be obvious. The s Subject received the complete notification which made it mark itself as stopped and it's not going to ever emit anything again.

So what if we want to receive all nexts but not the complete notification (nor error)? The easiest way is to manually call next() on the Subject:

```
// http://jsbin.com/matatit/2/edit?js,console
...
Observable.range(1, 5)
  .subscribe(val => s.next(val));
...
```

Now when we run this example again we get the number 42 as well.

Note that all Subject classes have _isStopped_ public boolean property where you can check their state. Also keep in mind that for error notifications it works the same way as with _complete_.

## Comparing BehaviorSubject and ReplaySubject

Now when we're on the same page let's have a look at a more interesting example. We'll use _BehaviorSubject_ and _ReplaySubject_ because these can be often interchanged. However, **their behavior is not the same when it comes to the complete signal**.

We can have a look at the same example as above but this time we'll use ReplaySubject and subscribe after receiving the complete notification from range:

```
// http://jsbin.com/hewomer/2/edit?js,console
const s = new ReplaySubject();
Observable.range(1, 5)
 .subscribe(s);

s.subscribe(console.log); // should this print anything?
```

This will print numbers 1 — 5. But why? Haven't we just learned that Subjects don't emit anything after receiving _complete_ which is sent automatically by range as we saw previously?

It's still true. **However, there are differences in Subject implementations.**

We can see the difference on a more general example. Let's say we want to cache a single item and then replay it to every new subscriber. Both BehaviorSubject and ReplaySubject will work in this use-case even though their usage isn't the same (BehaviorSubject has a default value). For example we could use them as follows:

```
// http://jsbin.com/hotidih/5/edit?js,console
const behavior = new BehaviorSubject(null);
const replay = new ReplaySubject(1);
behavior.skip(1).subscribe(v => console.log(‘BehaviorSubject:', v));
replay.subscribe(v => console.log(‘ReplaySubject:', v));
behavior.next(1);
behavior.next(2);
behavior.subscribe(v => console.log(‘Late B subscriber:', v));
replay.next(1);
replay.next(2);
behavior.subscribe(v => console.log(‘Late R subscriber:', v));
```

This example prints all the numbers twice. Once with "BehaviorSubject" prefix and then again with "ReplaySubject" prefix (note that we had to use the skip(1) operator to skip the default value coming from BehaviorSubject).

So why should we choose one over the other (in scenarios where performance is not an issue) and how is this related to Subject internal states?

It comes down to the fact how each of them work internally on subscription after they receive the complete notification:

- BehaviorSubject marks itself as stopped and never ever emits anything. Basically, it'll return an "empty" Subscription object that doesn't represent any real subscription.

- ReplaySubject first sends its entire buffer regardless of its internal state to the new subscriber and then returns an "empty" Subscription.

For us this means that we can "complete" ReplaySubject and later receive its items anyway. That's in contrast to BehaviorSubject that once it completes it will never emit anything.

We can take the same example from above and before subscribing the "late" subscriber emit complete:

```
// http://jsbin.com/wudiqor/3/edit?js,console
behavior.next(1);
behavior.next(2);
behavior.complete();
behavior.subscribe(v => console.log(‘Late B subscriber:', v));
replay.next(1);
replay.next(2);
replay.complete();
replay.subscribe(v => console.log(‘Late R subscriber:', v));
```

The "late" BehaviorSubject subscriber didn't receive any item because the Subject has already completed. On the other hand ReplaySubject will replay its buffer (the last item because we instantiated it as new ReplaySubject(1)) anyway so we'll see Late R subscriber: 2 in the console.

If we take the example from above with range(1, 5) yet again now it makes sense why ReplaySubject behaves differently than Subject. They both mark themselves as stopped just their subscription logic is different.

But don't get fooled. **The ReplaySubject is "stopped" as well. It won't emit any new items, it just replays its buffer on subscription.**

## What is all this good for in practise?

For example in Angular applications it's common to make an HTTP request and then cache the result during the entire application lifetime. A very straightforward approach is keeping the result in an object property and then just return it via Observable.of which allows us to consume it the same way is it was a real HTTP request:

```
class MyService {
  private cache: any;
  getData(): Observable<any> {
    if (this.cache) {
      return Observable.of(this.cache);
    } else {
      return this.http.get(...).do(r => this.cache = r);
    }
  }
}
```

Of course this works but there's a more "Rx" solution without using any state variable and using just ReplaySubject:

```
// http://jsbin.com/sutiwav/9/edit?js,console
class MyService {
  private cache = new ReplaySubject(1);
  getData(): Observable<any> {
    const http = this.http.get(...);
    const cache = this.cache;
    return Observable.merge(cache, http.do(cache)).take(1); // rxjs 5
    return merge(cache, http.do(cache)).pipe(take(1)); // rxjs 6
  }
}
const o = new MyService();
o.getData().subscribe(console.log);
o.getData().subscribe(console.log);
o.getData().subscribe(console.log);
```

This looks pretty weird, doesn't it? We could write this as a one-liner that merges our cache and the actual HTTP request and then always completes with _take(1)_.

Feel free to open the demo at http://jsbin.com/sutiwav/9/edit?js,console that simulates an HTTP request and you can see that this really works.

**So why this makes just a single request and then replays the cached result from cache?**

- The first subscriber receives an Observable that merges cache and http. Since cache is empty at this point it won't emit anything and merge will subscribe to http and wait until it emits an item. This item is using do pushed in the cache (the same expression as we did previously with .subscribe(s)). Then take(1) ensures after receiving a single item it emits complete and the chain is disposed.

- The second (and any other) subscriber receives an Observable that merges cache and http. When merge subscribes to cache it emits its buffer (it's a ReplaySubject(1) with a single item). This emission is propagated **immediately further where take(1) re-emits it and adds complete notification which disposes the chain. In other words, merge never subscribes to http which means we never make another HTTP request.**

There's one very interesting thing about this example. Our cache **never** receives the complete notification even though we're using do that sends complete as well. Anyway, this has no effect on the functionality of this code and it's related to the synchronous nature of RxJS internals.

That's why in the next article we'll talk about synchronous and asynchronous emissions in RxJS. We'll have a look at a few general examples and then come back to this demo and see what actually happened inside.

## Refs:

https://medium.com/@martin.sikora/rxjs-subjects-and-their-internal-state-7cfdee905156
