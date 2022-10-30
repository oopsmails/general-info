# RxJS – combineLatest vs merge Explained

## combineLatest won't start triggering an emission until all of its inner Observables emit at least once

**merge** and **combineLatest** operators are occasionally compared with each other. They both trigger an emission if one of their inner Observables emits data. The main difference is that the latter (combineLatest) won't start triggering an emission until all of its inner Observables emit at least once.

Suppose we have two sections: Section A and Section B. The former represents the behavior of the merge operator, and the latter represents the behavior of the combineLatest operator. For each section, there are two buttons we can click. Section A triggers a notification if we click either one of its buttons. Section B, however, won't start triggering a notification until we click both buttons at least once.

## forkjoin and combineLatest

- https://stackoverflow.com/questions/64874042/difference-between-forkjoin-and-combinelatest-rxjs

Both subscribe to all source Observables in parallel and whether they are asynchronous depends only on each source Observable.

So in this use-case you'll get the same result. If you used concat() instead you would see difference because concat() subscribes to sources in sequence one after antother.

The difference between forkJoin and combineLatest is that forkJoin will emit only once when all source Observable emit at least one item and complete while combineLatest will emit every time any of the source Observables emit after they've emitted at least once.

- https://stackoverflow.com/questions/41797439/rxjs-observable-combinelatest-vs-observable-forkjoin


Not only does forkJoin require all input observables to be completed, but it also returns an observable that produces a single value that is an array of the last values produced by the input observables. In other words, it waits until the last input observable completes, and then produces a single value and completes.

In contrast, combineLatest returns an Observable that produces a new value every time the input observables do, once all input observables have produced at least one value. This means it could have infinite values and may not complete. It also means that the input observables don't have to complete before producing a value.

## Refs

https://bansocode.com/combinelatest-and-merge/


